import 'package:fals/features/news/screens/home/widgets/latest.dart';
import 'package:fals/features/news/screens/home/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:fals/features/news/screens/home/widgets/home_appbar.dart';
import 'package:fals/utils/constants/sizes.dart';
import 'package:fals/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:fals/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:fals/common/widgets/texts/section_heading.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/category_widget/category_slider.dart';
import 'widgets/trending.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  THomeAppBar(),
                  const SizedBox(height: TSizes.defaultSpace),

                  /// Search bar
                  SearchContainer(
                    text: 'Search',
                  ),
                  const SizedBox(height: TSizes.defaultSpace),

                  /// Topics
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Heading
                        SectionHeading(
                          title: 'Topics',
                          showActionButton: false,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        /// Topics
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
                                      // Gérer l'appui sur le bouton de catégorie
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Trending Section
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => Trending());
                    },
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            Color(0xFF74069A),
                            Color(0xFFFF8086),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds);
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
            /// Slider
            Container(
              height: 200,
              child: PageView.builder(
                itemCount: 3, // Set the number of slides
                itemBuilder: (context, index) {
                  return SlideWidget(); // Your custom slide widget
                },
              ),
            ),
            ///Latest Section
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => Latest());
                        },
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Color(0xFF74069A),
                                Color(0xFFFF8086),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
