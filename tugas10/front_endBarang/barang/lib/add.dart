import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Add extends StatefulWidget {
  final Function refreshData;

  Add({required this.refreshData});

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _kdBrgController = TextEditingController();
  final TextEditingController _nmBrgController = TextEditingController();
  final TextEditingController _hrgBeliController = TextEditingController();
  final TextEditingController _hrgJualController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  // Fungsi untuk menambahkan data barang
  Future<void> _addBarang() async {
    final String url = "http://localhost:8000/create.php";
    final response = await http.post(Uri.parse(url), body: {
      'Kode': _kdBrgController.text,
      'NamaBarang': _nmBrgController.text,
      'HargaBeli': _hrgBeliController.text,
      'HargaJual': _hrgJualController.text,
      'Stok': _stokController.text,
    });

    final data = jsonDecode(response.body);

    if (data['success'] == 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Barang berhasil ditambahkan!"),
        backgroundColor: const Color.fromARGB(255, 16, 33, 142),
      ));
      widget.refreshData(); // Memanggil fungsi refresh data setelah barang ditambahkan
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Gagal menambahkan barang."),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Barang'),
        centerTitle: true,
        backgroundColor: Colors.brown, // Menggunakan warna coklat pada AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _kdBrgController,
                label: 'Kode Barang',
              ),
              _buildTextField(
                controller: _nmBrgController,
                label: 'Nama Barang',
              ),
              _buildTextField(
                controller: _hrgBeliController,
                label: 'Harga Beli',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _hrgJualController,
                label: 'Harga Jual',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _stokController,
                label: 'Stok',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _addBarang,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown, // Warna tombol coklat
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Tambah Barang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membuat text field dengan label dan controller
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.brown, // Coklat untuk label
            fontWeight: FontWeight.w600,
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.brown, width: 1), // Coklat untuk border
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
