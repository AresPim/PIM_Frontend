import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter/material.dart';
import 'package:fals/features/news/screens/NewsArticlePage.dart';
import 'package:get/get.dart';
import './EditProfileScreen.dart';
import 'package:http/http.dart' as http;
import 'package:fals/url.dart' as url;

final showPosts = url.url + 'post';

class ProfileScreen extends StatefulWidget {
  //const ProfileScreen({Key? key}) : super(key: key);
  final String? token;
  ProfileScreen({this.token});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> posts = []; // List to store fetched posts

  late Map<String, dynamic> decodedToken;
  late String? userId;
  late String? role;
  late String? username;
  late String? firstName;
  late String? lastName;

  @override
  void initState() {
    super.initState();
    fetchPosts();
    // Vérifiez d'abord si le token est null
    if (widget.token != null) {
      // Decode the token
      decodedToken = JwtDecoder.decode(widget.token!);
      // Utilisez les données extraites comme nécessaire
      userId = decodedToken['userId'];
      role = decodedToken['role'];
      username = decodedToken['username'];
      firstName = decodedToken['firstName'];
      lastName = decodedToken['lastName'];
    }
  }

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(showPosts));
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
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Get.to(() => EditProfileScreen()),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/content/user.png'),
                        ),
                        const SizedBox(height: 1.0),
                        Text(
                          '${firstName ?? ''} ${lastName ?? ''}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          username ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                if (role != 'Journalist')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '256',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '567',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'Following',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                if (role == 'Journalist')
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bio',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16.0),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '256',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  'Followers',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '567',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  'Following',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                if (role == 'Journalist')
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Material(
                      shape: const CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // Add your functionality here
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF74069A),
                                Color(0xFFFF8086),
                              ],
                              stops: [0.3, 0.7],
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () => Get.to(
                                () => NewsArticlePage(token: widget.token)),
                          ),
                        ),
                      ),
                    ),
                  ),
                // Add a section for displaying user posts
                SizedBox(height: 16.0),
                if (role == 'Journalist')
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(posts[index]['category'] ?? ''),
                                    Text(posts[index]['content'] ?? ''),
                                    Text(
                                        'Posted ${calculateTimeAgo(posts[index]['createdAt'])} ago'),
                                  ],
                                ),
                                leading:
                                    Image.asset('assets/images/content/10.jpg'),
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
    );
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
