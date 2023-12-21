import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "WELCOME TO HOMEPAGE",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            Container(
              height: 200,
              child: Image.asset(
                "assets/images/animewall.png",
                fit: BoxFit.cover,
              ),
            ),

            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Selamat datang di PemulaAbiz! Kami dengan bangga mempersembahkan sebuah pengalaman yang unik dan inovatif untuk membuat tugas mandiri kami. Kami berkomitmen untuk memberikan pengalaman terbaik bagi Anda, karena setiap detail dirancang dengan penuh dedikasi demi memenuhi kebutuhan dan harapan Anda.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context,'/post');
                    },
                    child: Text("Post"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Aksi tombol 2
                    },
                    child: Text("Tombol 2"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}