import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'barang_model.dart';

class BarangList extends StatefulWidget {
const BarangList({super.key});
@override
State<BarangList> createState() => _BarangListState();
}
class _BarangListState extends State<BarangList> {
final _dbHelper = DBHelper();
List<Barang> _barangList = [];
Future<void> _loadBarang() async {
final barang = await _dbHelper.fetchBarang();
setState(() {
_barangList = barang;
});
}
@override
void initState() {
super.initState();
_loadBarang();
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Tabel Data Barang'),
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: SingleChildScrollView(
scrollDirection: Axis.horizontal,
child: DataTable(
columnSpacing: 20,
columns: const [
DataColumn(label: Text('KdBrg', style:

TextStyle(fontWeight: FontWeight.bold))),

DataColumn(label: Text('NmBrg', style:

TextStyle(fontWeight: FontWeight.bold))),

DataColumn(label: Text('HrgBeli', style:

TextStyle(fontWeight: FontWeight.bold))),

DataColumn(label: Text('HrgJual', style:

TextStyle(fontWeight: FontWeight.bold))),

DataColumn(label: Text('Stok', style:

TextStyle(fontWeight: FontWeight.bold))),

],
rows: _barangList.map((barang) {
  return DataRow(
cells: [
DataCell(Text(barang.kdBrg)),
DataCell(Text(barang.nmBrg)),
DataCell(Text(barang.hrgBeli.toString())),
DataCell(Text(barang.hrgJual.toString())),
DataCell(Text(barang.stok.toString())),
],
);
}).toList(),
),
),
),
);
}
}