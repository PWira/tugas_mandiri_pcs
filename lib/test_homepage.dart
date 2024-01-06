import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ui_ux_mandiri/menu/footer.dart';
import 'package:ui_ux_mandiri/menu/menu.dart';
import 'package:ui_ux_mandiri/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final hotThreads = [
    {
      'title': 'Thread 1 Title',
      'subtitle': 'Subtitle for Thread 1',
      'image': 'assets/images/gunung.jpeg',
    },
    {
      'title': 'Thread 2 Title',
      'subtitle': 'Subtitle for Thread 2',
      'image': 'assets/images/pokemon.jpeg',
    },
    {
      'title': 'Thread 3 Title',
      'subtitle': 'Subtitle for Thread 3',
      'image': 'assets/images/spidersunda.jpeg',
    },
  ];

  int myCurrentIndex = 0;
  bool isNewsLiked = false;

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width - 20.0;
    double imageHeight = 120.0;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("Dashboard"),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
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
                items: hotThreads.map((thread) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: cardWidth,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12.0),
                                ),
                                child: SizedBox(
                                  width: cardWidth,
                                  height: imageHeight,
                                  child: Center(
                                    child: Image.asset(
                                      thread['image']!,
                                      fit: BoxFit.cover,
                                      width: cardWidth,
                                      height: imageHeight,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      thread['title']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      thread['subtitle']!,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Selamat datang di PemulaAbiz! Kami dengan bangga mempersembahkan sebuah pengalaman yang unik dan inovatif untuk membuat tugas mandiri kami. Kami berkomitmen untuk memberikan pengalaman terbaik bagi Anda, karena setiap detail dirancang dengan penuh dedikasi demi memenuhi kebutuhan dan harapan Anda.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // News Container
              Container(
                width: cardWidth,
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12.0),
                        ),
                        child: SizedBox(
                          width: cardWidth,
                          height: imageHeight,
                          child: Center(
                            child: Image.asset(
                              'assets/images/gunung.jpeg',
                              fit: BoxFit.cover,
                              width: cardWidth,
                              height: imageHeight,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Breaking News Title",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "Subtitle for Breaking News",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(
                              isNewsLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                              color: isNewsLiked ? Colors.blue : null,
                            ),
                            onPressed: () {
                              // Handle like button press
                              setState(() {
                                isNewsLiked = !isNewsLiked;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.comment),
                            onPressed: () {
                              // Handle comment button press
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {
                              // Handle share button press
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              Container(
                width: cardWidth,
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12.0),
                        ),
                        child: SizedBox(
                          width: cardWidth,
                          height: imageHeight,
                          child: Center(
                            child: Image.asset(
                              'assets/images/pokemon.jpeg',
                              fit: BoxFit.cover,
                              width: cardWidth,
                              height: imageHeight,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Breaking News Title",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "Subtitle for Breaking News",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(
                              isNewsLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                              color: isNewsLiked ? Colors.blue : null,
                            ),
                            onPressed: () {
                              // Handle like button press
                              setState(() {
                                isNewsLiked = !isNewsLiked;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.comment),
                            onPressed: () {
                              // Handle comment button press
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {
                              // Handle share button press
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
