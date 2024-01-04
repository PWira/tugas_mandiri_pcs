import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

Future<File?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    print('No image selected.');
    return null;
  }
}

class _PostPageState extends State<PostPage> {
  File? _image;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  Future<void> postImage(File imageFile, String title, String content) async {
  // final response = 'http://192.168.2.19/pcs_mandiri/post.php'; // Ganti dengan response server Anda
  final request = http.MultipartRequest('POST', Uri.parse("http://192.168.100.73/pcs_mandiri/post.php"));

  final response = await http.post(Uri.parse("http://192.168.100.73/pcs_mandiri/post.php"),
  body:{request.files.add(await http.MultipartFile.fromPath('img', imageFile.path)),
  request.fields['title'] = title,
  request.fields['content'] = content,});


  print("Upload response status code: ${response.statusCode}");
  print("Register response body: ${response.body}");
  handleResponse(response, 'Upload');
}

  void handleResponse(http.Response response, String action) {
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        print('Upload Successful');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload Successful!')),
        );
        Navigator.pop(context);
      } else {
        print('$action failed: ${data['message']}');
        // Display error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data['message']}')),
        );
      }
    } else {
      print('Failed to connect to the server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Judul
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),

            // Konten
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: 'Text (optional)',
              ),
            ),
            SizedBox(height: 16.0),

            // Gambar
            GestureDetector(
              onTap: () async {
                File? image = await pickImage();
                if (image != null) {
                  setState(() {
                    _image = image;
                  });
                }
              },
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: Center(
                  child: _image == null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.camera_alt,
                            size: 40.0,
                            color: Colors.grey,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            _image!,
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Tombol Post
            ElevatedButton(
              onPressed: () {
                _post();
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }

  void _post() {
    // Mengirim data ke server
    String title = _titleController.text;
    String content = _contentController.text;

    // Posting
    print('Posting: $title - $content');

    if (_image != null) {
      // Image to server
      postImage(_image!, title, content);
    }
    Navigator.pop(context);
  }
}