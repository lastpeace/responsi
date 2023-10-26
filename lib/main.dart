import 'package:flutter/material.dart';
import 'package:responsi/ui/tugas_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Daftar Tugas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const TugasPage(),
    );
  }
}
