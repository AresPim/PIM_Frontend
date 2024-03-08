import 'package:flutter/material.dart';

class BBCNews extends StatefulWidget {
  @override
  _BBCNewsState createState() => _BBCNewsState();
}

class _BBCNewsState extends State<BBCNews> {
  String _selectedCategory = 'News'; // Catégorie sélectionnée par défaut

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Share"),
                value: "Share",
              ),
              PopupMenuItem(
                child: Text("Report"),
                value: "Report",
              ),
              PopupMenuItem(
                child: Text("Unfollow"),
                value: "Unfollow",
              ),
            ],
            onSelected: (value) {
              // Ajouter la logique pour gérer la sélection des options ici
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/content/rr.png'), // Remplacez par le chemin de votre image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BBC News',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row( // Mettre les textes horizontalement
                          children: [
                            Text(
                              '1.2M Followers', // Ajout du nombre de followers
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              '10K News', // Ajout du nombre de news
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              '124K Following', // Ajout du nombre de following
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Divider(),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedCategory = 'News';
                        });
                      },
                      child: Text(
                        'News',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedCategory == 'News'
                              ? Color.fromARGB(255, 241, 112, 183)
                              : Colors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedCategory = 'Recent';
                        });
                      },
                      child: Text(
                        'Recent',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedCategory == 'Recent'
                              ? Color.fromARGB(255, 227, 115, 174)
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/content/rr.png'), // Remplacez par le chemin de votre image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        _selectedCategory == 'News'
                            ? 'News Title $index'
                            : 'Recent Title $index',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _selectedCategory == 'News'
                            ? 'News Description $index'
                            : 'Recent Description $index',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
