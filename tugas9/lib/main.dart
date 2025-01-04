import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Pastikan file dashboard_screen.dart ada di direktori yang sama atau sesuai dengan struktur proyek Anda

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Saya',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Halaman utama yang pertama kali muncul
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
            // Arahkan ke halaman DashboardScreen
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
