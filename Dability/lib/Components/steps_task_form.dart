import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/form_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dability/Components/full_screen_image.dart';
import 'package:dability/Components/text_form.dart';
import 'dart:io';
import 'package:dability/Components/list_step.dart';
import 'dart:developer';

class StepsTaskForm extends StatefulWidget {
  final bool requiredField;
  final String titulo;
  final StepsFormType tipo;
  List<ListStep> steps;

  StepsTaskForm({
    Key? key,
    required this.requiredField,
    required this.titulo,
    required this.tipo,
    required this.steps,
  }) : super(key: key);

  @override
  _StepsTaskFormState createState() => _StepsTaskFormState(requiredField: requiredField, titulo: titulo, tipo: tipo, steps: steps);
}

class _StepsTaskFormState extends State<StepsTaskForm> {
  final _formKey = GlobalKey<FormState>();
  String campoRequerido = "* Campo requerido";
  String titulo = "";
  StepsFormType tipo;
  final bool requiredField;
  // Lista para almacenar los pictogramas con descripcion
  List<ListStep> steps;

  String selectedImage = "";
  String actualDescription = "";
  List<String> imageDescriptions = ['Ejemplo de descripcion imagen 1','Ejemplo de descripcion imagen 1'];
  final descriptionController = TextEditingController();
  final TextEditingController _numPaso = TextEditingController();
  TextForm textForm = TextForm(requiredField: false, titulo: "Descripcion del pictograma", tipo: TextFormType.description);
  bool error = false;

  // Constructor de la clase state
  _StepsTaskFormState({required this.requiredField, required this.titulo, required this.tipo, required this.steps});

  void _getLastDescriptionValue () {
    actualDescription = descriptionController.text;
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    descriptionController.addListener(_getLastDescriptionValue);
    error = false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    descriptionController.dispose();
    super.dispose();
  }

  Widget _getFormType () {
    if (tipo == StepsFormType.camera || tipo == StepsFormType.gallery) {
      return GestureDetector(
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
      );
    }
    else if (tipo == StepsFormType.description) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(left: 10.0, top: 30.0, right: 10.0),
        /*child: textForm,*/
        child: TextFormField(
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
        ),
      );
    }
    else if (tipo == StepsFormType.image_description) {
      return Column(
          children: [GestureDetector(
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
          Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(left: 10.0, top: 30.0, right: 10.0),
            /*child: textForm,*/
            child: TextFormField(
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
            ),
          )
        ],
      );
    }
    else {
      return const Text('en desarrollo');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: SingleChildScrollView (
        child: Column (
          children: [
            Container(
              child: _getFormType(),
            ),
            Column(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Indica con un número a qué paso pertenece',
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _numPaso,
                    onChanged: (String value) {
                      if (int.parse(value) < 1) {
                        setState(() {
                          error = true;
                        });
                      }
                      else {
                        setState(() {
                          error = false;
                        });
                      }
                    },
                  ),
                ),
                if (error == true)
                  const Text('El número del paso debe ser positivo a partir de 1', style: TextStyle(color: Colors.red)),
                if (error == false)
                  const Text(''),
              ],
            ),
            Container(
              padding: EdgeInsets.all(100),
              child: ElevatedButton(
                onPressed: () {

                  int numStep = (int.parse(_numPaso.text));
                  // Buscamos el paso según el numStep
                  var existingStep = steps.firstWhere((step) => step.numStep == numStep, orElse: () => ListStep(numStep, '', 'null', ''));
                  // Si se ha encontrado:
                  log(existingStep.description);
                  if ('null' != existingStep.description) {
                    if (tipo == StepsFormType.camera || tipo == StepsFormType.gallery)
                      existingStep.image = selectedImage;
                    if (tipo == StepsFormType.description)
                      existingStep.description = actualDescription;
                    if (tipo == StepsFormType.image_description) {
                      existingStep.description = actualDescription;
                      existingStep.image = selectedImage;
                    }
                    // TODO: Video se ve como descripcion, cambiar
                    if (tipo == StepsFormType.video)
                      existingStep.video = selectedImage;
                  }
                  else {
                    if (tipo == StepsFormType.camera || tipo == StepsFormType.gallery)
                      steps.add(ListStep(numStep, selectedImage, '', ''));
                    if (tipo == StepsFormType.description)
                      steps.add(ListStep(numStep, '', actualDescription, ''));
                    if (tipo == StepsFormType.image_description) {
                      steps.add(ListStep(numStep, selectedImage, actualDescription, ''));
                    }
                    if (tipo == StepsFormType.video)
                      steps.add(ListStep(numStep, selectedImage, '', ''));
                  }

                  if (numStep > 0) {
                    // Ordenamos la lista
                    steps.sort((a,b) => a.numStep.compareTo(b.numStep));

                    // Devolvemos la lista a la pagina anterior
                    Navigator.of(context).pop(steps);
                  }
                },
                child: const Text('Añadir paso'),
              ),
            ),
          ],
        ),
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
