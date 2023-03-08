class Lop {
  String? ten;
  int? siso;

  Lop({this.ten, this.siso});

  factory Lop.fromJson(Map<String, dynamic> json) {
    return Lop(
      ten: json['ten'],
      siso: json['siso'],
    );
  }
}
