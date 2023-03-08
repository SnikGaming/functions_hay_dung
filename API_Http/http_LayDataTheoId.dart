import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
  final jsonData = jsonDecode(response.body);
  print(jsonData);
}
// Phương thức `http.get()` được sử dụng để gửi yêu cầu GET đến URL được cung cấp.
// Phương thức `jsonDecode()` được sử dụng để chuyển đổi dữ liệu JSON (chứa trong phản hồi) thành một đối tượng Dart map.
// `await` được sử dụng để đợi phản hồi trả về trước khi tiếp tục thực hiện các câu lệnh khác trong hàm `main()`.
// Dữ liệu JSON được in ra màn hình sử dụng phương thức `print()`.
