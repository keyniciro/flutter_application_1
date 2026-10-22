import 'package:flutter/material.dart';
import 'screens/krs_list_screen.dart';

class Modul03App extends StatelessWidget {
  const Modul03App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 03 — Navigasi Dasar & Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
        ),
        useMaterial3: true,
      ),
      home: const KrsListScreen(),
    );
  }
}