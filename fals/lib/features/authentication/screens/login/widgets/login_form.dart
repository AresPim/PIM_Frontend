import 'package:fals/bottom_nav_bar.dart';
import 'package:fals/features/authentication/screens/signup/signup.dart';
import 'package:fals/utils/constants/sizes.dart';
import 'package:fals/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../password_configuration/forget_password.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:fals/url.dart' as url;

final auth = url.url + 'auth/signin';

class SignUp extends StatelessWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(TTexts.dontHaveAccount),

        // Sign Up
        TextButton(
          onPressed: () => Get.to(() => const SignUpScreen()),
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
              TTexts.signUp,
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

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late SharedPreferences shp;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  Future<void> initSharedPref() async {
    shp = await SharedPreferences.getInstance();
  }

  Future<void> loginUser(String email, String password) async {
    final url = Uri.parse(auth);
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful login, handle the response
        final responseData = json.decode(response.body);
        // Extraire le token du corps de la réponse
        final receivedToken = responseData as String;
        // Extraire l'ID de l'utilisateur du token décodé
        //final token = verifyJwtHS256Signature(
        //  receivedToken, "not-less-than-32-lettres+strong-key");
        //store userId in sharedpref
        shp.setString('token', receivedToken);
        String? token = shp.getString('token');
        //String? userId = token.toJson()['userId'];
        //print('userId : ${userId}');
        // Example: Navigate to the home screen or perform other actions
        Get.to(() => BottomNavigationMenu(token: token));
      } else if (response.statusCode == 404) {
        // User not found
        print('User not found. Status code: ${response.statusCode}');
        print('Error message: ${response.body}');

        // Example: Show an error message to the user
        Get.snackbar('Error', 'User not found. Please check your credentials.');
      } else {
        // Failed login, handle the error
        print('Failed to login. Status code: ${response.statusCode}');
        print('Error message: ${response.body}');

        // Example: Show an error message to the user
        Get.snackbar('Error', 'Failed to login. Please try again.');
      }
    } catch (error) {
      // Handle other exceptions (e.g., network error)
      print('Error: $error');

      // Example: Show an error message to the user
      Get.snackbar(
        'Error',
        'An error occurred. Please check your network connection and try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Username
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: TTexts.email,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            // Password
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: TTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            // Remember me & Forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember me

                Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    Text(TTexts.rememberMe),
                  ],
                ),

                // Forgot password

                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
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
                      TTexts.forgetPassword,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            // Sign In
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, perform login
                    loginUser(emailController.text, passwordController.text);
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
                      TTexts.signIn,
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
      ),
    );
  }
}
