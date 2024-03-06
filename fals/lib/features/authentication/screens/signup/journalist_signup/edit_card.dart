import 'dart:convert';

import 'package:fals/features/authentication/screens/signup/journalist_signup/document_verification.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

import 'dart:io';

final url = 'http://192.168.1.17:9090/';
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

  final _formKey = GlobalKey<FormState>(); // Clé globale pour le formulaire

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    File? selectedImage;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card'),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Si le formulaire est valide, effectuez l'action
                _formKey.currentState!.save(); // Sauvegarde les champs de texte

                //EditCard();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DocumentVerificationPage(
                      cardNumber: tfCardNmbr.text,
                      cardOwner: tfCardOwner.text,
                      expirationDate: tfExpDate.text,
                      cvv: tfCvv.text,
                    ),
                  ),
                );
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Upload Image of Card:'),
                // Add image upload widget here
                ElevatedButton(
                  onPressed: () async {
                    XFile? image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      // Faites quelque chose avec l'image sélectionnée, comme l'afficher dans un widget Image
                      // Par exemple :
                      setState(() {
                        selectedImage = File(image.path);
                      });
                    }
                  },
                  child: Text('Select Image'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: tfCardNmbr,
                  decoration: InputDecoration(labelText: 'Card Number'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Card number cannot be empty';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: tfCardOwner,
                  decoration: InputDecoration(labelText: 'Card Owner'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Card owner cannot be empty';
                    }
                    return null;
                  },
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
                          TextFormField(
                            controller: tfCvv,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'CVV cannot be empty';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid CVV';
                              }
                              return null;
                            },
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
      ),
    );
  }
}

/**
 *   bool _isNotValidate = false;

 *   void EditCard() async {
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
 */