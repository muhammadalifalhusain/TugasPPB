class Kontak {
  int? id;
  String? name;
  String? mobileNo;
  String? email;
  String? company;

  Kontak({this.id, this.name, this.mobileNo, this.email, this.company});

  // Convert object to map
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    map['name'] = name;
    map['mobileNo'] = mobileNo;
    map['email'] = email;
    map['company'] = company;
    return map;
  }

  // Convert map to object
  Kontak.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    mobileNo = map['mobileNo'];
    email = map['email'];
    company = map['company'];
  }
}
