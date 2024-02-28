import 'package:fals/features/authentication/screens/login/login.dart';
import 'package:fals/features/authentication/screens/signup/verify_email.dart';
import 'package:fals/features/authentication/screens/signup/widgets/signup_radio_button.dart';
import 'package:fals/features/authentication/screens/signup/widgets/terms_conditions.dart';
import 'package:fals/utils/constants/sizes.dart';
import 'package:fals/utils/constants/text_strings.dart';
import 'package:fals/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../journalist_signup/document_verification.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

final url = 'http://192.168.1.14:9090/';
final auth = url + 'auth/signup';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? gender;
  bool isJournalist = false;

  TextEditingController tfusername = TextEditingController();
  TextEditingController tfemail = TextEditingController();
  TextEditingController tfphonenmbr = TextEditingController();
  TextEditingController tfpassword = TextEditingController();

  bool _isNotValidate = false;

  final _formKey = GlobalKey<FormState>(); // Clé globale pour le formulaire

  void signup() async {
    if (tfemail.text.isNotEmpty &&
        tfpassword.text.isNotEmpty &&
        tfusername.text.isNotEmpty &&
        tfphonenmbr.text.isNotEmpty) {
      var reqbody = {
        "username": tfusername.text,
        "email": tfemail.text,
        "phoneNumber": tfphonenmbr.text,
        "password": tfpassword.text,
      };
      var response = await http.post(Uri.parse(auth),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqbody));
      print(response);
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Toggle
          Row(
            children: [
              Text(
                isJournalist ? 'As a Journalist' : 'As a Simple User',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Switch(
                  value: isJournalist,
                  onChanged: (value) {
                    setState(() {
                      isJournalist = value;
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          // Username
          TextFormField(
            controller: tfusername,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.username,
            ),
            validator: (value) {
              if (value!.length < 4) {
                return 'Username must be at least 4 characters long';
              }
              return null;
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Full Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Email
          TextFormField(
            controller: tfemail,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.email,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty ||
                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Phone Number
          TextFormField(
            controller: tfphonenmbr,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty ||
                  (!value.startsWith('+') && !value.startsWith('0'))) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Password
          TextFormField(
            controller: tfpassword,
            obscureText: true,
            decoration: const InputDecoration(
              suffixIcon: Icon(Iconsax.eye_slash),
              labelText: TTexts.password,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Confirm Password
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              suffixIcon: Icon(Iconsax.eye_slash),
              labelText: TTexts.confirmPassword,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Gender
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientRadio<String>(
                value: 'male',
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              const SizedBox(width: 10.0),
              GradientRadio<String>(
                value: 'female',
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Terms and Conditions
          const TermsAndConditionsCheckBox(),
          const SizedBox(height: 16.0),
          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (isJournalist) {
                  // If the user is a journalist, navigate to DocumentVerification screen
                  Get.to(() => DocumentVerificationPage());
                } else {
                  // Valider le formulaire avant de soumettre
                  if (_formKey.currentState!.validate()) {
                    signup();
                    // If the user is not a journalist, navigate to VerifyEmailScreen
                    Get.to(() => VerifyEmailScreen());
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF74069A),
                      Color(0xFFFF8086),
                    ],
                  ),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: double.infinity,
                    minHeight: 50,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(TTexts.haveAccount),

        // Sign In
        TextButton(
          onPressed: () => Get.to(() => const LoginScreen()),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  Color(0xFF74069A),
                  Color(0xFFFF8086),
                ],
                stops: [0.3, 0.7],
              ).createShader(bounds);
            },
            child: const Text(
              TTexts.signIn,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
