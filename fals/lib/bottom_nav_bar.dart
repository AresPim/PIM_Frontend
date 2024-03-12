import 'package:fals/features/Profil/profile_screen.dart';
import 'package:fals/features/Profil/profile_screen_SimpleUser.dart';
import 'package:fals/features/news/screens/home/widgets/Home.dart';
import 'package:fals/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'features/BookMarket/bookMarket.dart';
import 'features/Chat/ChatPage.dart';

class BottomNavigationMenu extends StatelessWidget {
  //const BottomNavigationMenu({super.key});
  final String? token;

  BottomNavigationMenu({this.token});

  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
        () => Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 25,
                offset: const Offset(8, 20))
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
                selectedItemColor: TColors.gradientStart,
                unselectedItemColor: TColors.darkGrey,
                currentIndex: controller.selectedIndex.value,
                onTap: (index) => controller.selectedIndex.value = index,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Iconsax.message1), label: "Chat"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark), label: "Bookmark"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ]),
          ),
        ),
      ),
      body:
          Obx(() => controller.screens[controller.selectedIndex.value](token)),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

//Change the containers with the screens.
  final screens = [
    (String? token) => Home(token: token),
    (String? token) => ChatPage(),
    (String? token) => const BookMarket(),
    (String? token) => ProfileScreen(token: token),
  ];
}
