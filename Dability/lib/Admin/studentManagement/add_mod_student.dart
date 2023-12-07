import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

/// # Page for add or modify an student
///
/// It receives a required param [typeForm] that indicates if it is
/// for add an student or modify the given one with [student]
class AddModStudent extends StatefulWidget {
  AddModStudent({
    Key? key,
    required this.typeForm,
    this.idStudent,
    this.name,
    this.surname,
    this.readCheck,
    this.videoCheck,
    this.soundCheck,
    this.photo})
    : super(key:key);

  AddModType typeForm;
  String? idStudent;
  String? name;
  String? surname;
  String? readCheck;
  String? videoCheck;
  String? soundCheck;
  String? photo;

  @override
  State<AddModStudent> createState() => _AddModStudentState();
}

class _AddModStudentState extends State<AddModStudent> {
  TextEditingController _controller = TextEditingController();
  List<String> displayedItems = [];

  /// Array of static tasks (it should be the array of tasks from Diary in DB)
  List<String> tasks = [];

  AddModType typeForm = AddModType.add;

  /// Variables where it will be stored the data of an student
  String? id;
  String actualStudentId = '';
  String title = "Añadir Estudiante";
  String? nameStudent;
  String? surnameStudent;
  File? _photo;
  String selectedPhoto = "";
  bool? readCheck = false;
  bool? videoCheck = false;
  bool? soundCheck = false;

  /// Lists that store and manage the password of an student
  List<String> selectedPasswd = ['','','',''];
  List<String> selectedDBPasswd = ['','','',''];

  /// Form that contains the name of the student to add or modify
  TextForm nameForm = TextForm(
      requiredField: true,
      title: "Nombre del Estudiante",
      type: TextFormType.title);
  /// Form that contains the surname of the student to add or modify
  TextForm surnameForm = TextForm(
      requiredField: true,
      title: "Apellido del Estudiante",
      type: TextFormType.title);

  /// Init State
  ///
  /// Initialize the student password and its tasks, if it has,
  /// by calling [getStudentPassword] and [funtion calls API for student Diary]
  @override
  void initState() {
    super.initState();
    /// Local implementation (it should call a function that
    /// calls API to get student tasks from Diary table)
    tasks.add("Tarea 1");
    tasks.add("Tarea 2");
    tasks.add("Tarea 3");
    tasks.add("Tarea 4");
    tasks.add("Tarea 5");
    tasks.add("Tarea 6");
    tasks.add("Tarea 7");

    typeForm = widget.typeForm;

    /// If the student exists, it saves his actual id
    id = widget.idStudent;
    if (id != null) {
      actualStudentId = id!;
    }

    nameStudent = widget.name;
    surnameStudent = widget.surname;

    /// It stores the "format attributes" of the student
    if (widget.readCheck != null) {
      if (widget.readCheck == '0') {
        readCheck = false;
      } else {
        readCheck = true;
      }
    }

    if (widget.videoCheck != null) {
      if (widget.videoCheck == '0') {
        videoCheck = false;
      } else {
        videoCheck = true;
      }
    }

    if (widget.soundCheck != null) {
      if (widget.soundCheck == '0') {
        soundCheck = false;
      } else {
        soundCheck = true;
      }
    }

    /// If the student exists, it saves the photo form DB
    if (widget.photo != null) {
      selectedPhoto = widget.photo!;
    }

    /// If the student exists, it get his password
    if (typeForm == AddModType.mod) {
      getStudentPassword();
    }

    /// If name or surname are null it means that we are adding an student,
    /// not modifying him/her, so the values are initialized by the controllers
    nameStudent ??= nameForm.getText();
    surnameStudent ??= surnameForm.getText();

    nameForm.originalText = nameStudent;
    surnameForm.originalText = surnameStudent;
    nameForm.text = nameStudent!;
    surnameForm.text = surnameStudent!;

    /// Get the AppBar title
    getTitle();

    displayedItems.addAll(tasks);
  }

  /// Function that saves the student password on a [String] list [selectedPasswd] and [selectedDBPasswd] of the
  /// existing student with id = [actualStudentId] from DataBase
  ///
  /// Throws an [error] if the query fails
  Future<void> getStudentPassword() async {
    String uri = "${dotenv.env['API_URL']}/view_student_password.php?idStudent=$actualStudentId";
    try {
      var res = await http.get(Uri.parse(uri));

      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Contraseña obtenida");

        setState(() {
          selectedPasswd[1] = response["data"]["pictogram1"].toString() ?? '';
          selectedPasswd[2] = response["data"]["pictogram2"].toString() ?? '';
          selectedPasswd[3] = response["data"]["pictogram3"].toString() ?? '';
          selectedDBPasswd[1] = selectedPasswd[1];
          selectedDBPasswd[2] = selectedPasswd[2];
          selectedDBPasswd[3] = selectedPasswd[3];
        });
      } else {
        print("Error en response getStudentPassword");
      }
    } catch (e) {
      print(e);
    }
  }

  /// Function that inserts an student on DataBase by calling an API function
  ///
  /// It adds its name, its lastname, the picture string and the format attributes
  ///
  /// Throws an [error] if the query fails
  Future<void> insertStudent() async {
    try {
      String uri = "${dotenv.env['API_URL']}/insert_student.php";

      var res = await http.post(Uri.parse(uri), body: {
        "firstName": nameStudent, // nombre
        "lastName": surnameStudent, // Apellido
        "picture": '', // foto
        "text": readCheck.toString() == 'true' ? '1' : '0',
        "audio": soundCheck.toString() == 'true' ? '1' : '0',
        "video": videoCheck.toString() == 'true' ? '1' : '0',
      });

      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Datos insertados");
        int newStudentId = response["idStudent"];
        setState(() {
          actualStudentId = newStudentId.toString();
          print("Nuevo idStudent: $actualStudentId");
        });
      } else {
        print("Datos no insertados");
      }
    } catch (error) {
      print(error);
    }
  }

  /// Function that uploads the photo of an student on API directory
  /// by calling an API function
  ///
  /// It uploads it with [_photo] by [actualStudentId]
  ///
  /// Throws an [error] if the query fails
  Future<void> uploadPhoto() async {
    String uri = "${dotenv.env['API_URL']}/upload_student_photo.php";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(uri));
      request.fields['idStudent'] = actualStudentId;
      var picture = await http.MultipartFile.fromPath("image", _photo!.path);
      request.files.add(picture);
      var response = await request.send();

      if (response.statusCode == 200) {
        print ("Image Uploaded");
      }
      else {
        print("Error en la subida");
      }

    } catch (error) {
      print(error);
    }
  }

  /// Function that uploads the password of an student on API directory
  /// by calling an API function
  ///
  /// It uploads it with [selectedPasswd] by [actualStudentId]
  ///
  /// Throws an [error] if the query fails
  Future<void> uploadPassword() async {
    String uri = "${dotenv.env['API_URL']}/upload_password.php";
      try {
        var request = http.MultipartRequest('POST', Uri.parse(uri));
        request.fields['idStudent'] = actualStudentId;
        var pictogram1 = await http.MultipartFile.fromPath(
            "pictogram1", selectedPasswd[1]);
        request.files.add(pictogram1);
        var pictogram2 = await http.MultipartFile.fromPath(
            "pictogram2", selectedPasswd[2]);
        request.files.add(pictogram2);
        var pictogram3 = await http.MultipartFile.fromPath(
            "pictogram3", selectedPasswd[3]);
        request.files.add(pictogram3);
        var response = await request.send();

        if (response.statusCode == 200) {
          print("Image Uploaded");
        }
        else {
          print("Error en la subida");
        }
      } catch (e) {
        print(e);
      }
  }

  /// Function that updates an student password on DataBase by calling an API function
  ///
  /// It updates it with [selectedPasswd] by [actualStudentId]
  ///
  /// Throws an [error] if the query fails
  Future<void> updatePassword() async {
    String uri = "${dotenv.env['API_URL']}/update_password.php";
    try {
      var request = http.MultipartRequest('POST', Uri.parse(uri));
      request.fields['idStudent'] = actualStudentId;
      var pictogram1 = await http.MultipartFile.fromPath(
          "pictogram1", selectedPasswd[1]);
      request.files.add(pictogram1);
      var pictogram2 = await http.MultipartFile.fromPath(
          "pictogram2", selectedPasswd[2]);
      request.files.add(pictogram2);
      var pictogram3 = await http.MultipartFile.fromPath(
          "pictogram3", selectedPasswd[3]);
      request.files.add(pictogram3);
      var response = await request.send();

      if (response.statusCode == 200) {
        print("Password Updated");
      }
      else {
        print("Error en la subida");
      }
    } catch (error) {
      print(error);
    }
  }

  /// Function that updates an student on DataBase by calling an API function
  ///
  /// It updates its name, its lastname and its format attributes by [idStudent]
  ///
  /// Throws an [error] if the query fails
  Future<void> updateStudent (String? idStudent) async {
    String uri = "${dotenv.env['API_URL']}/update_student.php";

    try {
      var res=await http.post(Uri.parse(uri),body: {
        "idStudent": idStudent,
        "firstName": nameStudent, // nombre
        "lastName": surnameStudent,
        "text": readCheck.toString() == 'true' ? '1' : '0',
        "audio": soundCheck.toString() == 'true' ? '1' : '0',
        "video": videoCheck.toString() == 'true' ? '1' : '0',
      });

      var response=jsonDecode(res.body);

      if(response["success"]=="true"){
        print("Datos actualizados");
      }else{
        print("Some issue");

      }
    } catch (error) {
      print(error);
    }
  }

  /// Function that filters the list of student tasks whose name matches
  /// or contains [query] by updating [displayedItems]
  ///
  /// If they don't match, it adds all students to [displayedItems]
  void filterSearchResults(String query) {
    List<String> searchResults = [];

    if (query.isNotEmpty) {
      for (var i = 0; i < tasks.length; i++) {
        if (tasks[i].toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(tasks[i]);
        }
      }
    } else {
      searchResults.addAll(tasks);
    }

    setState(() {
      displayedItems.clear();
      displayedItems.addAll(searchResults);
    });
  }

  /// Function that returns the title of [AppBar]
  ///
  /// If [typeForm] == [AddModType.add], it updates it to creating an student
  ///
  /// If [typeForm] == [AddModType.mod], it updates it to modifying an student
  void getTitle () {
    if (typeForm == AddModType.add) {
      title =  'Crear Estudiante';
    } else {
      title = 'Modificar Estudiante: $nameStudent';
    }
  }

  /// Function that returns the submit button name of [BottomNavigationBar]
  ///
  /// If [typeForm] == [AddModType.add], it updates it to create (an student)
  ///
  /// If [typeForm] == [AddModType.mod], it updates it to modify (an student)
  String getSubmitButton () {
    if (typeForm == AddModType.add) {
      return 'Crear';
    } else {
      return 'Modificar';
    }
  }

  /// Function that calls funtions that calls API
  ///
  /// If it is adding an student, it insert the student data,
  /// it uploads the phoyo and the password
  ///
  /// If it is modifying an student, it updates him/her by
  /// its id [idStudent], it updates the photo and
  /// it updates the password
  Future<void> submitForm (String idStudent) async {
    if (typeForm == AddModType.add) {
      await insertStudent();
      if (_photo != null) {
        await uploadPhoto();
      }
      await uploadPassword();
    } else {
      await updateStudent(idStudent);
      await uploadPhoto();
      await updatePassword();
    }
  }

  /// Function that returns widget of the photo of the task by its [urlPath]
  ///
  /// If [urlPath] is null, it returns the default image with [AssetImage]
  ///
  /// if [urlPath] is not null and it is an adding student or it is a modifying student
  /// and the [urlPath] it is not the same has the photo given at first,
  /// it means that the original photo of the student has been modified
  /// so we show it with [Image.file]
  ///
  /// If [urlPath] its the original miniature from the DataBase student that we are
  /// modifying, we show it with [Image.network]
  Widget _getImage(String? urlPath) {
    if (urlPath == null || urlPath == '') {
      return const Image(
          image: AssetImage('assets/images/no_image.png'), fit: BoxFit.contain);
    } else {
      if (typeForm == AddModType.add || (typeForm == AddModType.mod && urlPath != widget.photo)) {
        return Image.file(File(urlPath), fit: BoxFit.cover);
      }
      else {
        return Image.network("${dotenv.env['API_URL']}/images/students/$urlPath");
      }
    }
  }

  /// Function that returns widget of the password photos of the student by its [urlPath]
  ///
  /// If [urlPath] is null, it returns the default image with [AssetImage]
  ///
  /// if [urlPath] is not null and it is an adding student or it is a modifying student
  /// and the [urlPath] it is not the same has one of the photos given at first,
  /// it means that the original photo from password of the student has been modified
  /// so we show it with [Image.file]
  ///
  /// If [urlPath] its the original photo password from the DataBase student that we are
  /// modifying, we show it with [Image.network]
  Widget _getPasswd(String? urlPath) {
    if (urlPath == null || urlPath == '') {
      return const Image(
          image: AssetImage('assets/images/no_image.png'), fit: BoxFit.contain);
    } else {
      if (typeForm == AddModType.add || (typeForm == AddModType.mod && (urlPath != selectedDBPasswd[1] && urlPath != selectedDBPasswd[2] && urlPath != selectedDBPasswd[3]))) {
        return Image.file(File(urlPath), fit: BoxFit.cover);
      }
      else {
        return Image.network("${dotenv.env['API_URL']}/images/students/passwords/$urlPath");
      }
    }
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
                '$title',
                textAlign: TextAlign.center,
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
        backgroundColor: Color(0xFF4A6987),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(top: 30.0, bottom: 8.0),
            child: Column(children: [
              Row(
                children: [
                  /// Form to introduce the [name] of the student
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: nameForm
                    ),
                  ),
                  /// Form to introduce the [surname] of the student
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: surnameForm,
                    ),
                  ),
                ],
              ),
              /// Container to add the [_photo] of the student
              const Text('Fotografía del Estudiante'),
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final XFile? pickedFile = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 100);

                      setState(() {
                        selectedPhoto = pickedFile!.path;
                        _photo = File(pickedFile!.path);
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
                          child: _getImage(selectedPhoto)),
                    ),
                  ),
                ),
              ),
              /// Container that adds the student password
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("Contraseña del Estudiante ordenada"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    /// Image pictogram 1
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 100);

                        setState(() {
                          selectedPasswd[1] = pickedFile!.path;
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
                                child: _getPasswd(selectedPasswd[1])),
                          ),
                        ),
                      ),
                    ),

                    /// Image pictogram 2
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 100);

                        setState(() {
                          selectedPasswd[2] = pickedFile!.path;
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
                                child: _getPasswd(selectedPasswd[2])),
                          ),
                        ),
                      ),
                    ),

                    /// Image pictogram 3
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 100);

                        setState(() {
                          selectedPasswd[3] = pickedFile!.path;
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
                                child: _getPasswd(selectedPasswd[3])),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                  ],
                ),
              ),
              /// Format attributes of student
              const Text('Formatos aptos para el estudiante'),
              SizedBox(
                width: 200,
                child: CheckboxListTile(
                  title: const Text('Texto'),
                  value: readCheck,
                  onChanged: (newValue) {
                    setState(() {
                      readCheck = newValue;
                    });
                  }),
              ),
              SizedBox(
                width: 200,
                child: CheckboxListTile(
                    title: const Text('Audio'),
                    value: soundCheck,
                    onChanged: (newValue) {
                      setState(() {
                        soundCheck = newValue;
                      });
                    }),
              ),
              SizedBox(
                width: 200,
                child: CheckboxListTile(
                    title: const Text('Video'),
                    value: videoCheck,
                    onChanged: (newValue) {
                      setState(() {
                        videoCheck = newValue;
                      });
                    }),
              ),

              /// Student tasks filter
              if (typeForm == AddModType.mod)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.152,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 5.0, left: 14, right: 14),
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Buscar',
                      hintText: 'Ingrese su búsqueda',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ),
              /// Student tasks
              if (typeForm == AddModType.mod)
              Container(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4A6987),
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Color(0xFF4A6987), Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  height: 400,
                  width: (MediaQuery.of(context).size.width - 30).clamp(0.0, 500),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30), // Margen horizontal
                  child: ListView(children: [
                    SizedBox(
                      height: 30,
                    ),
                    /// Generate the list of student tasks
                    ...List.generate(displayedItems.length, (index) {
                      return Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  double.infinity,
                                  MediaQuery.of(context).size.height *
                                      0.1), // inf, 80
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30), // Redondear los bordes del botón
                              ),
                              backgroundColor: Color(0xFFF5F5F5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20), // Margen horizontal del texto
                            ),
                            onPressed: () {
                              // acción
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    displayedItems[index],
                                    //textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors
                                          .black, // Cambia el color del texto a rojo
                                    ),
                                  ),

                                  /////
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Confirmar eliminación'),
                                                  content: Text(
                                                      '¿Estás seguro de que deseas eliminar esta tarea?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Cierra el diálogo
                                                      },
                                                      child: Text('Cancelar'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          tasks.remove(
                                                              displayedItems[
                                                                  index]);
                                                          displayedItems.remove(
                                                              displayedItems[
                                                                  index]);
                                                        });
                                                        Navigator.of(context)
                                                            .pop(); // Cierra el diálogo
                                                      },
                                                      child: Text('Eliminar'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(10, 20),
                                            backgroundColor: Color(0xFFF5F5F5),
                                            elevation: 0,
                                          ),
                                          child: Image.asset(
                                            'assets/images/DeleteIcon.png',
                                            width: 30,
                                            height: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /////
                                ]),
                          ),
                          SizedBox(height: 30), //espacio entre tareas
                        ],
                      );
                    })
                  ]),
                ),
              ),
            ])),
      ),


      /// BottomAppBar to submit or cancel the action
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF4A6987),
        height: 50,
        child: Container(
          margin: const EdgeInsets.all(10),
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
              /// On pressed, it updates data student and check if they are not
              /// null. After that, it calls [submitForm] with [actualStudentId] and
              /// pops to previous page
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.white)),
                onPressed: () {
                  nameStudent = nameForm.getText();
                  surnameStudent = surnameForm.getText();
                  if ((nameStudent == '' || nameStudent == null) ||
                      (surnameStudent == '' || surnameStudent == null) ||
                      (selectedPasswd[1] == '' || selectedPasswd[2] == '' || selectedPasswd[3] == '')) {
                    print("Los campos nombre, apellido, y los 3 pictogramas de la contraseña son obligatorios");
                  } else {
                    submitForm(actualStudentId);
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
}
