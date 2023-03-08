import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Hiển thị hộp thoại để chọn tệp.
  final filePickerResult = await FilePicker.platform.pickFiles();

  // Kiểm tra xem người dùng đã chọn tệp hay chưa.
  if (filePickerResult != null) {
    // Gửi yêu cầu tải lên lên server HTTP.
    final request =
        http.MultipartRequest('POST', Uri.parse('https://example.com/upload'));

    final file = File(filePickerResult.files.single.path);
    final stream = http.ByteStream(file.openRead());
    final length = await file.length();
    final multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);

    final response = await request.send();
    final body = await response.stream.bytesToString();
    print(body);
  }
}
