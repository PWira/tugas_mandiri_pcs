// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;

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
  final myItems = [
    Image.asset('assets/images/gunung.jpeg'),
    Image.asset('assets/images/pokemon.jpeg'),
    Image.asset('assets/images/spidersunda.jpeg'),
  ];

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
              FutureBuilder(
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
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> post = dataList[index];

                      return ListTile(
                        isThreeLine: true,
                        title: Align(
                          alignment: Alignment.center,
                          child: Text(post['title'] ?? '',style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),)
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                    return Text(contentText);
                                  }
                                } catch (e) {
                                  print('Error: $e');
                                  return Text('An error occurred.');
                                }
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Image.network(
                                "http://192.168.100.73/pcs_mandiri/${post['img']}",
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
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              Divider(
                color: Colors.black,
              ), // Garis batasan
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
