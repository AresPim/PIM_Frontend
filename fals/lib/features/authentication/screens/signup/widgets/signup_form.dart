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
import '../journalist_signup/edit_card.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

final url = 'http://192.168.1.17:9090/';
final auth = url + 'auth/signup';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? gender = 'male';
  bool isJournalist = false;

  TextEditingController tfusername = TextEditingController();
  TextEditingController tfemail = TextEditingController();
  TextEditingController tfphonenmbr = TextEditingController();
  TextEditingController tfpassword = TextEditingController();
  TextEditingController tffirstname = TextEditingController();
  TextEditingController tflastname = TextEditingController();
  TextEditingController tfconfirmpwd = TextEditingController();

  bool _isNotValidate = false;

  final _formKey = GlobalKey<FormState>(); // Clé globale pour le formulaire
  List<String> genderOptions = ['male', 'female'];

  void signup() async {
    if (tfemail.text.isNotEmpty &&
        tfpassword.text.isNotEmpty &&
        tffirstname.text.isNotEmpty &&
        tfusername.text.isNotEmpty &&
        tflastname.text.isNotEmpty &&
        tfconfirmpwd.text == tfpassword.text &&
        tfphonenmbr.text.isNotEmpty) {
      var reqbody = {
        "username": tfusername.text,
        "email": tfemail.text,
        "phoneNumber": tfphonenmbr.text,
        "password": tfpassword.text,
        "firstName": tffirstname.text,
        "lastName": tflastname.text,
        "gender": gender, // Ajoutez le genre au corps de la requête
        "role": "Simple User",
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

  void signupJournalist() async {
    if (tfemail.text.isNotEmpty &&
        tfpassword.text.isNotEmpty &&
        tffirstname.text.isNotEmpty &&
        tfusername.text.isNotEmpty &&
        tflastname.text.isNotEmpty &&
        tfconfirmpwd.text == tfpassword.text &&
        tfphonenmbr.text.isNotEmpty) {
      var reqbody = {
        "username": tfusername.text,
        "email": tfemail.text,
        "phoneNumber": tfphonenmbr.text,
        "password": tfpassword.text,
        "firstName": tffirstname.text,
        "lastName": tflastname.text,
        "gender": gender, // Ajoutez le genre au corps de la requête
        "role": "Journalist",
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
    //final _DocumentVerificationPageState = _DocumentVerificationPageState();

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
                  controller: tffirstname,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  controller: tflastname,
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
            controller: tfconfirmpwd,
            obscureText: true,
            decoration: const InputDecoration(
              suffixIcon: Icon(Iconsax.eye_slash),
              labelText: TTexts.confirmPassword,
            ),
            validator: (value) {
              if (value != tfpassword.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Gender
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var option
              in genderOptions) // Créez un bouton radio pour chaque option
                GestureDetector(
                  onTap: () {
                    setState(() {
                      gender =
                          option; // Mettez à jour la valeur de genre sélectionnée
                    });
                  },
                  child: Row(
                    children: [
                      Radio(
                        value: option,
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                      Text(option[0].toUpperCase() +
                          option.substring(
                              1)), // Mettez la première lettre en majuscule
                    ],
                  ),
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
                  signupJournalist();
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