import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:dability/Components/steps_task_form.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:dability/Components/list_step.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class AddModTask extends StatefulWidget {
  AddModTask(
      {Key? key,
      required this.typeForm,
      this.title,
      this.description,
      this.idTareas,
      this.miniatura})
      : super(key: key);

  AddModType typeForm;
  String? title;
  String? description;
  String? idTareas;
  String? miniatura;

  @override
  State<AddModTask> createState() => _AddModTaskState(
      typeForm: typeForm,
      title: title,
      description: description,
      idTareas: idTareas,
      miniatura: miniatura,
  );
}




class _AddModTaskState extends State<AddModTask> {
  _AddModTaskState(
      {required this.typeForm, this.title, this.description, this.idTareas, this.miniatura});

  // Formulario para el titulo de la tarea
  TextForm titleForm = TextForm(
      requiredField: true,
      titulo: "Nombre de la tarea",
      tipo: TextFormType.title);
  // Formulario para la descripción de la tarea
  TextForm descriptionForm = TextForm(
      requiredField: true,
      titulo: "Descripción general de la tarea",
      tipo: TextFormType.description);

  // Variables donde se almacenará el valor del titulo y la descripcion
  String? title;
  String? description;
  String? idTareas;
  String? miniatura;
  Image? miniaturaImage;
  // isPressed: variable para la ayuda de añadir pasos
  bool isPressed = false;
  AddModType typeForm;

  List<ListStep> steps = [];
  List<ListStep> copy = [];
  List<ListStep> auxSteps = [];
  String actualTaskId = '';
  File? _image;
  String selectedImage = "";


  @override
  void initState() {
    super.initState();
    // Si title o description es nulo
    // (es decir, si lo que se quiere es añadir una tarea y no modificarla)
    // se inicializan segun el valor del controlador
    title ??= titleForm.getText();
    description ??= descriptionForm.getText();

    titleForm.originalText = title;
    titleForm.text = title!;
    descriptionForm.originalText = description;
    descriptionForm.text = description!;

    if (idTareas != null) {
      getInitialSteps();
    }
    getMiniature();
    isPressed = false;
  }


  // Funcion que devuelve los pasos la tarea, si existe, guardados en la base de datos
  Future<void> getInitialSteps() async {
    // La direccion ip debe ser la de red del portatil para conectar con
    // la tablet ó 10.0.2.2 para conectar con emuladores
    String uri = "${dotenv.env['API_URL']}/view_steps.php?idTarea=$idTareas";
    try {
      print(idTareas!);
      var response = await http.get(
        Uri.parse(uri),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<ListStep> loadedSteps = [];

        // Convertir cada elemento en responseData a ListStep y agregarlo a loadedSteps
        for (var stepData in responseData) {
          loadedSteps.add(ListStep(
            stepData['numPaso'],
            stepData['imagen'],
            stepData['descripcion'],
          ));
        }

        setState(() {
          steps = loadedSteps;
        });
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> submitForm (String? idTareas) async {
    if (typeForm == AddModType.add) {
      await insertTaskData();
      await uploadImage();
      print ("Id obtenido: $actualTaskId");
      for (int i = 0; i < steps.length; i++) {
        await insertStepsData(steps[i]);
      }
    } else {
      await updateData(idTareas);
      await uploadImage();
      await updateSteps();

    }
  }

  Future<void> insertTaskData() async {
    try {
        String uri = "${dotenv.env['API_URL']}/insert_task.php";

        var res = await http.post(Uri.parse(uri), body: {
          "nombre": title?.trim(),
          "descripcion": description?.trim(),
          "miniatura": '',
          "video": '',
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Datos insertados");

          int newTaskId = response["idTareas"];
          print("Nuevo idTareas: $newTaskId");
          setState(() {
            actualTaskId = newTaskId.toString();
          });
        } else {
          print("Datos no insertados");
        }
      } catch (e) {
        print(e);
      }
  }

  Future<void> insertStepsData(ListStep step) async {
    try {
      String uri = "${dotenv.env['API_URL']}/insert_steps.php";

      print('Datos a enviar: numPaso: ${step.numStep}, idTarea: $actualTaskId, description: ${step.description}, imagen: ${step.image}');

      var res = await http.post(Uri.parse(uri), body: {
        "numPaso": step.numStep.toString(),
        "idTarea": actualTaskId,
        "descripcion": step.description,
        "imagen": step.image
      });

      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Datos insertados");
      } else {
        print("Datos no insertados");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateData (String? idTareas) async {
    String uri = "${dotenv.env['API_URL']}/update_data.php";

    try {
      print("Datos a modificar: ${title}, ${description}");

      var res=await http.post(Uri.parse(uri),body: {
        "idTareas": idTareas,
        "nombre": title?.trim(),
        "descripcion": description?.trim(),
      });

      var response=jsonDecode(res.body);

      if(response["success"]=="true"){
        print("Datos actualizados");
      }else{
        print("Some issue");

      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateSteps () async {
    String uri = "${dotenv.env['API_URL']}/update_steps.php";

    try {
      var res=await http.post(Uri.parse(uri),body: {
        "steps": jsonEncode(steps.map((step) => step.toJson()).toList()),
        "idTarea": idTareas,
      });

      var response=jsonDecode(res.body);

      if(response["success"]=="true"){
        print("Steps actualizados");
      }else{
        print("Some issue");

      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadImage() async {
    String uri = "${dotenv.env['API_URL']}/upload_image.php";

    try {

      var request = http.MultipartRequest('POST', Uri.parse(uri));
      request.fields['idTareas'] = actualTaskId;
      var picture = await http.MultipartFile.fromPath("image", selectedImage);
      request.files.add(picture);
      var response = await request.send();

      if (response.statusCode == 200) {
        print ("Image Uploaded");
      }
      else {
        print("Error en la subida");
      }

    } catch (e) {
      print(e);
    }
  }

void getMiniature() {
    setState(() {
      miniaturaImage = Image.network("${dotenv.env['API_URL']}/images/$miniatura");
    });
  }

  // Función para cambiar el titulo de la barra segun sea crear o modificar
  String getTitle () {
    if (typeForm == AddModType.add) {
      return 'Crear Tarea';
    } else {
      return 'Modificar tarea: $title';
    }
  }

  String getSubmitButton () {
    if (typeForm == AddModType.add) {
      return 'Crear';
    } else {
      return 'Modificar';
    }
  }

  Widget _getImage(String? urlPath) {
    if (urlPath == null || urlPath == '') {
      return const Image(
          image: AssetImage('images/no_image.png'), fit: BoxFit.contain);
    } else {
      return Image.file(File(urlPath), fit: BoxFit.cover);
    }
  }

  // Función que devuelve en columna todos los pasos añadidos
  List<Widget> getSteps() {
    return steps.map((step) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Paso ${step.numStep}, formatos:',
                    style: const TextStyle(fontWeight: FontWeight.bold)),

                // Botón para eliminar el paso
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.red),
                    ),
                    child: const Text('Eliminar Paso'),
                    onPressed: () {
                      auxSteps = steps;
                      auxSteps.removeWhere((stepToDelete) =>
                          stepToDelete.numStep == step.numStep);
                      setState(() {
                        steps = auxSteps;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          if (step.image != '' && step.image != null)
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  alignment: Alignment.topLeft,
                  child: const Text('Imagen'),
                ),
                Image(image: AssetImage(step.image), fit: BoxFit.contain),
              ],
            ),
          if (step.description != '')
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  alignment: Alignment.topLeft,
                  child: const Text('Descripción'),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 30, top: 20),
                  child: Text(
                    step.description,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
              bottom: 30.0, top: 30.0, left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              // Contenedor para introducir el título de la tarea en el formulario
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: titleForm,
              ),
              // Contenedor para introducir la descripción de la tarea en el formulario
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                padding: const EdgeInsets.all(20.0),
                margin:
                    const EdgeInsets.only(left: 10.0, top: 30.0, right: 20.0),
                child: descriptionForm,
              ),
              // Contenedor para añadir una miniatura a la tarea
             if(typeForm == AddModType.add) 
              Container(
                //decoration: _buildBoxDecoration(),
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(top: 30.0, left: 10.0, right: 20.0),
                child: Column(
                  children: [
                    const Text("Añade una miniatura para la tarea"),
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
                                _image = File(selectedImage);
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
                                      child: _getImage(selectedImage)),
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
                              _image = File(selectedImage);
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
               if(typeForm == AddModType.mod)
              Container(
                decoration: _buildBoxDecoration(),
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(top: 30.0, left: 10.0, right: 20.0),
                width:  300,
                height: 300,
                child: miniaturaImage,

                
              ),
              // Contenedor con para añadir los pasos
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(
                    left: 10.0, top: 30.0, right: 20.0, bottom: 20.0),

                // Columna que muestra instrucciones en forma de texto y una serie de botones
                // que llevan a las páginas para añadir pasos de la tarea en diferente formato
                child: Container(
                  width: 1000,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          const Text('Puede añadir pasos a la tarea.'),
                          Container(
                            child: GestureDetector(
                              onTapDown: (_) {
                                setState(() {
                                  isPressed = true;
                                });
                              },
                              onTapUp: (_) {
                                setState(() {
                                  isPressed = false;
                                });
                              },
                              child: Container(
                                child: const Icon(Icons.help),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Contenedor con la ayuda
                      if (isPressed == true)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              )),
                          child: const Column(
                            children: [
                              Text(
                                  'Tenga en cuenta que para cada paso, puede añadir distintos formatos y no es necesario que contenga todos, aunque si recomendable. Para ello, rellene los campos deseados e introduzca el número de paso al que corresponde.'),
                              Text(
                                  'Luego se le mostrará a cada estudiante el formato de pasos más indicado.'),
                              Text(
                                  'Además, si ya ha creado un paso, puede modificar sus valores o añadir formatos nuevos introduciendo el número de paso dentro.'),
                            ],
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.only(
                            left: 10.0, top: 10.0, right: 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4A6987),
                          ),
                          onPressed: () async {
                            copy = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StepsTaskForm(
                                      requiredField: false, steps: steps),
                                ));
                            setState(() {
                              steps = copy;
                            });
                          },
                          child: const Text('Añadir un paso'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Container para mostrar los pasos añadidos
              const Text('Previsualización de la tarea en creación:'),
              Container(
                width: 1000,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                padding: const EdgeInsets.all(20.0),
                margin:
                    const EdgeInsets.only(left: 10.0, top: 10.0, right: 20.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4A6987),
                        ),
                        child: const Text('Refrescar'),
                        onPressed: () {
                          setState(() {
                            title = titleForm.getText();
                            description = descriptionForm.getText();
                          });
                        },
                      ),
                    ),
                    if (title != "")
                      Text(
                        'Título: $title',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    if (description != "")
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: [
                            const Text('Descripción general',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(description ?? '',
                                textAlign: TextAlign.justify),
                          ],
                        ),
                      ),
                    Column(
                      children: getSteps(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Botones "Cancelar y Crear"
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF4A6987),
        height: 50,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: <Widget>[
                    Text('Cancelar ', style: TextStyle(color: Colors.black)),
                    Icon(Icons.cancel_presentation, color: Colors.redAccent),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.white)),
                onPressed: () {
                  if ((title == '' || title == null) ||
                  (description == '' || description == null)) {
                  print("Los campos titulo y descripción son obligatorios");
                  } else {
                    submitForm(idTareas);
                    Navigator.of(context).pop();
                  }
                },
                    child: Row(
                  children: <Widget>[
                    Text(getSubmitButton(), style: TextStyle(color: Colors.black)),
                    Icon(Icons.add, color: Colors.lightGreenAccent),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
