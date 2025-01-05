import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';  // Pastikan ini diimport untuk platform desktop
import './kontak/list_kontak.dart';  // Import halaman ListKontakPage

void main() {
  // Inisialisasi databaseFactoryFfi untuk platform desktop
  databaseFactory = databaseFactoryFfi;  // Pastikan ini untuk platform desktop (Windows, Linux, macOS)
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ListKontakPage(),  // Arahkan ke halaman ListKontakPage
    );
  }
}
