import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/notifications/notifications_icon.dart';
import 'notification.dart';
import 'search.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [
              Color(0xFF74069A),
              Color(0xFFFF8086),
            ],
            stops: [0.3, 0.7],
          ).createShader(bounds);
        },
        child: Text(
          'FALS',
          style: TextStyle(
            fontSize: 50,
            fontFamily: 'MontserratAlt1',
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search,  size: 30),

          onPressed: () {
            Get.to(() => SearchResultsPage());
          },
        ),
        NotificationsIcon(onPressed:(){ Get.to(() => ActivityFeed());}

          ),


      ],
    );
  }
}

