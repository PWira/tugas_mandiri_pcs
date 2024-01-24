import 'dart:convert';
import 'package:http/http.dart' as http;


var connector = "liniapp.000webhostapp.com";
var httpOrS = 'http://';

getHttpC(){
  return connector;
}
getHttpFormat(){
  return httpOrS;
}

class HttpConnector {
  String baseUrl = connector;
  String baseFormat = httpOrS;

  HttpConnector(this.baseUrl);

  Future<String?> requestToken(String username) async {
    try {
      final response = await http.post(
        Uri.parse('$baseFormat$baseUrl/db_query.php'),
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