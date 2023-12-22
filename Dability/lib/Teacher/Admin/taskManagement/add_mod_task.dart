import 'package:dotted_border/dotted_border.dart';
import 'package:dability/Teacher/Admin/taskManagement/steps_task_form.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:dability/Components/list_step.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:dability/Api_Requests/steps_requests.dart';
import 'package:dability/Api_Requests/task_requests.dart';
/// # Page for add or modify a tasknewer
///
/// It receives a required param [typeForm] that indicates if it is
/// for add a task or modify the given one with [task]
class AddModTask extends StatefulWidget {
  AddModTask(
      {Key? key,
      required this.typeForm,
      this.task
      })
      : super(key: key);

  final AddModType typeForm;
  final Map<String, dynamic>? task;

  @override
  State<AddModTask> createState() => _AddModTaskState();
}


class _AddModTaskState extends State<AddModTask> {
  _AddModTaskState();

  /// Form that contains the name of the task to add or modify
  TextForm titleForm = TextForm(
      requiredField: true,
      title: "Nombre de la tarea",
      type: TextFormType.title);
  /// Form that contains the description of the task to add or modify
  TextForm descriptionForm = TextForm(
      requiredField: false,
      title: "Descripción general de la tarea",
      type: TextFormType.description);


  /// Variables where it will be stored the data of a task
  String? title;
  String? description;
  String? idTask;
  String? thumbnail;
  Image? thumbnailImage;
  Image? thumbnailVideo;
  String? thumbnailVideoPath; // Nuevo
  String? videoUrl;
  bool isPressed = false;
  AddModType? typeForm;

  List<ListStep> steps = [];
  List<ListStep> copy = [];
  List<ListStep> auxSteps = [];
  String actualTaskId = '';
  String selectedImage = "";
  String selectedVideo = "";


  /// Init State
  ///
  /// Initialize the task data and its steps, if it has,
  /// by calling [getTaskSteps]
  @override
  void initState() {
    super.initState();

    typeForm = widget.typeForm;
    if (typeForm == AddModType.mod) {
      title = widget.task?['taskName'];
      description = widget.task?['description'];
      idTask = widget.task?['idTask'];
      thumbnail = widget.task?['thumbnail'];
      videoUrl = widget.task?['video'];
    }
    /// If title or description are null it means that we are adding a task,
    /// not modifying it, so the values are initialized by the controllers
    title ??= titleForm.getText();
    description ??= descriptionForm.getText();

    titleForm.originalText = title;
    titleForm.text = title!;
    descriptionForm.originalText = description;
    descriptionForm.text = description!;

    /// If the task exists, it calls [getTaskSteps] and get the actualTaskId
    if (idTask != null) {
      getData();
    }

    /// If the miniature exits, it initializes it
     if (widget.task?['thumbnail'] != null) {
      selectedImage = widget.task?['thumbnail'];
      getThumbnail(thumbnail!);
    }

    // Nueva parte: Genera la miniatura del video si es una modificación y hay una URL de video
    if (typeForm == AddModType.mod && videoUrl != null) {
      _generateVideoThumbnail(videoUrl!);
    }

    isPressed = false;
  }
  
 Future<void> _generateVideoThumbnail(String videoPath) async {
  try {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 128,
      maxWidth: 128,
      quality: 100,
    );

    setState(() {
      thumbnailVideoPath = thumbnailPath;
    });
  } catch (e) {
    print('Error al generar miniatura del video: $e');
  }
}

  /// Function that calls [getTaskSteps] who returns the DataBase tasks
  /// and adds them to [steps]
  Future<void> getData () async {
    steps = await getTaskSteps(idTask!);
    setState(() {
      actualTaskId = idTask!;
    });
  }
  bool isVideo(String filePath) {
  final extension = path.extension(filePath).toLowerCase();
  return extension == '.mp4' || extension == '.mov' || extension == '.avi';
}


  /// Function that calls funtions that calls API
  ///
  /// If it is adding a task, it insert the task data,
  /// it uploads the miniature, the video and, for
  /// each step in [steps], it adds each one
  ///
  /// If it is modifying a task, it updates the task by
  /// its id [id], it updates the miniature and
  /// it updates its steps
  Future<void> submitForm (String? id) async {
    if (typeForm == AddModType.add) {
      actualTaskId = await insertTaskData(title!, description!);
      await uploadImage(actualTaskId, selectedImage);
      await saveVideo(actualTaskId, selectedVideo);
      print ("Id obtenido: $actualTaskId");
      for (int i = 0; i < steps.length; i++) {
        await insertStepsData(idTask!, steps[i]);
        await uploadImageSteps(idTask!, steps[i].selectedImage);
      }
    } else {
      await updateData(id!, title!, description!);
      await uploadImage(id, selectedImage);
      await saveVideo(id, selectedVideo);
      await updateSteps(id,steps);
      for (int i = 0; i < steps.length; i++) {
        await insertStepsData(actualTaskId, steps[i]);
        await uploadImageSteps(actualTaskId, steps[i].selectedImage);
      }
    }
  }


  /// Function that returns the title of [AppBar]
  ///
  /// If [typeForm] == [AddModType.add], it updates it to creating a task
  ///
  /// If [typeForm] == [AddModType.mod], it updates it to modifying a task
  String getTitle () {
    if (typeForm == AddModType.add) {
      return 'Crear Tarea';
    } else {
      return 'Modificar tarea: $title';
    }
  }


  /// Function that returns the submit button name of [BottomNavigationBar]
  ///
  /// If [typeForm] == [AddModType.add], it updates it to create (a task)
  ///
  /// If [typeForm] == [AddModType.mod], it updates it to modify (a task)
  String getSubmitButton () {
    if (typeForm == AddModType.add) {
      return 'Crear';
    } else {
      return 'Modificar';
    }
  }


  /// Function that returns widget of the miniature of the task by its [urlPath]
  ///
  /// If [urlPath] is null, it returns the default image with [AssetImage]
  ///
  /// if [urlPath] is not null and it is an adding task or it is a modifying task
  /// and the [urlPath] it is not the same has the miniature given at first,
  /// it means that the original miniature of the task has been modified
  /// so we show it with [Image.file]
  ///
  /// If [urlPath] its the original miniature from the DataBase task that we are
  /// modifying, we show it with [Image.network]
   Widget _getImage(String? urlPath) {
    if (urlPath == null || urlPath == '') {
      return const Image(
        image: AssetImage('assets/images/no_image.png'),
        fit: BoxFit.contain,
      );
    } else {
      if (isVideo(urlPath)) {
        return thumbnailVideoPath != null
            ? Image.file(File(thumbnailVideoPath!), fit: BoxFit.cover)
            : const Icon(Icons.video_library, size: 50);
      } else if (typeForm == AddModType.add ||
          (typeForm == AddModType.mod &&
              urlPath != widget.task?['thumbnail'])) {
        return Image.file(File(urlPath), fit: BoxFit.cover);
      } else {
        return Image.network(
          "${dotenv.env['API_URL']}/images/$urlPath",
          fit: BoxFit.cover,
        );
      }
    }
  }
  Widget _getImageSteps(String? urlPath) {
  if (urlPath == null || urlPath.isEmpty) {
    return const Image(
      image: AssetImage('assets/images/no_image.png'),
      fit: BoxFit.contain,
    );
  } else {
    return FutureBuilder<bool>(
      future: _isLocalFile(urlPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Puedes mostrar un indicador de carga aquí si es necesario
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Manejar el error si es necesario
          return const Text('Error al cargar la imagen');
        } else {
          if (snapshot.data == true) {
            // Es un archivo local
            return Image.file(File(urlPath), fit: BoxFit.cover);
          } else {
            // Es una URL remota
            return Image.network(
              "${dotenv.env['API_URL']}/images/steps/$urlPath",
              fit: BoxFit.cover,
            );
          }
        }
      },
    );
  }
}

Future<bool> _isLocalFile(String urlPath) async {
  // Implementa la lógica para verificar si el archivo en urlPath es local
  // Puedes usar File(urlPath).exists() u otras funciones para verificar la existencia local
  return await File(urlPath).exists();
}


  /// Function that returns a Column of [steps]
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

                /// Button to delete [step] from [steps]
                ElevatedButton(
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
              ],
            ),
          ),
          /// It only shows the step image when it is not null
          if (step.selectedImage != '')
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  alignment: Alignment.topLeft,
                  child: const Text('Imagen'),
                ),

                _getImageSteps(step.selectedImage),
              ],
            ),
          /// It only shows the step description when it is not null
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

  /// Main builder of the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            Expanded(
              child: Text(
                getTitle(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A6987),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/userIcon.png',
                    width: 48,
                    height: 48,
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
              bottom: 30.0, top: 30.0, left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              /// Form to introduce the [title] of the task
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
              /// Form to introduce the [description] of the task
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

              /// Container to add the [selectedImage] of the task
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
                        /// This container adds the task miniature from gallery
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
                                child: SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(45),
                                      child: _getImage(selectedImage)),
                                ),
                              ),
                            ),
                          ),
                        ),
                         
          // Video thumbnail preview
       

                        /// This container adds the task miniature from camera
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
              
              /// Containers to add a video to task
   if (typeForm == AddModType.add) 
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
                  final picker = ImagePicker();
                  final XFile? pickedFile = await picker.pickVideo(
                    source: ImageSource.gallery,
                  );

                  if (pickedFile != null) {
                    setState(() {
                      selectedVideo = pickedFile.path;
                      selectedImage = ''; // Limpiar la miniatura de la imagen cuando se selecciona un nuevo video
                      thumbnailVideoPath = null;
                    });

                    // Generar la miniatura del video seleccionado
                    await _generateVideoThumbnail(selectedVideo);
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
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: selectedVideo.isNotEmpty
                            ? thumbnailVideoPath != null
                                ? Image.file(File(thumbnailVideoPath!))
                                : const Icon(Icons.video_library, size: 50)
                            : selectedImage.isNotEmpty
                                ? _getImage(selectedImage)
                                : const Icon(Icons.videocam, size: 50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
// Modificar video
if (typeForm == AddModType.mod) 
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
                  // Lógica para seleccionar un video desde la galería
                  final picker = ImagePicker();
                  final XFile? pickedFile = await picker.pickVideo(
                    source: ImageSource.gallery,
                  );

                  setState(() {
                    selectedVideo = pickedFile?.path ?? '';
                    selectedImage = ''; // Limpiar la miniatura de la imagen cuando se selecciona un nuevo video
                    thumbnailVideoPath = null;
                  });

                  // Generar la miniatura del video seleccionado
                  if (pickedFile != null) {
                    await _generateVideoThumbnail(selectedVideo);
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
                    child: SizedBox(
                      height: 200,
                      width: 800,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: selectedVideo.isNotEmpty
                            ? thumbnailVideoPath != null
                                ? Image.file(File(thumbnailVideoPath!))
                                : const Icon(Icons.video_library, size: 50)
                            : const Icon(Icons.video_library, size: 50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
              ///
              /// It navegates to [steps_task_form.dart]
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

                /// Container that shows the helper adding steps
                /// and the button to add them
                child: SizedBox(
                  width: 1000,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          const Text('Puede añadir pasos a la tarea.'),
                          GestureDetector(
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
                            child: const Icon(Icons.help),
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
                                      requiredField: false, steps: steps, idTask: actualTaskId),
                                ));
                            setState(() {
                              steps = copy;
                            });
                          },
                          child: const Text('Añadir un paso',
                          style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Container to preview the data task and steps
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
                        child: const Text('Refrescar',
                          style: TextStyle(color: Colors.white),),
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

      /// BottomAppBar to submit or cancel the action
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF4A6987),
        height: 50,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              /// Cancel button
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

              /// Submit button
              ///
              /// On pressed, it updates data task and check if they are not
              /// null. After that, it calls [submitForm] with [id] and
              /// pops to previous page
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
                  }
                  else {
                    submitForm(idTask);
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