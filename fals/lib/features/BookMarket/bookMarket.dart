import 'package:flutter/material.dart';

import 'ContextPage.dart';

class BookMarket extends StatelessWidget {
  const BookMarket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite News'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: NewsSearchDelegate());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContextPage()),
                );
              },
              child: ListTile(
                title: const Text(
                    'Ukraine\'s President Zelensky to BBC: Blood money being paid ...'),
                subtitle: const Text('BBC News Ⓒ 14m ago'),
                leading: Image.asset(
                    'assets/images/content/rr.png'), // Replace with your local image path
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContextPage()),
                );
              },
              child: ListTile(
                title: const Text(
                    'Ukraine\'s President Zelensky to BBC: Blood money being paid ...'),
                subtitle: const Text('BBC News Ⓒ 14m ago'),
                leading: Image.asset(
                    'assets/images/content/rs.png'), // Replace with your local image path
              ),
            ),
            // Add more news articles as GestureDetector widgets
          ],
        ),
      ),
    );
  }
}

class NewsSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results based on the query
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement suggestions based on the query
    return Container();
  }
}