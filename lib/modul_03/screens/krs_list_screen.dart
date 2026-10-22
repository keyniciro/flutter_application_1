import 'package:flutter/material.dart';

import '../models/krs_course.dart';
import 'add_krs_screen.dart';
import 'course_detail_screen.dart';

const int batasSksSemester = 24;
const int ambangPeringatanSks = 21;

class KrsListScreen extends StatefulWidget {
  const KrsListScreen({super.key});

  @override
  State<KrsListScreen> createState() => _KrsListScreenState();
}

class _KrsListScreenState extends State<KrsListScreen> {
  final List<KrsCourse> _courses =
      List<KrsCourse>.of(KrsCourse.getInitialCourses());

  int get _totalSks =>
      _courses.fold(0, (jumlah, course) => jumlah + course.sks);

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  void _bukaDetail(KrsCourse course) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => CourseDetailScreen(course: course),
      ),
    );
  }

  Future<void> _bukaFormTambah() async {
    final KrsCourse? courseBaru = await Navigator.push<KrsCourse>(
      context,
      MaterialPageRoute<KrsCourse>(
        builder: (_) => const AddKrsScreen(),
      ),
    );

    if (!mounted || courseBaru == null) return;

    final bool duplikat = _courses.any(
      (course) =>
          course.code.toUpperCase() == courseBaru.code.toUpperCase(),
    );

    if (duplikat) {
      _tampilkanPesan(
        'Kode ${courseBaru.code} sudah ada di rencana studi.',
      );
      return;
    }

    final int totalBaru = _totalSks + courseBaru.sks;

    if (totalBaru > batasSksSemester) {
      _tampilkanPesan(
        'Total SKS akan menjadi $totalBaru, '
        'melebihi batas $batasSksSemester SKS.',
      );
      return;
    }

    setState(() {
      _courses.add(courseBaru);
    });

    _tampilkanPesan(
      '${courseBaru.name} ditambahkan ke rencana studi.',
    );
  }

  Future<void> _konfirmasiHapus(KrsCourse course) async {
    final Color errorColor = Theme.of(context).colorScheme.error;

    final bool? dikonfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus mata kuliah?'),
        content: Text(
          'Yakin ingin membatalkan pengambilan '
          '"${course.name}" (${course.sks} SKS)?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, false);
            },
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: errorColor,
            ),
            onPressed: () {
              Navigator.pop(dialogContext, true);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (!mounted || dikonfirmasi != true) return;

    setState(() {
      _courses.removeWhere(
        (item) => item.code == course.code,
      );
    });

    _tampilkanPesan(
      '${course.name} dihapus dari rencana studi.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rencana Studi (KRS)'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Total SKS'),
              subtitle: Text(
                _totalSks >= ambangPeringatanSks
                    ? 'Beban SKS sudah mendekati batas.'
                    : 'Batas maksimal $batasSksSemester SKS.',
              ),
              trailing: Text(
                '$_totalSks/$batasSksSemester',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _totalSks >= ambangPeringatanSks
                      ? warna.error
                      : warna.primary,
                ),
              ),
            ),
          ),
          Expanded(
            child: _courses.isEmpty
                ? const Center(
                    child: Text('Belum ada mata kuliah.'),
                  )
                : ListView.builder(
                    itemCount: _courses.length,
                    itemBuilder: (context, index) {
                      final KrsCourse course = _courses[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          title: Text(course.name),
                          subtitle: Text(
                            '${course.code} • ${course.sks} SKS',
                          ),
                          onTap: () => _bukaDetail(course),
                          trailing: IconButton(
                            tooltip: 'Hapus mata kuliah',
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              _konfirmasiHapus(course);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaFormTambah,
        tooltip: 'Tambah mata kuliah',
        child: const Icon(Icons.add),
      ),
    );
  }
}