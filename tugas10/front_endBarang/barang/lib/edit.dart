import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';

class Edit extends StatefulWidget {
  final String id;
  final Function refreshData;

  Edit({required this.id, required this.refreshData});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final TextEditingController _kdBrgController = TextEditingController();
  final TextEditingController _nmBrgController = TextEditingController();
  final TextEditingController _hrgBeliController = TextEditingController();
  final TextEditingController _hrgJualController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  // Fungsi untuk mengambil data barang berdasarkan Kode Barang
  Future<void> _getBarang() async {
    final String url =
        "http://localhost:8000/detail.php";

    try {
      final response = await http.post(Uri.parse(url), body: {
        'Kode': widget.id,
      });

      final data = jsonDecode(response.body);

      if (data != null && data['Kode'] != null) {
        setState(() {
          _kdBrgController.text = data['Kode'];
          _nmBrgController.text = data['NamaBarang'];
          _hrgBeliController.text = data['HargaBeli'].toString();
          _hrgJualController.text = data['HargaJual'].toString();
          _stokController.text = data['Stok'].toString();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Barang tidak ditemukan."),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print("Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Terjadi kesalahan, tidak dapat mengambil data barang."),
        backgroundColor: Colors.red,
      ));
    }
  }

  // Fungsi untuk mengupdate data barang
  Future<void> _updateBarang() async {
    final String url =
        "http://localhost:8000/update.php";

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
        content: Text("Barang berhasil diperbarui!"),
        backgroundColor: Colors.green,
      ));
      widget.refreshData(); // Memanggil fungsi refresh data setelah update
      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Gagal memperbarui barang."),
        backgroundColor: Colors.red,
      ));
    }
  }

  // Fungsi untuk menghapus barang
  Future<void> _hapusBarang() async {
    final String url =
        "http://localhost:8000/delete.php";

    final response = await http.post(Uri.parse(url), body: {
      'Kode': _kdBrgController.text,
    });

    // Print raw response to debug
    print('Response body: ${response.body}');

    try {
      final data = jsonDecode(response.body);

      if (data['message'] == "Data delete successfully") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Barang berhasil dihapus!"),
          backgroundColor: Colors.green,
        ));

        // Call the refresh data function
        widget.refreshData();

        // Navigate to Home after successful deletion
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()), // Navigate to Home
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Gagal menghapus barang."),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print("Error decoding JSON: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Terjadi kesalahan saat memproses data."),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _getBarang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Barang'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: _kdBrgController,
              label: 'Kode Barang',
              enabled: false,
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateBarang,
              child: Text('Update Barang'),
            ),
            SizedBox(height: 10), // Space between buttons
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Konfirmasi Hapus'),
                      content: Text('Apakah Anda yakin ingin menghapus barang ini?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            _hapusBarang();
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: Text('Hapus'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Set background color
              ),
              child: Text(
                'Hapus',
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat text field dengan label dan controller
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          fillColor: Colors.white,
          filled: true,
        ),
        enabled: enabled,
        keyboardType: keyboardType,
      ),
    );
  }
}
