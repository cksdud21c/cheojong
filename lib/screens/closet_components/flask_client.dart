import 'dart:convert';
import 'package:http/http.dart' as http;

class FlaskClient {
  Future<List<String>> getClothingItems(String category, String id) async {
    var url = Uri.parse('http://35.184.46.56:5000/closet');
    var data = {'ID': id,'category': category};
    var body = json.encode(data);

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<String> itemUrls = List<String>.from(jsonResponse['itemUrls']);
      return itemUrls;
    } else {
      throw Exception('Failed to get clothing items from server');
    }
  }
}



