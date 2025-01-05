import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final String id; // Make this final to adhere to @immutable rules.

  Edit({required this.id}); // Constructor requires id to be passed when creating Edit widget.

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  // Initialize field
  late TextEditingController title;
  late TextEditingController content;

  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    content = TextEditingController();
    _getData();
  }

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
  }

  // Http to get detail data
  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
        "http://localhost:8000/detail.php?id=${widget.id}"));
      // if response successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          title = TextEditingController(text: data['title']);
          content = TextEditingController(text: data['content']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onUpdate(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:8000/update.php"),
        body: {
          "id": widget.id,
          "title": title.text,
          "content": content.text,
        },
      );

      var data = jsonDecode(response.body);
      print(data["message"]);
      
      if (response.statusCode == 200) {
        // Provide feedback and navigate back
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Note updated successfully!')));
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        // Provide feedback in case of failure
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update note!')));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred!')));
    }
  }

  Future _onDelete(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:8000/delete.php"),
        body: {
          "id": widget.id,
        },
      );

      var data = jsonDecode(response.body);
      print(data["message"]);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Note deleted successfully!')));
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete note!')));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        foregroundColor: Colors.white,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('Are you sure you want to delete this?'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Icon(Icons.cancel),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        ElevatedButton(
                          child: Icon(Icons.check_circle),
                          onPressed: () => _onDelete(context),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
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
                style: TextStyle(
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
              SizedBox(height: 20),
              Text(
                'Content',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
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
                style: TextStyle(
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
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _onUpdate(context);
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
