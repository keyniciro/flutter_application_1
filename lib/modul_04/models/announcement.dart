class Announcement {
  final int id;
  final String title;
  final String content;
  final String author;
  final String category;
  final String date;
  final int readCount;

  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.category,
    required this.date,
    required this.readCount,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String? ?? 'Tanpa Judul',
      content: json['content'] as String? ?? json['body'] as String? ?? '',
      author: json['author'] as String? ?? 'Admin Jurusan',
      category: json['category'] as String? ?? 'Akademik',
      date: json['date'] as String? ?? '2026-09-01',
      readCount: json['readCount'] is int ? json['readCount'] as int : 0,
    );
  }

  static List<Announcement> getSampleAnnouncements() {
    return const <Announcement>[
      Announcement(
        id: 1,
        title: 'Informasi Perkuliahan',
        content: 'Informasi jadwal perkuliahan untuk mahasiswa TRPL.',
        author: 'Admin Jurusan',
        category: 'Akademik',
        date: '2026-09-01',
        readCount: 0,
      ),
      Announcement(
        id: 2,
        title: 'Informasi Beasiswa',
        content: 'Informasi terbaru mengenai program beasiswa mahasiswa.',
        author: 'Admin Jurusan',
        category: 'Beasiswa',
        date: '2026-09-02',
        readCount: 0,
      ),
      Announcement(
        id: 3,
        title: 'Kegiatan Mahasiswa',
        content: 'Informasi kegiatan mahasiswa jurusan TRPL.',
        author: 'Admin Jurusan',
        category: 'Kegiatan',
        date: '2026-09-03',
        readCount: 0,
      ),
      Announcement(
        id: 4,
        title: 'Prestasi Mahasiswa',
        content: 'Informasi prestasi mahasiswa jurusan TRPL.',
        author: 'Admin Jurusan',
        category: 'Prestasi',
        date: '2026-09-04',
        readCount: 0,
      ),
    ];
  }
}
