import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/form_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dability/Components/full_screen_image.dart';
import 'package:dability/Components/text_form.dart';
import 'dart:io';
import 'dart:io';

class UploadForm extends StatefulWidget {
  final bool requiredField;
  final String titulo;
  final ImageFormType tipo;

  UploadForm({
    Key? key,
    required this.requiredField,
    required this.titulo,
    required this.tipo,
  }) : super(key: key);

  @override
  _UploadFormState createState() => _UploadFormState(requiredField: requiredField, titulo: titulo, tipo: tipo);
}

class _UploadFormState extends State<UploadForm> {
  final _formKey = GlobalKey<FormState>();
  String campoRequerido = "* Campo requerido";
  String titulo = "";
  ImageFormType tipo;
  final bool requiredField;
  List<String> pickedFilePaths = ['assets/images/no_image.png','assets/images/no_image.png'];
  List<String> imageDescriptions = [''];

  _UploadFormState({required this.requiredField, required this.titulo, required this.tipo});


  ImageSource _getImageSourceType () {
    if (tipo == ImageFormType.camera) {
      return ImageSource.camera;
    } else {
      return ImageSource.gallery;
    }
  }

  Widget _getImage(String? urlPath) {
    if (urlPath == null) {
      return const Image(image: AssetImage('assets/images/no_image.png'),fit: BoxFit.contain);
    }
    else {
      return Image.file(File(urlPath),fit: BoxFit.cover);
    }
  }

  List<Widget> _getCurrentImages () {
    List<Widget> contenedores = [];
    for (String path in pickedFilePaths) {
      contenedores.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FullScreenImage(image: path, text: imageDescriptions[0]),
              ));
            },
            child: Container (
              height: 100,
              padding: const EdgeInsets.all(10),
              child: Image(image: AssetImage(path),fit: BoxFit.contain),
            ),
          ),
      );
    }

    return contenedores;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '$titulo${requiredField ? ' *' : ''}',
            ),
          ),
          GestureDetector(
            onTap: () async {
              final picker = ImagePicker();
              final XFile? pickedFile = await picker.pickImage(source: _getImageSourceType(), imageQuality: 100);

              setState(() {
                pickedFilePaths.add(pickedFile!.path);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: DottedBorder(
                color: Colors.black,
                strokeWidth: 1,
                dashPattern: [10,6],
                borderType: BorderType.RRect,
                radius: const Radius.circular(20),
                child: Container(
                  height: 200,
                  width: 800,
                  decoration: _buildBoxDecoration(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: _getImage(null)
                  ),
                ),
              ),
            ),
          ),
          if (tipo == ImageFormType.camera && pickedFilePaths.isNotEmpty)
            Row(
              children:
                _getCurrentImages(),
          )
          else const Text(''),
          if (tipo == ImageFormType.camera)
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(left: 10.0, top: 30.0, right: 10.0),
              child: const TextForm(requiredField: false, titulo: "Descripción de la imagen añadida", tipo: TextFormType.description),
            )
          else const Text(''),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    );
  }
}
