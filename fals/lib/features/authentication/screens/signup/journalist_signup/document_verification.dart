import 'dart:io';
import 'dart:convert';

import 'package:fals/features/authentication/screens/signup/journalist_signup/edit_card.dart';
import 'package:fals/features/authentication/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/constants/colors.dart';

import 'package:http/http.dart' as http;

final url = 'http://192.168.1.26:9090/';
final verifDoc = url + 'journalistVerification';

class DocumentVerificationPage extends StatefulWidget {
  final String? cardNumber;
  final String? cardOwner;
  final String? expirationDate;
  final String? cvv;

  DocumentVerificationPage({
    this.cardNumber,
    this.cardOwner,
    this.expirationDate,
    this.cvv,
  });

  @override
  _DocumentVerificationPageState createState() =>
      _DocumentVerificationPageState();
}

class _DocumentVerificationPageState extends State<DocumentVerificationPage> {
  TextEditingController tfDocNmbr = TextEditingController();

  Map<String, String> cardDetails = {};

  String selectedDocument = 'Passport';
  String selectedCard = 'Visa';
  File? pickedImage;

  bool _isNotValidate = false;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        pickedImage = File(image.path);
      } else {
        pickedImage = null; // Handle the case when no image is picked
      }
    });
  }

  void AddDoc() async {
    if (tfDocNmbr.text.isNotEmpty) {
      var reqbody = {
        'userId': "65cc45fec23257fc597de949",
        'documentNumber': tfDocNmbr.text,
        'documentType': selectedDocument,
        'cardDetails': {
          'cardNumber': widget.cardNumber,
          'cardOwner': widget.cardOwner,
          'expirationDate': widget.expirationDate,
          'cvv': widget.cvv,
        },
      };
      var response = await http.post(Uri.parse(verifDoc),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Verification'),
        actions: [
          IconButton(
            onPressed: () => {
              AddDoc(),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              )
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Identity Documents',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDocument = 'Passport';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedDocument == 'Passport'
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    child: Text('Passport'),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDocument = 'IDCard';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedDocument == 'IDCard'
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    child: Text('ID Card'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            if (selectedDocument == 'Passport')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: tfDocNmbr,
                    decoration: InputDecoration(labelText: 'Passport Number'),
                  ),
                  SizedBox(height: 16.0),
                  Text('Upload Passport Image:'),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100),
                        color: TColors.grey,
                      ),
                      child: pickedImage != null
                          ? Image.file(
                              File(pickedImage!.path),
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(Icons.camera),
                                  ),
                                  SizedBox(width: 8),
                                  Text('Pick an image'),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            if (selectedDocument == 'IDCard')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: tfDocNmbr,
                    decoration:
                        InputDecoration(labelText: 'National ID Card Number'),
                  ),
                  SizedBox(height: 16.0),
                  Text('Upload Image of ID Card:'),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100),
                        color: TColors.grey,
                      ),
                      child: pickedImage != null
                          ? Image.file(
                              File(pickedImage!.path),
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(Icons.camera),
                                  ),
                                  SizedBox(width: 8),
                                  Text('Pick an image'),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 32.0),
            Text(
              'Bank Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            buildCreditCardRow('Visa'),
            buildCreditCardRow('Mastercard'),
            buildCreditCardRow('PayPal'),
            buildCreditCardRow('Apple Pay'),
            //submit
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  AddDoc();
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
                      'Submit',
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

  Widget buildCreditCardRow(String cardName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(cardName),
          Text('Valid'), // Replace with your logic for validity
          ElevatedButton(
            onPressed: () {
              Get.to(() => EditCardScreen());
            },
            child: Text('Edit'),
          ),
        ],
      ),
    );
  }
}
