import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DetailPostPage extends StatelessWidget {
  Future loadPost() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.100.73/pcs_mandiri/view.php"));
      return jsonDecode(response.body);
    } catch (e) {
      print('Error loading post data: $e');
      throw e; // Rethrow the error to be caught by the FutureBuilder
    }
  }

  Future<String> fetchTextFromServer(String contentPath) async {
    final response = await http.get(Uri.parse(contentPath));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load text from server');
    }
  }
  final Map<String, dynamic> post;

  const DetailPostPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post['title'] ?? '',),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['title'] ?? '',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              post['subtitle'] ?? '',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            // Tampilkan seluruh isi subtitle, like, dan komentar di sini
            // ...
          ],
        ),
      ),
    );
  }
}
