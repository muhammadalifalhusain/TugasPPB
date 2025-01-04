class Barang {
final int? id;
final String kdBrg;
final String nmBrg;
final int hrgBeli;
final int hrgJual;
final int stok;
Barang({
this.id,
required this.kdBrg,
required this.nmBrg,
required this.hrgBeli,
required this.hrgJual,
required this.stok,
});
Map<String, dynamic> toMap() {
return {
'id': id,
'kdBrg': kdBrg,
'nmBrg': nmBrg,
'hrgBeli': hrgBeli,
'hrgJual': hrgJual,
'stok': stok,
};
}
factory Barang.fromMap(Map<String, dynamic> map) {
return Barang(
  id: map['id'],
kdBrg: map['kdBrg'],
nmBrg: map['nmBrg'],
hrgBeli: map['hrgBeli'],
hrgJual: map['hrgJual'],
stok: map['stok'],
);
}
}