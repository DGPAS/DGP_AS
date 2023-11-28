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
<<<<<<< HEAD
            tag:
                'mi-imagen-hero', // Utiliza el mismo tag que en la página inicial
            child: Column(
              children: [
                Container(
                  height: 400,
                  child: Image(image: AssetImage(image), fit: BoxFit.contain),
=======
            tag: 'mi-imagen-hero', // Utiliza el mismo tag que en la página inicial
            child: Column (
              children: [
                Container(
                  height: 400,
                    child: Image(image: AssetImage(image),fit: BoxFit.contain),
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
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
<<<<<<< HEAD
}
=======
}
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
