import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ui_ux_mandiri/env/http_connector.dart';
import 'package:ui_ux_mandiri/menu/footer.dart';
import 'package:ui_ux_mandiri/menu/menu.dart';
import 'package:ui_ux_mandiri/pages/detailpostpage.dart';
import 'package:ui_ux_mandiri/pages/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final httpC = getHttpC();
  Set<String> likedPosts = Set<String>();

  Future loadPost() async {
    try {
      final response = await http.get(Uri.parse("http://${httpC}/pcs_mandiri/view.php"));
      return jsonDecode(response.body);
    } catch (e) {
      print('Error loading post data: $e');
      throw e;
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


  Future<void> sendLikeRequest(String pid, int jumlahlike) async {
  final response = await http.post(
    Uri.parse('http://${httpC}/pcs_mandiri/post.php'),
    body: {
      'pid': pid,
      'jumlahlike': jumlahlike.toString(),
    },
  );

  if (response.statusCode != 200) {
    print('Failed to send like/dislike request. Status code: ${response.statusCode}');
    }
  }

  void _handleLikeButtonPress(Map<String, dynamic> post) async {
  int likeChange = likedPosts.contains(post['pid']) ? -1 : 1;

  await sendLikeRequest(post['pid'], likeChange);

  setState(() {
    post['jumlahlike'] = (int.parse(post['jumlahlike'] ?? '0') + likeChange).toString();

    if (!likedPosts.contains(post['pid'])) {
      likedPosts.add(post['pid']);
    } else {
      likedPosts.remove(post['pid']);
    }
  });
  }

   void _showPopupMenu(BuildContext context, Map<String, dynamic> post) async {
    final dropChoice = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 0.0),
      items: [
        PopupMenuItem<String>(
          value: 'share',
          child: Text('Share'),
        ),
        PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
    );
    switch (dropChoice) {
      case 'share':
        // Handle share
        break;
      case 'delete':
        _handleDeleteButtonPress(post);
        break;
      default:
        break;
    }
  }

  Future<void> _handleDeleteButtonPress(Map<String, dynamic> post) async {
    bool confirmDelete = await _showDeleteConfirmationDialog();
    
    if (confirmDelete) {
      await sendDeleteRequest(post['pid']);
      await loadPost();
      setState(() {
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post Dihapus'),
        ),
      );
    } else {
      return;
    }
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Menghapus Post'),
          content: Text('Hapus Postingan?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); //canceled
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); //confirmed
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    ) ?? false; // The dialog is dismissed
  }

  Future<void> sendDeleteRequest(String pid) async {
    final response = await http.post(
      Uri.parse('http://${httpC}/pcs_mandiri/delete.php'),
      body: {
        'pid': pid,
      },
    );

    if (response.statusCode != 200) {
      print('Failed to send delete request. Status code: ${response.statusCode}');
    }
  }

  void navigateToDetailPost(BuildContext context, Map<String, dynamic> post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPostPage(post: post),
      ),
    );
  }

  String truncateSubtitle(String subtitle) {
    List<String> words = subtitle.split(' ');
    int maxLength = 20;
    int truncatedLength = words.length > maxLength ? maxLength : words.length;
    String truncatedSubtitle = words.sublist(0, truncatedLength).join(' ');
    return truncatedSubtitle;
  }

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
              FutureBuilder(
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

                  return CarouselSlider(
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
                    items: dataList.map((post,) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              navigateToDetailPost(context, post);
                            },
                            child: Container(
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
                                          child: Image.network(
                                            "http://${httpC}/pcs_mandiri/${post['img']}",
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
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            likedPosts.contains(post['pid']) ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                            color: likedPosts.contains(post['pid']) ? Colors.blue : null,
                                          ),
                                          onPressed: () {
                                            
                                            _handleLikeButtonPress(post);
                                          },
                                        ),
                                        
                                        Text('${post['jumlahlike']}'),

                                        IconButton(
                                          icon: Icon(Icons.comment),
                                          onPressed: () {
                                            
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.more_vert),
                                          onPressed: () async {
                                            _showPopupMenu(context, post);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
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

                        return GestureDetector(
                          onTap: () {
                            navigateToDetailPost(context, post);
                          },
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
                                      child: Image.network(
                                        "http://${httpC}/pcs_mandiri/${post['img']}",
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
                                        future: fetchTextFromServer("http://${httpC}/pcs_mandiri/${post['content']}"),
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
                                                    truncateSubtitle(contentText),
                                                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                                  ),
                                                ],
                                              );
                                            }
                                          } catch (e) {
                                            print('Error: $e');
                                            return Text('An error occurred.');
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        likedPosts.contains(post['pid']) ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                        color: likedPosts.contains(post['pid']) ? Colors.blue : null,
                                      ),
                                      onPressed: () {
                                        
                                        _handleLikeButtonPress(post);
                                      },
                                    ),
                                    
                                    Text('${post['jumlahlike']}'),
                                    IconButton(
                                      icon: Icon(Icons.comment),
                                      onPressed: () {
                                        
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.more_vert),
                                      onPressed: () async {
                                        _showPopupMenu(context, post);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
