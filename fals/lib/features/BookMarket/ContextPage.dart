import 'package:flutter/material.dart';

class ContextPage extends StatelessWidget {
  const ContextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int commentCount = 10; // Nombre de commentaires
    int voteCount = 25; // Nombre de votes

    return Scaffold(
      appBar: AppBar(
        title: const Text('Context Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("CustomAppBarExample"),
                    content: Text("This is a custom app bar example."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: Image.asset(
                      'assets/images/content/rr.png',
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ukraine\'s President Zelensky to BBC: Blood money being paid for Russian oil',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Udan Pays accused European countries that continue to buy Russian oil of coming their money in other people\'s blood. In an interview with the BBC, Pridany singled out Germany and Hungary, accusing them of blocking efforts to impose a sales ban, from which Russio stands to make up to £250bn (£3256) this year.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            _showVotes(context);
                          },
                          icon: Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Color.fromARGB(255, 207, 121, 187),
                          ),
                          label: Text(
                            '$voteCount Likes',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            _showVotes(context);
                          },
                          icon: Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Color.fromARGB(255, 221, 132, 230),
                          ),
                          label: Text(
                            'Dislike',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _showComments(context);
                    },
                    icon: Icon(Icons.comment_outlined),
                    label: Text(
                      'Comments',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showVotes(context);
                    },
                    icon: Icon(Icons.how_to_vote_outlined),
                    label: Text(
                      'Vote',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComments(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Comments"),
          content: Text("List of comments goes here."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showVotes(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Votes"),
          content: Text("List of votes goes here."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContextPage(),
  ));
}
