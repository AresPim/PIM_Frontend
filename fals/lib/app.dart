import 'package:fals/features/authentication/screens/onboarding/onboarding.dart';
import 'package:fals/features/news/screens/home/widgets/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:fals/utils/theme/theme.dart';
//import 'package:fals/features/news/screens/home/NewsPage.dart';
import 'package:fals/features/news/screens/home/widgets/Home.dart';
import 'package:fals/features/news/screens/home/widgets/ActivityFeed.dart';
import 'package:fals/features/BookMarket/ContextPage.dart';

import 'features/news/screens/home/widgets/PageLayout.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home:  OnBoardingScreen());
        // home:  Home());
   // home: ContextPage());
//home: PageLayout());
     // home: ActivityFeed());
  }
}
