void main() async {
  final lopList = await fetchLopList();
  for (var lop in lopList) {
    print('Lớp ${lop.ten} có sỉ số ${lop.siso}');
  }
}
