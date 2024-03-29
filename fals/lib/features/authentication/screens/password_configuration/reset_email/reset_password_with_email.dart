import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'email_sent.dart';

class EmailResetPassword extends StatelessWidget {
  const EmailResetPassword({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Headings
              Text(
                TTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8.0),
              Text(
                TTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 16.0),

              /// Email Input
              TextFormField(
                decoration: InputDecoration(
                  labelText: TTexts.email,



                ),
              ),

            ],
          ),
        ),
      ),
      // Submit button outside the Column
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 50.0,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.to(() => const EmailSentScreen()),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ), backgroundColor: Color(0xFF74069A),
              padding: EdgeInsets.zero, // Set background color
            ),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF74069A),
                    Color(0xFFFF8086),
                  ], // Your gradient colors
                ),
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 50),
                alignment: Alignment.center,
                child: Text(
                  TTexts.submit,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0, // Adjust font size as needed
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
