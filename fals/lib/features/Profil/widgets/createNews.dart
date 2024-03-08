import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class NewsArticlePage extends StatefulWidget {
  @override
  NewsArticlePageState createState() => NewsArticlePageState();
}

class NewsArticlePageState extends State<NewsArticlePage> {
  String _newsTitle = '';
  File? _pickedImage;
  String _content = ''; // Changed variable name from _newsArticle to _content
  String _selectedCategory = ''; // New variable for selected category
  bool _isImagePickerActive = false;

  List<String> _categories = [
    'Sports',
    'Politics',
    'Business',
    'Health',
    'Travel',
    'Science',
  ]; // List of categories

  Future<void> _pickImage() async {
    if (_isImagePickerActive) return; // Exit if image picker is already active
    setState(() {
      _isImagePickerActive = true;
    });
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _pickedImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      setState(() {
        _isImagePickerActive = false;
      });
    }
  }
  Future<void> _publishArticle() async {
    final url = Uri.parse('http://192.168.1.17:9090/post');
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['title'] = _newsTitle
        ..fields['content'] = _content
        ..fields['category'] = _selectedCategory;

      if (_pickedImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          _pickedImage!.path,
          contentType: MediaType('image', 'jpeg'), // Change the content type based on your image type
        ));
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        // Successful post creation

Get.snackbar('Success', 'Post published successfully!');
        // You can navigate to a different screen or perform other actions here
      } else {
        // Failed to create post
        print('Failed to publish post. Status code: ${response.statusCode}');
        print('Error message: ${await response.stream.bytesToString()}');
      }
    } catch (error) {
      // Handle other exceptions
      print('Error: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create News Article'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'News Title',
                ),
                onChanged: (value) {
                  setState(() {
                    _newsTitle = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[200],
                  child: _pickedImage != null
                      ? Image.file(_pickedImage!, fit: BoxFit.cover)
                      : Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
                value: _selectedCategory.isNotEmpty ? _selectedCategory : null,
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),

              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Content', // Changed from 'News Article' to 'Content'
                ),
                onChanged: (value) {
                  setState(() {
                    _content = value; // Changed from _newsArticle to _content
                  });
                },
                maxLines: null,
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _publishArticle,
        child: Text('Publish'),
      ),
    );
  }
}