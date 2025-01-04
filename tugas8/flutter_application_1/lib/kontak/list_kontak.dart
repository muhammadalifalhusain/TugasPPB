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
// Menjalankan fungsi getAllKontak saat pertama kali dimuat
_getAllKontak();
super.initState();
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Center(
child: Text("Kontak App"),
),
),
body: ListView.builder(
itemCount: listKontak.length,
itemBuilder: (context, index) {
Kontak kontak = listKontak[index];
return Padding(
padding: const EdgeInsets.only(top: 20),
child: ListTile(
leading: Icon(
  Icons.person,
size: 50,
),
title: Text('${kontak.name}'),
subtitle: Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Padding(
padding: const EdgeInsets.only(top: 8),
child: Text("Email: ${kontak.email}"),
),
Padding(
padding: const EdgeInsets.only(top: 8),
child: Text("Phone: ${kontak.mobileNo}"),
),
Padding(
padding: const EdgeInsets.only(top: 8),
child: Text("Company: ${kontak.company}"),
),
],
),
trailing: FittedBox(
fit: BoxFit.fill,
child: Row(
children: [
// Button edit
IconButton(
onPressed: () {
_openFormEdit(kontak);
},
icon: Icon(Icons.edit),
),
// Button hapus
IconButton(
icon: Icon(Icons.delete),
onPressed: () {
// Membuat dialog konfirmasi hapus
AlertDialog hapus = AlertDialog(
title: Text("Information"),
content: Container(
height: 100,
child: Column(
children: [
Text("Yakin ingin MenghapusData\n\n${kontak.name}?")
],
),
),
actions: [
TextButton(
onPressed: () {
_deleteKontak(kontak, index);
Navigator.pop(context);
},
child: Text("Ya"),
),
TextButton(
child: Text('Tidak'),
onPressed: () {
Navigator.pop(context);
},
),
],
);
showDialog(
context: context,
builder: (context) => hapus,
);
},
),
],
),
),
),
);
},
),
// Membuat button mengapung di bagian bawah kanan layar
floatingActionButton: FloatingActionButton(
child: Icon(Icons.add),
onPressed: () {
_openFormCreate();
},
),
);
}
// Mengambil semua data Kontak
Future<void> _getAllKontak() async {
// List menampung data dari database
var list = await db.getAllKontak();
// Ada perubahan state
setState(() {
// Hapus data pada listKontak
listKontak.clear();
list!.forEach((kontak) {
// Masukan data ke listKontak
listKontak.add(Kontak.fromMap(kontak));
});
});
}
// Menghapus data Kontak
Future<void> _deleteKontak(Kontak kontak, int position) async {
await db.deleteKontak(kontak.id!);
setState(() {
listKontak.removeAt(position);
});
}
// Membuka halaman tambah Kontak
Future<void> _openFormCreate() async {
var result = await Navigator.push(
context,
MaterialPageRoute(builder: (context) => FormKontak()),
);
if (result == 'save') {
await _getAllKontak();
}
}
// Membuka halaman edit Kontak
Future<void> _openFormEdit(Kontak kontak) async {
var result = await Navigator.push(
context,
MaterialPageRoute(builder: (context) => FormKontak(kontak:
kontak)),
);
if (result == 'update') {
await _getAllKontak();
}
}
}