import 'package:flutter/material.dart';

import '../models/announcement.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({
    super.key,
    required this.announcement,
  });

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengumuman'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Chip(
              label: Text(announcement.category),
              avatar: const Icon(Icons.category_outlined),
            ),
            const SizedBox(height: 16),
            Text(
              announcement.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const Icon(Icons.person_outline, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(announcement.author),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                const Icon(Icons.calendar_today_outlined, size: 18),
                const SizedBox(width: 8),
                Text(announcement.date),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                const Icon(Icons.visibility_outlined, size: 20),
                const SizedBox(width: 8),
                Text('${announcement.readCount} kali dibaca'),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Isi Pengumuman',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              announcement.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}