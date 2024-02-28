import 'package:flutter/material.dart';

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
            ListTile(
              title: const Text(
                  'Ukraine\'s President Zelensky to BBC: Blood money being paid ...'),
              subtitle: const Text('BBC News Ⓒ 14m ago'),
              leading: Image.asset(
                  'assets/images/content/rr.png'), // Remplacez 'assets/your_image.png' par le chemin de votre image locale
              onTap: () {
                // Navigate to the news article details page
              },
            ),
            ListTile(
              title: const Text(
                  'Ukraine\'s President Zelensky to BBC: Blood money being paid ...'),
              subtitle: const Text('BBC News Ⓒ 14m ago'),
              leading: Image.network(
                  'https://img.freepik.com/free-photo/full-shot-soldiers-fighting-together_23-2150804317.jpg'), // Remplacez 'https://example.com/your_image.jpg' par l'URL de votre image en ligne
              onTap: () {
                // Navigate to the news article details page
              },
            ),
            // Add more news articles as ListTile widgets
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
