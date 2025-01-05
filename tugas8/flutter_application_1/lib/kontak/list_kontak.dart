import 'package:flutter/material.dart';
import 'form_kontak.dart';
import 'db_helper.dart';
import 'model_kontak.dart';

class ListKontakPage extends StatefulWidget {
  const ListKontakPage({super.key});

  @override
  State<ListKontakPage> createState() => _ListKontakPageState();
}

class _ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> listKontak = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    super.initState();
    _getAllKontak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Kontak App"))),
      body: ListView.builder(
        itemCount: listKontak.length,
        itemBuilder: (context, index) {
          Kontak kontak = listKontak[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              leading: Icon(Icons.person, size: 50),
              title: Text('${kontak.name}'),
              subtitle: _buildContactInfo(kontak),
              trailing: _buildActionButtons(kontak, index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _openFormCreate,
      ),
    );
  }

  Widget _buildContactInfo(Kontak kontak) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email: ${kontak.email}"),
        Text("Phone: ${kontak.mobileNo}"),
        Text("Company: ${kontak.company}"),
      ],
    );
  }

  Widget _buildActionButtons(Kontak kontak, int index) {
    return Row(
      children: [
        IconButton(onPressed: () => _openFormEdit(kontak), icon: Icon(Icons.edit)),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _showDeleteDialog(kontak, index),
        ),
      ],
    );
  }

  // Menampilkan dialog konfirmasi hapus
  void _showDeleteDialog(Kontak kontak, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Information"),
        content: Text("Yakin ingin menghapus ${kontak.name}?"),
        actions: [
          TextButton(
            onPressed: () {
              _deleteKontak(kontak, index);
              Navigator.pop(context);
            },
            child: Text("Ya"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tidak'),
          ),
        ],
      ),
    );
  }

  // Mengambil data kontak dari database
  Future<void> _getAllKontak() async {
    var list = await db.getAllKontak();
    setState(() {
      listKontak.clear();
      list!.forEach((kontak) {
        listKontak.add(Kontak.fromMap(kontak));
      });
    });
  }

  // Menghapus kontak dari database
  Future<void> _deleteKontak(Kontak kontak, int position) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(position);
    });
  }

  // Membuka form untuk tambah kontak
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormKontak()),
    );
    if (result == 'save') {
      await _getAllKontak();
    }
  }

  // Membuka form untuk edit kontak
  Future<void> _openFormEdit(Kontak kontak) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormKontak(kontak: kontak)),
    );
    if (result == 'update') {
      await _getAllKontak();
    }
  }
}
