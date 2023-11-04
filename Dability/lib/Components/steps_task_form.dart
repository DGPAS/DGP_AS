import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/form_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dability/Components/full_screen_image.dart';
import 'package:dability/Components/text_form.dart';
import 'dart:io';
import 'package:dability/Components/tuple_string.dart';

class StepsTaskForm extends StatefulWidget {
  final bool requiredField;
  final String titulo;
  final StepsFormType tipo;

  StepsTaskForm({
    Key? key,
    required this.requiredField,
    required this.titulo,
    required this.tipo,
  }) : super(key: key);

  @override
  _StepsTaskFormState createState() => _StepsTaskFormState(requiredField: requiredField, titulo: titulo, tipo: tipo);
}

class _StepsTaskFormState extends State<StepsTaskForm> {
  final _formKey = GlobalKey<FormState>();
  String campoRequerido = "* Campo requerido";
  String titulo = "";
  StepsFormType tipo;
  final bool requiredField;
  // Lista para almacenar los pictogramas con descripcion
  List<TupleString> pickedFileDescPaths = [
    TupleString('assets/images/no_image.png', 'Ejemplo descripcion de la imagen 1'),
    TupleString('assets/images/no_image.png', 'Ejemplo descripcion de la imagen 1')
  ];

  String selectedImage = "";
  String actualDescription = "";
  List<String> imageDescriptions = ['Ejemplo de descripcion imagen 1','Ejemplo de descripcion imagen 1'];
  final descriptionController = TextEditingController();
  TextForm textForm = TextForm(requiredField: false, titulo: "Descripcion del pictograma", tipo: TextFormType.description);

  _StepsTaskFormState({required this.requiredField, required this.titulo, required this.tipo});

  void _getLastDescriptionValue () {
    actualDescription = descriptionController.text;
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    descriptionController.addListener(_getLastDescriptionValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    descriptionController.dispose();
    super.dispose();
  }

  ImageSource _getImageSourceType () {
    if (tipo == StepsFormType.camera) {
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

  void _addImage(String imagePath, String description) {
    setState(() {
      pickedFileDescPaths.add(TupleString(imagePath, ''));
      imageDescriptions.add(description);
    });
  }

  List<Widget> _getCurrentImages () {
    List<Widget> contenedores = [];
    for (var i = 0; i < pickedFileDescPaths.length; i++) {
      contenedores.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FullScreenImage(image: pickedFileDescPaths[i].tuple1, text: imageDescriptions[i]),
              ));
            },
            child: Container (
              height: 100,
              padding: const EdgeInsets.all(10),
              child: Image(image: AssetImage(pickedFileDescPaths[i].tuple1),fit: BoxFit.contain),
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
                selectedImage = pickedFile!.path;
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
          if (tipo == StepsFormType.camera && pickedFileDescPaths.isNotEmpty)
            Row(
              children:
                _getCurrentImages(),
          ),
          if (tipo == StepsFormType.camera)
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(left: 10.0, top: 30.0, right: 10.0),
              child: textForm,
              /*child: TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(10,20,0,200),
                  helperText: requiredField ? campoRequerido : null,
                  alignLabelWithHint: true,
                ),
                textAlignVertical: TextAlignVertical.top,
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (value) {
                  return (value == null || value.isEmpty) ? '' : null;
                },
              ),*/

            ),
          if (tipo == StepsFormType.camera)
            ElevatedButton(
              onPressed: () {
                // Esta función se ejecutará cuando se presione el botón "Añadir imagen"
                _addImage(selectedImage, actualDescription);
              },
              child: Text('Añadir imagen'),
            ),
          Text(textForm.getText()),
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
