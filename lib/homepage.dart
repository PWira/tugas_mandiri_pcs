import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ui_ux_mandiri/menu/footer.dart';
import 'package:ui_ux_mandiri/menu/menu.dart';
import 'package:ui_ux_mandiri/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myItems = [
    Image.asset('assets/images/gunung.jpeg'),
    Image.asset('assets/images/pokemon.jpeg'),
    Image.asset('assets/images/spidersunda.jpeg'),
  ];

  int myCurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(5)),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayInterval: const Duration(seconds: 5),
                  initialPage: 3,
                  enlargeCenterPage: false,
                  aspectRatio: 16 / 9,
                  height: 200,
                  onPageChanged: (index, reason) {
                    setState(() {
                      myCurrentIndex = index;
                    });
                  },
                ),
                items: myItems,
              ),
              Divider(
                thickness: 2,
                color: Colors.black,
              ), // Garis batasan
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Selamat datang di PemulaAbiz! Kami dengan bangga mempersembahkan sebuah pengalaman yang unik dan inovatif untuk membuat tugas mandiri kami. Kami berkomitmen untuk memberikan pengalaman terbaik bagi Anda, karena setiap detail dirancang dengan penuh dedikasi demi memenuhi kebutuhan dan harapan Anda.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: 150,
                child: Image.asset(
                  "assets/images/animewall.png",
                  fit: BoxFit.cover,
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.black,
              ), // Garis batasan
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Selamat datang di PemulaAbiz! Kami dengan bangga mempersembahkan sebuah pengalaman yang unik dan inovatif untuk membuat tugas mandiri kami. Kami berkomitmen untuk memberikan pengalaman terbaik bagi Anda, karena setiap detail dirancang dengan penuh dedikasi demi memenuhi kebutuhan dan harapan Anda.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: 150,
                child: Image.asset(
                  "assets/images/animewall.png",
                  fit: BoxFit.cover,
                ),
              ),
              Divider(
                color: Colors.black,
              ), // Garis batasan
            ],
          ),
        ),
      bottomNavigationBar: Footer(),
      ),
    );
  }
}
