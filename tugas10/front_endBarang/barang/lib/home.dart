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
  // Variable untuk menyimpan data barang
  List _get = [];

  // Warna yang digunakan untuk setiap card (lebih gelap dan netral)
  final _lightColors = [
    Colors.grey.shade400,      // Abu-abu netral
    Colors.brown.shade200,     // Coklat muda
    Colors.blueGrey.shade200,  // Biru abu-abu
    Colors.green.shade300,     // Hijau gelap
    Colors.teal.shade300,      // Teal gelap
    Colors.indigo.shade300,    // Biru indigo gelap
  ];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  // Fungsi untuk mengambil data barang
  Future _getData() async {
    try {
      final response = await http.get(Uri.parse("http://localhost:8000/list.php"));

      // Jika respon berhasil
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _get = data;
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
        title: Text('Data Barang'),
        backgroundColor: Colors.grey.shade800, // Warna AppBar lebih gelap
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: _get.isNotEmpty
          ? MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: _get.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edit(
                          id: _get[index]['Kode'],
                          refreshData: _getData, // Menambahkan refreshData
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: _lightColors[index % _lightColors.length], // Variasi warna card
                    elevation: 5, // Sedikit shadow pada card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Barang: ${_get[index]['NamaBarang']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Harga Jual: ${_get[index]['HargaJual']}',
                            style: TextStyle(
                              color: Colors.white70, // Warna teks sedikit lebih terang
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "No Data Available",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade800, // Warna tombol dengan warna gelap
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Add(
                refreshData: _getData, // Menambahkan refreshData
              ),
            ),
          );
        },
      ),
    );
  }
}
