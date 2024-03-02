import 'package:flutter/material.dart';
import 'ActivityFeed.dart';

class Home extends StatelessWidget {
  final List<CategoryItem> categories = [
    CategoryItem(icon: Icons.access_time, label: 'Latest'),
    CategoryItem(icon: Icons.sports, label: 'Sports'),
    CategoryItem(icon: Icons.policy, label: 'Politics'),
    CategoryItem(icon: Icons.business, label: 'Business'),
    CategoryItem(icon: Icons.favorite, label: 'Health'),
    CategoryItem(icon: Icons.airplanemode_active, label: 'Travel'),
    CategoryItem(icon: Icons.school, label: 'Science'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Ajoutez ici la logique pour le bouton de recherche
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Naviguer vers la page ActivityFeed lorsque l'utilisateur appuie sur l'icône de notification
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActivityFeed()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NEWS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle "See all" button press
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Color.fromARGB(255, 233, 150, 208),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/images/content/rr.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verified',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Russian warship: Moskva sinks in Black Sea',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'BBC News 4h ago',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (CategoryItem category in categories)
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: CategoryButton(
                            icon: category.icon,
                            label: category.label,
                            onPressed: () {
                              // Handle category button press
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text(
                      'Ukraine\'s President Zelensky to BBC: Blood money being paid ...'),
                  subtitle: const Text('BBC News Ⓒ 14m ago'),
                  leading: Image.asset('assets/images/content/rs.png'),
                  onTap: () {
                    // Navigate to the news article details page
                  },
                ),
                // Add more news articles as ListTile widgets
              ],
            ),
          ),
        ],
      ),
    
    );
  }
}

class CategoryItem {
  final IconData icon;
  final String label;

  CategoryItem({required this.icon, required this.label});
}

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  CategoryButton({required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Color.fromARGB(255, 243, 129, 224)),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(color: Color.fromARGB(255, 207, 116, 180)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
