import 'dart:convert'; //json
import 'package:http/http.dart' as http;

final apiUrl = 'http://localhost:5000/api';//API ENDPOINT

Future<Map<String, dynamic>> sendData(Map<String, dynamic> data) async {
  final response = await http.post(apiUrl, body: jsonEncode(data));//보내고
  if (response.statusCode == 200) {//성공했으면
    final responseData = jsonDecode(response.body);//받기
    return responseData;
  } else {
    throw Exception('Failed to send data');
  }
}
