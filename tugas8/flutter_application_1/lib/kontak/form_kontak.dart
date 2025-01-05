import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'model_kontak.dart';

class FormKontak extends StatefulWidget {
  final Kontak? kontak;
  FormKontak({this.kontak});

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  DbHelper db = DbHelper();
  TextEditingController? name;
  TextEditingController? mobileNo;
  TextEditingController? email;
  TextEditingController? company;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.kontak?.name ?? '');
    mobileNo = TextEditingController(text: widget.kontak?.mobileNo ?? '');
    email = TextEditingController(text: widget.kontak?.email ?? '');
    company = TextEditingController(text: widget.kontak?.company ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Kontak')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildTextField(name, 'Name'),
          _buildTextField(mobileNo, 'Mobile No'),
          _buildTextField(email, 'Email'),
          _buildTextField(company, 'Company'),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: Text(widget.kontak == null ? 'Add' : 'Update', style: TextStyle(color: Colors.white)),
              onPressed: upsertKontak,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController? controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  // Fungsi untuk menyimpan atau mengupdate kontak
  Future<void> upsertKontak() async {
    if (widget.kontak != null) {
      await db.updateKontak(Kontak.fromMap({
        'id': widget.kontak!.id,
        'name': name!.text,
        'mobileNo': mobileNo!.text,
        'email': email!.text,
        'company': company!.text,
      }));
      Navigator.pop(context, 'update');
    } else {
      await db.saveKontak(Kontak(
        name: name!.text,
        mobileNo: mobileNo!.text,
        email: email!.text,
        company: company!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
