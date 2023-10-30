import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/form_type.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CurrentImages extends StatefulWidget {
  List<String> images = ['assets/images/no_image.png'];

  CurrentImages({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  _CurrentImagesState createState() => _CurrentImagesState(images: this.images);
}

class _CurrentImagesState extends State<CurrentImages> {
  final _formKey = GlobalKey<FormState>();
  List<String> images;

  _CurrentImagesState({required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      body: Row(
        children: <Widget>[
          for (var item in images)
            Center(
              child: Container(
                width: 100,
                child: Image.file(File(item),fit: BoxFit.cover),
              ),
            )
        ],
      ),
    );
  }
}
