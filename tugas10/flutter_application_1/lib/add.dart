import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  // Inisialisasi field
  var title = TextEditingController();
  var content = TextEditingController();

  Future _onSubmit() async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:8000/create.php"),
        body: {
          "title": title.text,
          "content": content.text,
        },
      );

      var data = jsonDecode(response.body);
      print(data["message"]);

      // Menampilkan pesan sukses dan kembali ke halaman utama
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Note created successfully!')),
        );
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create note!')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred!')),
      );
    }
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget dihapus dari tree
    title.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Note"),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: title,
                decoration: InputDecoration(
                  hintText: "Type Note Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Note Title is Required!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Content',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: content,
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Type Note Content',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Note Content is Required!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _onSubmit();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
