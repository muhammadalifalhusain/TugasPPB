import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  const WelcomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 24, // Ukuran teks lebih besar
                fontWeight: FontWeight.bold, // Huruf tebal
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nama Lengkap: ${user['full_name']}',
              style: TextStyle(
                fontSize: 18, // Ukuran teks lebih besar
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Username: ${user['username']}',
              style: TextStyle(
                fontSize: 18, // Ukuran teks lebih besar
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Password: ${user['password']}',
              style: TextStyle(
                fontSize: 18, // Ukuran teks lebih besar
              ),
            ),
          ],
        ),
      ),
    );
  }
}
