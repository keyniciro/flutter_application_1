import 'package:flutter/material.dart';
import '../models/krs_course.dart';

class KrsCourseTile extends StatelessWidget {
  const KrsCourseTile({
    super.key,
    required this.course,
    required this.onTap,
    required this.onDelete,
  });

  final KrsCourse course;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: colors.primaryContainer,
          foregroundColor: colors.onPrimaryContainer,
          child: Text(
            '${course.sks}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          course.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${course.code} • ${course.lecturer}'),
        trailing: IconButton(
          tooltip: 'Hapus ${course.code}',
          icon: Icon(Icons.delete_outline, color: colors.error),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}