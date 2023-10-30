import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/form_type.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadForm extends StatefulWidget {
  final bool requiredField;
  final String titulo;
  final FormType tipo;
  String? pickedFilePath;

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
  FormType tipo = FormType.title;
  final bool requiredField;

  _UploadFormState({required this.requiredField, required this.titulo, required this.tipo});


  double getContentPadding () {
    if (tipo == FormType.title) {
      return 12.0;
    } else if (tipo == FormType.description) {
      return 200.0;
    } else {
      return 12.0; // Valor por defecto
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
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: DottedBorder(
              color: Colors.black,
              strokeWidth: 1,
              dashPattern: [10,6],
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
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
