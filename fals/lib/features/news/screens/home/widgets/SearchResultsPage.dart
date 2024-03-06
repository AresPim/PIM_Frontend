import 'package:flutter/material.dart';

import 'BBCNews.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  String _selectedCategory = 'News';

  List<NewsHeadline> newsHeadlines = [
    NewsHeadline(
      title: 'Ukraine\'s President Zelensky to BBC: Blood money being paid for Russian...',
      source: 'BBC News',
      timeAgo: '14m ago',
      isVerified: true,
      imageAsset: 'assets/images/content/rs.png',
    ),
    NewsHeadline(
      title: 'Russian warship: Moskva sinks in Black Sea',
      source: 'BBC News',
      timeAgo: '1h ago',
      isVerified: false,
      imageAsset: 'assets/images/content/rs.png',
    ),
    NewsHeadline(
      title: 'Her train broke down. Her phone died. And then she met her future husband',
      source: 'CNN',
      timeAgo: '1h ago',
      isVerified: true,
      imageAsset: 'assets/images/content/rs.png',
    ),
    NewsHeadline(
      title: 'Wind power produced more electricity than coal and nuclear sources for...',
      source: 'USA Today',
      timeAgo: '4h ago',
      isVerified: true,
      imageAsset: 'assets/images/content/rs.png',
    ),
  ];

  final List<NewsCategory> newsCategories = [
    NewsCategory(
      title: 'Health',
      description: 'View the latest health news and explore articles on...',
      imageUrl: 'assets/images/content/rs.png',
      isSaved: true,
    ),
    NewsCategory(
      title: 'Technology',
      description: 'The latest tech news about the world\'s best hardware...',
      imageUrl: 'assets/images/content/rs.png',
      isSaved: false,
    ),
    NewsCategory(
      title: 'Art',
      description: 'The Art Newspaper is the journal of record for...',
      imageUrl: 'assets/images/content/rs.png',
      isSaved: false,
    ),
    NewsCategory(
      title: 'Politics',
      description: 'Opinion and analysis of American and global politics...',
      imageUrl: 'assets/images/content/rs.png',
      isSaved: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            // Search logic here...
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              // Logic to clear the search field
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = 'News';
                    });
                  },
                  child: Text('News'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = 'Topic';
                    });
                  },
                  child: Text('Topic'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = 'Author';
                    });
                  },
                  child: Text('Author'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _buildList(_selectedCategory),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildList(String category) {
    switch (category) {
      case 'News':
        return [
          for (var headline in newsHeadlines)
            ListTile(
              leading: Image.asset(
                headline.imageAsset,
                width: 50,
                height: 50,
              ),
              title: Text(headline.title),
              subtitle: Text('${headline.source} ${headline.timeAgo}'),
            ),
        ];
      case 'Topic':
       return [
          for (var newsCategory in newsCategories)
            ListTile(
              leading: Image.asset(
                newsCategory.imageUrl,
                width: 50,
                height: 50,
              ),
              title: Text(newsCategory.title),
              subtitle: Text(newsCategory.description),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    newsCategory.isSaved = !newsCategory.isSaved;
                  });
                },
                child: Text(newsCategory.isSaved ? 'saved' : 'save'),
              ),
            ),
        ];
      
        return [];
     case 'Author':
        return [
          for (var newsCategory in newsCategories)
            GestureDetector(
              onTap: () {
                // Naviguer vers la page BBCNews lorsque l'auteur est cliqué
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BBCNews()),
                );
              },
              child: ListTile(
                leading: Image.asset(
                  newsCategory.imageUrl,
                  width: 50,
                  height: 50,
                ),
                title: Text(newsCategory.title),
                subtitle: Text(newsCategory.description),
                trailing: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      newsCategory.isSaved = !newsCategory.isSaved;
                    });
                  },
                  child: Text(newsCategory.isSaved ? 'following' : 'following'),
                ),
              ),
            ),
        ];
      default:
        return [];
    }
  }
}

class NewsHeadline {
  final String title;
  final String source;
  final String timeAgo;
  final bool isVerified;
  final String imageAsset;

  NewsHeadline({
    required this.title,
    required this.source,
    required this.timeAgo,
    required this.isVerified,
    required this.imageAsset,
  });
}

class NewsCategory {
  final String title;
  final String description;
  final String imageUrl;
  bool isSaved;

  NewsCategory({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.isSaved,
  });
}
