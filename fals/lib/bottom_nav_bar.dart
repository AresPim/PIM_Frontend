import 'package:fals/features/news/screens/home/widgets/Home.dart';
import 'package:fals/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:fals/features/Chat/ChatPage.dart';
import 'package:fals/features/BookMarket/bookMarket.dart';

//lib\features\Profil\profile_screen.dart
import 'package:fals/features/Profil/profile_screen.dart';


class BottomNavigationMenu extends StatelessWidget {
  const BottomNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

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
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

//Change the containers with the screens.
  final screens = [
    Home(),
    ChatPage(),
    const BookMarket(),
    const ProfileScreen(),
  ];
}