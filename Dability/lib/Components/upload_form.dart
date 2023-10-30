import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/form_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dability/Components/current_images.dart';
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
  List<String> pickedFilePaths = [];

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

          Container(
            child: pickedFilePaths.isNotEmpty ? CurrentImages(images: pickedFilePaths) : const Text('Aqui se mostrarán las imágenes añadidas'),
          )
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
