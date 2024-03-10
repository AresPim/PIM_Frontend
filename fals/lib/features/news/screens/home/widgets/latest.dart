import 'package:flutter/material.dart';

class Latest extends StatelessWidget {
  final List<Map<String, String>> headlines = [
    {"title": "Trending", "image": "assets/images/content/rs.png"},
    {"title": "Verified", "image": "assets/images/content/rr.png"},
    {
      "title": "Russian warship: Moskovitz sinks in Black Sea - BBC News",
      "image": "assets/images/content/rs.png"
    },
    {"title": "Not Yet Verified", "image": "assets/images/content/rs.png"},
    {
      "title":
      "Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil - BBC News",
      "image": "assets/images/content/rr.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest'),
      ),
      body: ListView.builder(
        itemCount: headlines.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(headlines[index]["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  headlines[index]["title"]!,
                  style: TextStyle(
                    fontWeight:
                    index % 2 == 0 ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Some additional text related to the news",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Divider(color: Colors.grey.shade700),
              ],
            ),
          );
        },
      ),
    );
  }
}
