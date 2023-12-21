import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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

Future<void> postImage(File imageFile) async {
  final url = 'YOUR_SERVER_ENDPOINT'; // Replace with your server endpoint

  // Create a multipart request
  var request = http.MultipartRequest('POST', Uri.parse(url));

  // Attach the file
  request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

  // Send the request
  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostPage(),
    );
  }
}

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  File? _image;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
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
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),

            // Konten
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
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
                color: Colors.grey[200],
                child: Center(
                  child: _image == null
                      ? Icon(
                          Icons.camera_alt,
                          size: 40.0,
                          color: Colors.grey,
                        )
                      : Image.file(
                          _image!,
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.cover,
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
    // Tambahkan logika untuk memposting, misalnya mengirim data ke server
    String title = _titleController.text;
    String content = _contentController.text;

    // Simpan logika posting disini
    print('Posting: $title - $content');

    if (_image != null) {
      // Post the image to the server
      postImage(_image!);
    }
  }
}
