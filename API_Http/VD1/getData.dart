import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';

Future<List<Lop>> fetchLopList() async {
  final response = await http.get('https://example.com/api/lophoc');
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    final List<dynamic> data = parsed['data']['lophoc'];
    return data.map((json) => Lop.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load lop list');
  }
}
