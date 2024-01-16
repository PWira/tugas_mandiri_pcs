import 'dart:convert';
import 'package:http/http.dart' as http;


var connector = "192.168.100.73";

getHttpC(){
  return connector;
}

class HttpConnector {
  String baseUrl = connector;

  HttpConnector(this.baseUrl);

  Future<String?> requestToken(String username) async {
    try {
      final response = await http.post(
        Uri.parse('http://${baseUrl}/db_query.php'),
        body: {'username': username},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return data['token'];
      } else {
        print('Failed to request token. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error requesting token: $e');
      return null;
    }
  }
}