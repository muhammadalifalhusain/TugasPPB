import 'package:flutter/material.dart';
import 'db_helper.dart';// Sesuaikan dengan nama file yang tepat

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<Map<String, dynamic>>> _products;

  @override
  void initState() {
    super.initState();
    _products = DatabaseHelper().getAllProducts(); // Ambil data produk
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          }

          // Menampilkan data produk dalam bentuk ListView
          var products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.asset(product['image']), // Tampilkan gambar produk
                  title: Text(product['name']),
                  subtitle: Text('${product['category']} - \$${product['price']}'),
                  onTap: () {
                    // Tambahkan aksi yang diinginkan saat produk dipilih
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
