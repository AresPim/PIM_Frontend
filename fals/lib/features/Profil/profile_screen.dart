import 'package:fals/features/Profil/widgets/createNews.dart';
import 'package:fals/features/Profil/widgets/editProfile.dart';
import 'package:fals/features/Profil/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../utils/constants/api_constants.dart' as url;

final post = url.url + 'post';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> posts = []; // List to store fetched posts

  @override
  void initState() {
    super.initState();
    // Fetch posts when the widget is first created
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse(post));
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the posts
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          posts = List<Map<String, dynamic>>.from(data);
        });
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: const  Text(
            '@wilsonfranci',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => Settings());
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/content/user.png'),
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.only(top: 30.0), // Add top padding here
                      child: _buildStatWidget('256', 'Followers'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0), // Add top padding here
                      child: _buildStatWidget('567', 'Following'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0), // Add top padding here
                      child: _buildStatWidget('123', 'News'),
                    ),



                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wilson Franci',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4.0),


                    const SizedBox(height: 8.0),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => EditProfileScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF74069A),
                                  Color(0xFFFF8086),
                                ],
                              ),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 150,
                                minHeight: 50,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => CreateNews());
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF74069A),
                                  Color(0xFFFF8086),
                                ],
                              ),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 150,
                                minHeight: 50,
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add Post',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Adjust the spacing between icon and text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24.0),

                    // Add a section for displaying user posts
                    SizedBox(height: 16.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Posts',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          // Use ListView.builder to generate cards dynamically
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 3,
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(posts[index]['title'] ?? ''),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(posts[index]['category'] ?? ''),
                                      Text(posts[index]['content'] ?? ''),
                                      Text(
                                          'Posted ${calculateTimeAgo(posts[index]['createdAt'])} ago'),
                                    ],
                                  ),
                                  leading: Image.asset(
                                      'assets/images/content/10.jpg'),
                                  // Add more details or actions as needed
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  String calculateTimeAgo(String? createdAt) {
    if (createdAt != null) {
      // Parse the string date and convert it to DateTime
      final dateTime = DateTime.parse(createdAt);
      final difference = DateTime.now().difference(dateTime);
      return timeago.format(DateTime.now().subtract(difference));
    }
    return '';
  }
}

Widget _buildStatWidget(String value, String label) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 4.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
    ],
  );
}
