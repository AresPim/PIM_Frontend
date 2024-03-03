import 'dart:convert';

import 'package:fals/features/authentication/screens/signup/journalist_signup/document_verification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final url = 'http://192.168.1.20:9090/';
final cardEdit = url + 'cardDetails';

class EditCardScreen extends StatefulWidget {
  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  TextEditingController tfCardNmbr = TextEditingController();
  TextEditingController tfCardOwner = TextEditingController();
  TextEditingController tfExpDate = TextEditingController();
  TextEditingController tfCvv = TextEditingController();

  bool _isNotValidate = false;

  void EditCard() async {
    if (tfCardNmbr.text.isNotEmpty &&
        tfCardOwner.text.isNotEmpty &&
        tfExpDate.text.isNotEmpty &&
        tfCvv.text.isNotEmpty) {
      var reqbody = {
        'userId': "65cc45fec23257fc597de949",
        'cardNumber': tfCardNmbr.text,
        'cardOwner': tfCardOwner.text,
        'expirationDate': tfExpDate.text,
        'cvv': tfCvv.text,
      };
      var response = await http.post(Uri.parse(cardEdit),
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
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card'),
        actions: [
          IconButton(
            onPressed: () => {
              EditCard(),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DocumentVerificationPage()),
              )
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upload Image of Card:'),
              // Add image upload widget here
              SizedBox(height: 16.0),
              TextField(
                controller: tfCardNmbr,
                decoration: InputDecoration(labelText: 'Card Number'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: tfCardOwner,
                decoration: InputDecoration(labelText: 'Card Owner'),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Expiration Date:'),
                        // Add Date Picker here
                        SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
                              setState(() {
                                tfExpDate.text = pickedDate
                                    .toString(); // Mise à jour de la date
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Text('Select Date',
                              style: TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CVV:'),
                        TextField(
                          controller: tfCvv,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
