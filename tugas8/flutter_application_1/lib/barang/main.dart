import 'package:flutter/material.dart';
import 'barang_list.dart';
import 'db_helper.dart';
import 'barang_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input Data Barang',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const BarangInputPage(),
    );
  }
}

class BarangInputPage extends StatefulWidget {
  const BarangInputPage({super.key});

  @override
  State<BarangInputPage> createState() => _BarangInputPageState();
}

class _BarangInputPageState extends State<BarangInputPage> {
  final _dbHelper = DBHelper();
  final _formKey = GlobalKey<FormState>();
  final _kdBrgController = TextEditingController();
  final _nmBrgController = TextEditingController();
  final _hrgBeliController = TextEditingController();
  final _hrgJualController = TextEditingController();
  final _stokController = TextEditingController();

  Future<void> _addBarang() async {
    if (_formKey.currentState!.validate()) {
      final barang = Barang(
        kdBrg: _kdBrgController.text,
        nmBrg: _nmBrgController.text,
        hrgBeli: int.parse(_hrgBeliController.text),
        hrgJual: int.parse(_hrgJualController.text),
        stok: int.parse(_stokController.text),
      );
      await _dbHelper.insertBarang(barang);
      _kdBrgController.clear();
      _nmBrgController.clear();
      _hrgBeliController.clear();
      _hrgJualController.clear();
      _stokController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data barang berhasil ditambahkan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Barang'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              // Navigasi ke halaman tabel barang
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BarangList()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_kdBrgController, 'Kode Barang', 'Harap isi Kode Barang'),
              _buildTextField(_nmBrgController, 'Nama Barang', 'Harap isi Nama Barang'),
              _buildTextField(_hrgBeliController, 'Harga Beli', 'Harap isi Harga Beli', keyboardType: TextInputType.number),
              _buildTextField(_hrgJualController, 'Harga Jual', 'Harap isi Harga Jual', keyboardType: TextInputType.number),
              _buildTextField(_stokController, 'Stok', 'Harap isi Stok', keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addBarang,
                child: const Text('Tambah Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextField(TextEditingController controller, String label, String validationMessage, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: (value) => value == null || value.isEmpty ? validationMessage : null,
    );
  }
}
