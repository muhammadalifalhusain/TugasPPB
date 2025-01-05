import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add.dart';
import 'edit.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // Define a list to store data from the database
  List<Map<String, dynamic>> notes = [];
  
  // Colors for the cards
  final _lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100
  ];

  @override
  void initState() {
    super.initState();
    // Fetch data from API when the page is initialized
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(
        "http://localhost:8000/list.php"
      ));
      
      // If the response is successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        setState(() {
          notes = List<Map<String, dynamic>>.from(data); // Ensure the list is of the correct type
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note List'),
        foregroundColor: Colors.white,
      ),
      body: notes.isNotEmpty
        ? MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to the edit page and pass the note ID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Edit(id: notes[index]['id']),
                    ),
                  );
                },
                child: Card(
                  color: _lightColors[index % _lightColors.length],
                  child: Container(
                    constraints: BoxConstraints(minHeight: (index % 2 + 1) * 85),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${notes[index]['date']}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${notes[index]['title']}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Text(
              "No Data Available",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Add()),
          );
        },
      ),
    );
  }
}
