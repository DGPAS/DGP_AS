import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dability/Components/text_form.dart';
import 'dart:io';
import 'package:dability/Components/list_step.dart';

/// # Page for add a step task
///
/// It receives a required param [requiredField] that indicates if the step
/// description is required and another required param [steps] were it will
/// be stored the new task
class StepsTaskForm extends StatefulWidget {
  final bool requiredField;
  List<ListStep> steps;

  StepsTaskForm({
    Key? key,
    required this.requiredField,
    required this.steps,
  }) : super(key: key);

  @override
  State<StepsTaskForm> createState() =>
      _StepsTaskFormState(isRequiredField: requiredField, steps: steps);
}

class _StepsTaskFormState extends State<StepsTaskForm> {
  String requiredField = "* Campo requerido";
  final bool isRequiredField;

  List<ListStep> steps;

  String selectedImage = "";
  String selectedVideo = "";
  String actualDescription = "";

  final descriptionController = TextEditingController();
  final TextEditingController _numStep = TextEditingController();
  TextForm textForm = TextForm(
      requiredField: false,
      title: "Descripcion del pictograma",
      type: TextFormType.description);
  bool error = false;

  _StepsTaskFormState({required this.isRequiredField, required this.steps});

  /// Function that updates de [actualDescription] with
  /// the controller [descriptionController]
  void _getLastDescriptionValue() {
    actualDescription = descriptionController.text;
  }

  @override
  void initState() {
    super.initState();

    /// Start listening to changes
    descriptionController.addListener(_getLastDescriptionValue);
    error = false;
  }

  /// Cleans up the [descriptionController] when the widget is removed from the
  /// widget tree.
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  /// Function that returns a Column Widget with two forms content:
  ///
  /// An image for the step, it can be added from gallery or by taking a photo
  /// And a description for the step
  Widget _getForm() {
    return Column(
      children: [
        /// The container to add an image
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
                  /// It adds the image from the gallery
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
                  /// It adds the image from camera
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /// Container to add a description
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
                    helperText: isRequiredField ? requiredField : null,
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

  /// Function that returns widget of the image step of the task by its [urlPath]
  ///
  /// If [urlPath] is null, it returns the default image with [AssetImage]
  ///
  /// if [urlPath] is not null it means that an image has been added
  /// so we show it with [Image.file]
  Widget _getImage(String? urlPath) {
    if (urlPath == null) {
      return const Image(
          image: AssetImage('images/no_image.png'), fit: BoxFit.contain);
    } else {
      return Image.file(File(urlPath), fit: BoxFit.cover);
    }
  }

  /// Main builder of the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir un paso a la tarea"),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Container that calls [_getForm] to get the image and description
            /// form
            Container(
              padding: EdgeInsets.all(30),
              child: _getForm(),
            ),
            /// Container that shows a form to add the number of the step
            Container(
              decoration: _buildBoxDecoration(),
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
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
                      controller: _numStep,
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
            ),
            /// Button to submit the creation or modification of the step
            Container(
              padding: EdgeInsets.all(100),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A6987),
                ),
                onPressed: () {
                  int numStep = (int.parse(_numStep.text));
                  /// It search the step in [steps]
                  var existingStep = steps.firstWhere(
                      (step) => step.numStep == numStep,
                      orElse: () => ListStep(numStep, '', 'null'));
                  /// If it exists ir modifies it
                  if ('null' != existingStep.description) {
                    if (selectedImage != '') existingStep.image = selectedImage;
                    if (actualDescription != '') {
                      existingStep.description = actualDescription;
                    }
                  /// If it doesn't exist it adds it at the end
                  } else {
                    steps.add(ListStep(numStep, selectedImage,
                        actualDescription));
                  }

                  if (numStep > 0) {
                    /// It sorts the list [steps]
                    steps.sort((a, b) => a.numStep.compareTo(b.numStep));

                    /// It pops to the previous page with the updated [steps]
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

  /// Predefined style for some containers
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ));
  }
}
