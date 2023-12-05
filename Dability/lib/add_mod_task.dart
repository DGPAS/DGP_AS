import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:dability/Components/steps_task_form.dart';
import 'package:file_picker/file_picker.dart';
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
      this.idTasks,
      this.thumbnail,
      this.videoUrl})
      : super(key: key);

  AddModType typeForm;
  String? title;
  String? description;
  String? idTasks;
  String? thumbnail;
  String? videoUrl;

  @override
  State<AddModTask> createState() => _AddModTaskState(
      typeForm: typeForm,
      title: title,
      description: description,
      idTasks: idTasks,
      thumbnail: thumbnail,
      videoUrl: videoUrl,
  );
}




class _AddModTaskState extends State<AddModTask> {
  _AddModTaskState(
      {required this.typeForm, this.title, this.description, this.idTasks, this.thumbnail, this.videoUrl});

  // Formulario para el titulo de la tarea
  TextForm titleForm = TextForm(
      requiredField: true,
      title: "Nombre de la tarea",
      type: TextFormType.title);
  // Formulario para la descripción de la tarea
  TextForm descriptionForm = TextForm(
      requiredField: false,
      title: "Descripción general de la tarea",
      type: TextFormType.description);

  // Variables donde se almacenará el valor del titulo y la descripcion
  String? title;
  String? description;
  String? idTasks;
  String? thumbnail;
  Image? thumbnailImage;
  String? videoUrl;
  // isPressed: variable para la ayuda de añadir pasos
  bool isPressed = false;
  AddModType typeForm;

  List<ListStep> steps = [];
  List<ListStep> copy = [];
  List<ListStep> auxSteps = [];
  String actualTaskId = '';
  File? _image;
  File? _video;
  String selectedImage = "";
  String selectedVideo = "";
  
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

    if (idTasks != null) {
      getInitialSteps();
      actualTaskId = idTasks!;
    }

    if(widget.thumbnail != null) {
     selectedImage = widget.thumbnail!;
    }
    getThumbnail();
    isPressed = false;
  }


  // Funcion que devuelve los pasos la tarea, si existe, guardados en la base de datos
  Future<void> getInitialSteps() async {
    // La direccion ip debe ser la de red del portatil para conectar con
    // la tablet ó 10.0.2.2 para conectar con emuladores
    String uri = "${dotenv.env['API_URL']}/view_steps.php?idTarea=$idTasks";
    try {
      print(idTasks!);
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
            stepData['numStep'],
            stepData['image'],
            stepData['description'],
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
      await saveVideo();
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
          "name": title?.trim(),
          "description": description?.trim(),
          "thumbnail": '',
          "video": '',
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Datos insertados");

          int newTaskId = response["idTasks"];
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
        "numStep": step.numStep.toString(),
        "idTask": actualTaskId,
        "description": step.description,
        "image": step.image
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
        "idTasks": idTareas,
        "name": title?.trim(), // nombre
        "description": description?.trim(),
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
        "idTask": idTasks,
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
      request.fields['idTasks'] = actualTaskId;
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

 Future<void> saveVideo() async {
  if (selectedVideo == "") {
    print("No se ha seleccionado ningún video");
    return;
  }

  String uri = "${dotenv.env['API_URL']}/saveVideo.php";

  try {
    var request = http.MultipartRequest('POST', Uri.parse(uri));

    // Puedes agregar la lógica para seleccionar un video específico en el emulador
    // Esto puede variar según el emulador que estés utilizando

    // Simplemente usa el path del video seleccionado
    request.fields['idTasks'] = actualTaskId;
    var videoFile = await http.MultipartFile.fromPath("video", selectedVideo);
    request.files.add(videoFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Video Uploaded");
      print("Response Body: ${await response.stream.bytesToString()}");
    } else {
      print("Error in uploading video. Status Code: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception during video upload: $e");
  }
}



void getThumbnail() {
    setState(() {
      thumbnailImage = Image.network("${dotenv.env['API_URL']}/images/$thumbnail");
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
      if(typeForm == AddModType.add || (typeForm == AddModType.mod && urlPath != widget.thumbnail)) {
        return Image.file(File(urlPath), fit: BoxFit.cover);
      } else {
        return Image.network("${dotenv.env['API_URL']}/images/$urlPath", fit: BoxFit.cover);
      }
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
              Container(
                decoration: _buildBoxDecoration(),
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
              
              //Contenedor para añadir videos
              if(typeForm == AddModType.add) 
              Container(
    decoration: _buildBoxDecoration(),
    padding: const EdgeInsets.all(20.0),
    margin: const EdgeInsets.only(top: 30.0, left: 10.0, right: 20.0),
    child: Column(
      children: [
        const Text("Añade un video para la tarea"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  // Aquí puedes agregar la lógica para grabar un video
                  // Puedes usar el paquete camera o el que prefieras
                  // En este ejemplo, estoy utilizando el paquete image_picker
                  final picker = ImagePicker();
                  final XFile? pickedFile = await picker.pickVideo(
                    source: ImageSource.gallery,
                  );
                setState(() {
                  selectedVideo = pickedFile!.path;
                  _video = File(selectedVideo);

                });
                  if (pickedFile != null) {
                    // Puedes manejar el archivo de video grabado aquí
                    print(pickedFile.path);
                  }
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
                      // Puedes personalizar este widget según tu necesidad
                      child: const Icon(Icons.video_library, size: 50),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                // Aquí puedes agregar la lógica para grabar un video
                // Puedes usar el paquete camera o el que prefieras
                // En este ejemplo, estoy utilizando el paquete image_picker
                final picker = ImagePicker();
                final XFile? pickedFile = await picker.pickVideo(
                  source: ImageSource.camera,
                );

                if (pickedFile != null) {
                  // Puedes manejar el archivo de video grabado aquí
                  print(pickedFile.path);
                }
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Icon(Icons.videocam, size: 50),
              ),
            ),
          ],
        ),
      ],
    ),
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
                  title = titleForm.getText();
                  description = descriptionForm.getText();
                  if ((title == '' || title == null) ||
                  (description == '' || description == null)) {
                  print("Los campos titulo y descripción son obligatorios");
                  } else {
                    submitForm(idTasks);
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
