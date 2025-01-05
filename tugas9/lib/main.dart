import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Menambahkan beberapa produk default
  final dbHelper = DatabaseHelper();
  await dbHelper.insertProduct({
    'name': 'Ruang Tamu',
    'category': 'Furniture',
    'price': 23000000,
    'image': 'assets/images/foto1.jpg', // Pastikan ada gambar ini di folder assets
  });
  await dbHelper.insertProduct({
    'name': 'Kursi Belajar',
    'category': 'Furniture',
    'price': 1200000,
    'image': 'assets/images/foto2.jpg', // Pastikan ada gambar ini di folder assets
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Produk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          },
          child: Text('Pergi ke Dashboard'),
        ),
      ),
    );
  }
}
