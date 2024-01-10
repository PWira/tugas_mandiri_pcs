import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DetailPostPage extends StatelessWidget {
  get context => null;

  Future loadPost() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.100.73/pcs_mandiri/view.php"));
      return jsonDecode(response.body);
    } catch (e) {
      print('Error loading post data: $e');
      throw e; // Rethrow the error to be caught by the FutureBuilder
    }
  }

  void showLoginDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Peringatan'),
        content: Text('Anda harus login untuk menggunakan fitur ini.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              post['title'] ?? '',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Image.network(
              "http://192.168.100.73/pcs_mandiri/${post['img']}",
              fit: BoxFit.cover,
              width: 300,
              height: 300,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return CircularProgressIndicator();
                }
              },
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                print("Error loading image: $error");
                return Icon(Icons.error); // Placeholder icon for error
              },
            ),
            SizedBox(height: 8.0),
            FutureBuilder(
              future: fetchTextFromServer("http://192.168.100.73/pcs_mandiri/${post['content']}"),
              builder: (context, textSnapshot) {
                try {
                  if (textSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (textSnapshot.hasError) {
                    return Text('Error loading content: ${textSnapshot.error}');
                  } else {
                    String contentText = textSnapshot.data as String;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                        ),
                        SizedBox(height: 4.0),
                        // Truncate the subtitle to 10-20 words
                        Text(
                          contentText,
                          style: TextStyle(color: Colors.black, fontSize: 14.0),
                        ),
                      ],
                    );
                  }
                } catch (e) {
                  print('Error: $e');
                  return Text('An error occurred.');
                }
              },
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
