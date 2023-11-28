import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dability/Components/full_screen_image.dart';
import 'package:dability/Components/text_form.dart';
import 'dart:io';
import 'package:dability/Components/list_step.dart';
<<<<<<< HEAD
=======
import 'dart:developer';
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1

class StepsTaskForm extends StatefulWidget {
  final bool requiredField;
  List<ListStep> steps;

  StepsTaskForm({
    Key? key,
    required this.requiredField,
    required this.steps,
  }) : super(key: key);

  @override
<<<<<<< HEAD
  State<StepsTaskForm> createState() =>
      _StepsTaskFormState(requiredField: requiredField, steps: steps);
}

class _StepsTaskFormState extends State<StepsTaskForm> {
=======
  _StepsTaskFormState createState() => _StepsTaskFormState(requiredField: requiredField, steps: steps);
}

class _StepsTaskFormState extends State<StepsTaskForm> {
  final _formKey = GlobalKey<FormState>();
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
  String campoRequerido = "* Campo requerido";
  final bool requiredField;
  // Lista para almacenar los pictogramas con descripcion
  List<ListStep> steps;

  String selectedImage = "";
  String selectedVideo = "";
  String actualDescription = "";
<<<<<<< HEAD
  List<String> imageDescriptions = [
    'Ejemplo de descripcion imagen 1',
    'Ejemplo de descripcion imagen 1'
  ];
  final descriptionController = TextEditingController();
  final TextEditingController _numPaso = TextEditingController();
  TextForm textForm = TextForm(
      requiredField: false,
      titulo: "Descripcion del pictograma",
      tipo: TextFormType.description);
=======
  List<String> imageDescriptions = ['Ejemplo de descripcion imagen 1','Ejemplo de descripcion imagen 1'];
  final descriptionController = TextEditingController();
  final TextEditingController _numPaso = TextEditingController();
  TextForm textForm = TextForm(requiredField: false, titulo: "Descripcion del pictograma", tipo: TextFormType.description);
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
  bool error = false;

  // Constructor de la clase state
  _StepsTaskFormState({required this.requiredField, required this.steps});

<<<<<<< HEAD
  void _getLastDescriptionValue() {
=======
  void _getLastDescriptionValue () {
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
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

<<<<<<< HEAD
  Widget _getForm() {
    return Column(
      children: [
        Container(
          decoration: _buildBoxDecoration(),
          padding: EdgeInsets.only(top: 30, bottom: 30),
          margin: EdgeInsets.only(bottom: 50),
          child: Column(
            children: [
              const Text("Añade una imagen"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 100);

                        setState(() {
                          selectedImage = pickedFile!.path;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.all(20),
                        child: DottedBorder(
                          color: Colors.black,
                          strokeWidth: 1,
                          dashPattern: [10, 6],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(20),
                          child: Container(
                            height: 200,
                            width: 800,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(45),
                                child: _getImage(null)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 100);

                      setState(() {
                        selectedImage = pickedFile!.path;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Icon(Icons.photo_camera, size: 50,),
=======
  Widget _getForm () {
      return Column(
          children: [
            Container(
              decoration: _buildBoxDecoration(),
              padding: EdgeInsets.only(top: 30, bottom: 30),
              margin: EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  const Text("Añade una imagen"),
                  Row(
                    children: [
                      Container(
                        width: 700,
                        padding: EdgeInsets.all(30),
                        child: GestureDetector(
                          onTap: () async {
                            final picker = ImagePicker();
                            final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

                            setState(() {
                              selectedImage = pickedFile!.path;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                            ),
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
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    child: _getImage(null)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () async {
                            final picker = ImagePicker();
                            final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

                            setState(() {
                              selectedImage = pickedFile!.path;
                            });
                            },
                          child: Container(
                            child: Icon(Icons.photo_camera),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: _buildBoxDecoration(),
              padding: EdgeInsets.only(top: 30, bottom: 30),
              margin: EdgeInsets.only(bottom: 50),
              child: Column (
                children: [
                  const Text("Añadir una descripción del paso: "),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 10.0, top: 30.0, right: 10.0),
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
                      validator: (value) {
                        return (value == null || value.isEmpty) ? '' : null;
                        },
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
                    ),
                  ),
                ],
              ),
<<<<<<< HEAD
            ],
          ),
        ),
        Container(
          decoration: _buildBoxDecoration(),
          padding: EdgeInsets.only(top: 30, bottom: 30),
          margin: EdgeInsets.only(bottom: 50),
          child: Column(
            children: [
              const Text("Añadir una descripción del paso: "),
              Container(
                padding: const EdgeInsets.all(20.0),
                margin:
                    const EdgeInsets.only(left: 10.0, top: 30.0, right: 10.0),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(10, 20, 0, 200),
                    helperText: requiredField ? campoRequerido : null,
                    alignLabelWithHint: true,
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value) {
                    return (value == null || value.isEmpty) ? '' : null;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getImage(String? urlPath) {
    if (urlPath == null) {
      return const Image(
          image: AssetImage('images/no_image.png'), fit: BoxFit.contain);
    } else {
      return Image.file(File(urlPath), fit: BoxFit.cover);
=======
            ),
          ],
      );
    }

  Widget _getImage(String? urlPath) {
    if (urlPath == null) {
      return const Image(image: AssetImage('assets/images/no_image.png'),fit: BoxFit.contain);
    }
    else {
      return Image.file(File(urlPath),fit: BoxFit.cover);
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir un paso a la tarea"),
<<<<<<< HEAD
        backgroundColor: Color(0xFF4A6987),
      ),
      body: SingleChildScrollView(
        child: Column(
=======
      ),
      body: SingleChildScrollView (
        child: Column (
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
          children: [
            Container(
              padding: EdgeInsets.all(30),
              child: _getForm(),
            ),
            Container(
              decoration: _buildBoxDecoration(),
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
<<<<<<< HEAD
              child: Column(
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
                        } else {
                          setState(() {
                            error = false;
                          });
                        }
                      },
                    ),
                  ),
                  if (error == true)
                    const Text(
                        'El número del paso debe ser positivo a partir de 1',
                        style: TextStyle(color: Colors.red)),
                  if (error == false) const Text(''),
                ],
              ),
=======
            child: Column(
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
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
            ),
            Container(
              padding: EdgeInsets.all(100),
              child: ElevatedButton(
<<<<<<< HEAD
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A6987),
                ),
                onPressed: () {
                  int numStep = (int.parse(_numPaso.text));
                  // Buscamos el paso según el numStep
                  var existingStep = steps.firstWhere(
                      (step) => step.numStep == numStep,
                      orElse: () => ListStep(numStep, '', 'null'));
                  // Si se ha encontrado:
                  if ('null' != existingStep.description) {
                    if (selectedImage != '') existingStep.image = selectedImage;
                    if (actualDescription != '') {
                      existingStep.description = actualDescription;
                    }
                  } else {
                    steps.add(ListStep(numStep, selectedImage,
                        actualDescription));
=======
                onPressed: () {

                  int numStep = (int.parse(_numPaso.text));
                  // Buscamos el paso según el numStep
                  var existingStep = steps.firstWhere((step) => step.numStep == numStep, orElse: () => ListStep(numStep, '', 'null', ''));
                  // Si se ha encontrado:
                  if ('null' != existingStep.description) {
                    if (selectedImage != '' && selectedImage != null)
                      existingStep.image = selectedImage;
                    if (actualDescription != '' && actualDescription != null)
                      existingStep.description = actualDescription;

                    // TODO: Video se ve como descripcion, cambiar
                    if (selectedVideo != '' && selectedVideo != null)
                      existingStep.video = selectedVideo;
                  }
                  else {
                    steps.add(ListStep(numStep, selectedImage, actualDescription, selectedVideo));
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
                  }

                  if (numStep > 0) {
                    // Ordenamos la lista
<<<<<<< HEAD
                    steps.sort((a, b) => a.numStep.compareTo(b.numStep));
=======
                    steps.sort((a,b) => a.numStep.compareTo(b.numStep));
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1

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

<<<<<<< HEAD
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ));
=======

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.grey,
        width: 1,
      )
    );
>>>>>>> 1a82e2991b5eccdffe318c9409f2e30b499964d1
  }
}
