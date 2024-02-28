import 'package:flutter/material.dart';
import 'package:fals/features/news/screens/NewsArticlePage.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
                          'Wilson Franci',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'wilsonfranci',
                          style: TextStyle(
                            color: Colors.white,
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NewsArticlePage()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
