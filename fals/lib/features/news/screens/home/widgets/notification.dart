import 'package:flutter/material.dart';

class ActivityFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'), // Titre de la page modifié en "Notifications"
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        children: [
          _buildActivityTile(
            title: 'Today, April 22',
            //actionText: 'See all',
          ),
          _buildActivityTile(
            title: 'BBC NEWS',
           // actionText: 'Notification',
            subTitle: 'BBC News has posted new news',
            timeAgo: '15m ago',
            imageUrl: 'assets/images/content/rs.png', // Chemin d'accès corrigé de l'image
          ),
          _buildDivider(),
          _buildActivityTile(
            title: 'Modelyn Saris is now following you',
            timeAgo: '1h ago',
            imageUrl: 'assets/images/content/rs.png', // Chemin d'accès corrigé de l'image
          ),
          _buildDivider(),
          _buildActivityTile(
            title: 'Omar Merditz commented on your news "Minting Your First NFT: A ... "',
            timeAgo: '1h ago',
            imageUrl: 'assets/images/content/rs.png', // Chemin d'accès corrigé de l'image
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTile({
    required String title,
    String? subTitle,
    String? actionText,
    String? timeAgo,
    String? imageUrl,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(imageUrl),
            ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (subTitle != null) ...[
                  SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
                if (timeAgo != null) ...[
                  SizedBox(height: 4),
                  Text(
                    timeAgo,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
          if (actionText != null)
            Text(
              actionText,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[400],
      height: 0,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ActivityFeed(),
  ));
}
