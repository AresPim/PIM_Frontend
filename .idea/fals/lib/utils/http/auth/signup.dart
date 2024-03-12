import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> signupUser(
    String username,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    bool isJournalist, // Add toggle state for journalist
    String gender,      // Add gender
    ) async {
  final url = Uri.parse('http://localhost:9090/auth/signup');
  final response = await http.post(
    url,
    body: json.encode({
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'isJournalist': isJournalist, // Include toggle state for journalist
      'gender': gender,              // Include gender
    }),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 201) {
    // Successful signup, handle the response
    final userData = json.decode(response.body);
    print('User data: $userData');
  } else {
    // Failed signup, handle the error
    print('Failed to signup. Status code: ${response.statusCode}');
    print('Error message: ${response.body}');
  }
}
