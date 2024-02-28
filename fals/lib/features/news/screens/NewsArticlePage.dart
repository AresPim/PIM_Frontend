import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewsArticlePage extends StatefulWidget {
  @override
  NewsArticlePageState createState() => NewsArticlePageState();
}

class NewsArticlePageState extends State<NewsArticlePage> {
  String _newsTitle = '';
  File? _pickedImage;
  String _newsArticle = '';
  bool _isImagePickerActive = false;

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
              TextField(
                decoration: InputDecoration(
                  labelText: 'News Article',
                ),
                onChanged: (value) {
                  setState(() {
                    _newsArticle = value;
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
        onPressed: () {
          // Add code here to publish the news article
        },
        child: Text('Publish'),
      ),
    );
  }
}
