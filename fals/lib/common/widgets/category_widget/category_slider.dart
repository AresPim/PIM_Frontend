
import 'package:flutter/material.dart';

final List<CategoryItem> categories = [
  CategoryItem(icon: Icons.access_time, label: 'Latest'),
  CategoryItem(icon: Icons.sports, label: 'Sports'),
  CategoryItem(icon: Icons.policy, label: 'Politics'),
  CategoryItem(icon: Icons.business, label: 'Business'),
  CategoryItem(icon: Icons.favorite, label: 'Health'),
  CategoryItem(icon: Icons.airplanemode_active, label: 'Travel'),
  CategoryItem(icon: Icons.school, label: 'Science'),
];
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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent), // Set border color to transparent
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Set shadow color with opacity
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
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
