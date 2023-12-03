import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

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

  List<String> tasks = [];
  AddModType typeForm = AddModType.add;
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

  List<String> selectedPasswd = ['','','',''];
  List<String> selectedDBPasswd = ['','','',''];

  // Formulario para el nombre del estudiante
  TextForm nameForm = TextForm(
      requiredField: true,
      titulo: "Nombre del Estudiante",
      tipo: TextFormType.title);
  TextForm surnameForm = TextForm(
      requiredField: true,
      titulo: "Apellido del Estudiante",
      tipo: TextFormType.title);

  @override
  void initState() {
    super.initState();
    tasks.add("Tarea 1");
    tasks.add("Tarea 2");
    tasks.add("Tarea 3");
    tasks.add("Tarea 4");
    tasks.add("Tarea 5");
    tasks.add("Tarea 6");
    tasks.add("Tarea 7");

    typeForm = widget.typeForm;

    id = widget.idStudent;
    if (id != null) {
      actualStudentId = id!;
    }

    nameStudent = widget.name;
    surnameStudent = widget.surname;

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

    if (widget.photo != null) {
      selectedPhoto = widget.photo!;
    }

    if (typeForm == AddModType.mod) {
      getStudentPassword();
    }

    nameStudent ??= nameForm.getText();
    surnameStudent ??= surnameForm.getText();

    nameForm.originalText = nameStudent;
    surnameForm.originalText = surnameStudent;
    nameForm.text = nameStudent!;
    surnameForm.text = surnameStudent!;


    getTitle();

    displayedItems.addAll(tasks);
  }

  Future<void> getStudentPassword() async {
    String uri = "${dotenv.env['API_URL']}/view_student_password.php?idStudent=$actualStudentId";
    try {
      var res = await http.get(Uri.parse(uri));

      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Contraseña obtenida");

        setState(() {
          selectedPasswd[1] = response["data"]["pictograma1"].toString() ?? '';
          selectedPasswd[2] = response["data"]["pictograma2"].toString() ?? '';
          selectedPasswd[3] = response["data"]["pictograma3"].toString() ?? '';
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

  Future<void> insertStudent() async {
    try {
      String uri = "${dotenv.env['API_URL']}/insert_student.php";

      var res = await http.post(Uri.parse(uri), body: {
        "nombre": nameStudent,
        "Apellido": surnameStudent,
        "foto": '',
        "texto": readCheck.toString() == 'true' ? '1' : '0',
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
    } catch (e) {
      print(e);
    }
  }

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

    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadPassword() async {
    String uri = "${dotenv.env['API_URL']}/upload_password.php";
      try {
        var request = http.MultipartRequest('POST', Uri.parse(uri));
        request.fields['idStudent'] = actualStudentId;
        var pictogram1 = await http.MultipartFile.fromPath(
            "pictograma1", selectedPasswd[1]);
        request.files.add(pictogram1);
        var pictogram2 = await http.MultipartFile.fromPath(
            "pictograma2", selectedPasswd[2]);
        request.files.add(pictogram2);
        var pictogram3 = await http.MultipartFile.fromPath(
            "pictograma3", selectedPasswd[3]);
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

  Future<void> updatePassword() async {
    String uri = "${dotenv.env['API_URL']}/update_password.php";
    try {
      var request = http.MultipartRequest('POST', Uri.parse(uri));
      request.fields['idStudent'] = actualStudentId;
      var pictogram1 = await http.MultipartFile.fromPath(
          "pictograma1", selectedPasswd[1]);
      request.files.add(pictogram1);
      var pictogram2 = await http.MultipartFile.fromPath(
          "pictograma2", selectedPasswd[2]);
      request.files.add(pictogram2);
      var pictogram3 = await http.MultipartFile.fromPath(
          "pictograma3", selectedPasswd[3]);
      request.files.add(pictogram3);
      var response = await request.send();

      if (response.statusCode == 200) {
        print("Password Updated");
      }
      else {
        print("Error en la subida");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateStudent (String? idStudent) async {
    String uri = "${dotenv.env['API_URL']}/update_student.php";

    try {
      var res=await http.post(Uri.parse(uri),body: {
        "idStudent": idStudent,
        "nombre": nameStudent,
        "Apellido": surnameStudent,
        "texto": readCheck.toString() == 'true' ? '1' : '0',
        "audio": soundCheck.toString() == 'true' ? '1' : '0',
        "video": videoCheck.toString() == 'true' ? '1' : '0',
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

  // Función para cambiar el titulo de la barra segun sea crear o modificar
  void getTitle () {
    if (typeForm == AddModType.add) {
      title =  'Crear Estudiante';
    } else {
      title = 'Modificar Estudiante: $nameStudent';
    }
  }

  String getSubmitButton () {
    if (typeForm == AddModType.add) {
      return 'Crear';
    } else {
      return 'Modificar';
    }
  }

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

  Widget _getImage(String? urlPath) {
    if (urlPath == null || urlPath == '') {
      return const Image(
          image: AssetImage('images/no_image.png'), fit: BoxFit.contain);
    } else {
      if (typeForm == AddModType.add || (typeForm == AddModType.mod && urlPath != widget.photo)) {
        return Image.file(File(urlPath), fit: BoxFit.cover);
      }
      else {
        return Image.network("${dotenv.env['API_URL']}/images/students/$urlPath");
      }
    }
  }

  Widget _getPasswd(String? urlPath) {
    if (urlPath == null || urlPath == '') {
      return const Image(
          image: AssetImage('images/no_image.png'), fit: BoxFit.contain);
    } else {
      if (typeForm == AddModType.add || (typeForm == AddModType.mod && (urlPath != selectedDBPasswd[1] && urlPath != selectedDBPasswd[2] && urlPath != selectedDBPasswd[3]))) {
        return Image.file(File(urlPath), fit: BoxFit.cover);
      }
      else {
        return Image.network("${dotenv.env['API_URL']}/images/students/passwords/$urlPath");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('images/DabilityLogo.png', width: 48, height: 48),
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
                    'images/userIcon.png',
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
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: nameForm
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: surnameForm,
                    ),
                  ),
                ],
              ),
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
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("Contraseña del Estudiante ordenada"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Imagen pictograma 1
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

                    // Imagen pictograma 2
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

                    // Imagen pictograma 3
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
                                            'images/DeleteIcon.png',
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
