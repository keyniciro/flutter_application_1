import 'package:flutter/material.dart';
import '../models/krs_course.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key, required this.course});

  final KrsCourse course;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(course.code)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course.name,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(course.lecturer,
                style: TextStyle(color: colors.onSurfaceVariant)),
            const SizedBox(height: 24),
            Text(course.description.isNotEmpty
                ? course.description
                : 'Belum ada deskripsi silabus untuk mata kuliah ini.'),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali ke Daftar KRS'),
            ),
          ],
        ),
      ),
    );
  }
}