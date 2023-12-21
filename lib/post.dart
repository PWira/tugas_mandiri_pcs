import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
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
                labelText: 'Judul',
              ),
            ),
            SizedBox(height: 16.0),

            // Konten
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Isi postingan',
              ),
            ),
            SizedBox(height: 16.0),

            // Gambar
            GestureDetector(
              onTap: () {
                // Tambahkan logika untuk memilih gambar
                print('Pilih gambar');
              },
              child: Container(
                height: 100.0,
                color: Colors.grey[200],
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 40.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Tombol Post
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk memposting
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
  }
}
