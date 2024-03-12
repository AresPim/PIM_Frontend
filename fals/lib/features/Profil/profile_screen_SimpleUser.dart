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

class ProfileScreenSimpleUser extends StatefulWidget {
  //const ProfileScreen({Key? key}) : super(key: key);
  final String? token;
  ProfileScreenSimpleUser({this.token});

  @override
  _ProfileScreenSimpleUserState createState() =>
      _ProfileScreenSimpleUserState();
}

class _ProfileScreenSimpleUserState extends State<ProfileScreenSimpleUser> {
  List<Map<String, dynamic>> posts = []; // List to store fetched posts
/*
  @override
  void initState() {
    super.initState();
    // Fetch posts when the widget is first created
    fetchPosts();
  }
*/
  late Map<String, dynamic> decodedToken;
  late String? userId;
  late String? role;
  late String? username;
  late String? firstName;
  late String? lastName;

  @override
  void initState() {
    super.initState();
    // Vérifiez d'abord si le token est null
    if (widget.token != null) {
      // Decode the token
      Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token!);
      //decodedToken = JwtDecoder.decode(widget.token!);

      // Utilisez les données extraites comme nécessaire
      userId = decodedToken['userId'];
      role = decodedToken['role'];
      username = decodedToken['username'];
      firstName = decodedToken['firstName'];
      lastName = decodedToken['lastName'];
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ReputationBadge',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      SizedBox(height: 16.0),
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
