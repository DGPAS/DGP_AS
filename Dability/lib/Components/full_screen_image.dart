import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String image;
  final String text;

  const FullScreenImage({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Hero(
            tag: 'mi-imagen-hero', // Utiliza el mismo tag que en la página inicial
            child: Column (
              children: [
                Container(
                  height: 400,
                    child: Image(image: AssetImage(image),fit: BoxFit.contain),
                ),
                Container(
                  child: Text(text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}