import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ui_ux_mandiri/menu/footer.dart';
import 'package:ui_ux_mandiri/menu/menu.dart';
import 'package:ui_ux_mandiri/pages/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        child: FutureBuilder(
                          future: loadPost(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print('Error: ${snapshot.error}');
                              return Center(child: Text('Error loading data. Please try again later.'));
                            }

                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            List<dynamic> dataList = snapshot.data as List<dynamic>;

                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: dataList.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> post = dataList[index];

                                return Card(
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
                                            child: Image.network(
                                              "http://192.168.100.73/pcs_mandiri/${post['img']}",
                                              fit: BoxFit.cover,
                                              width: cardWidth,
                                              height: imageHeight,
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
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                post['title'] ?? '',
                                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(height: 4.0),
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
                                                    return Text(
                                                      contentText,
                                                      style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                                    );
                                                  }
                                                } catch (e) {
                                                  print('Error: $e');
                                                  return Text('An error occurred.');
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
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
              // news container
              Container(
              width: cardWidth,
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: FutureBuilder(
                future: loadPost(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(child: Text('Error loading data. Please try again later.'));
                  }

                  if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return Center(child: Text('Tidak ada yang melakukan posting.'));
                  }

                  List<dynamic> dataList = snapshot.data as List<dynamic>;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> post = dataList[index];

                      return Card(
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
                                  child: Image.network(
                                    "http://192.168.100.73/pcs_mandiri/${post['img']}",
                                    fit: BoxFit.cover,
                                    width: cardWidth,
                                    height: imageHeight,
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
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      post['title'] ?? '',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
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
                                          return Text(
                                            contentText,
                                            style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                          );
                                        }
                                      } catch (e) {
                                        print('Error: $e');
                                        return Text('An error occurred.');
                                      }
                                    },
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
                      );
                    },
                  );
                },
              ),
            ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostPage()));
        },
      ),
      bottomNavigationBar: Footer(),
      ),
    );
  }
}
