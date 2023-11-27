import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
//import 'package:dability/Components/steps_task_form.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:dability/Components/list_step.dart';
import 'dart:io';

class AddModStudent extends StatefulWidget {
  AddModStudent({
    Key? key,
    required this.typeForm,
    this.name})
    : super(key:key);

  AddModType typeForm;
  String? name;

  @override
  State<AddModStudent> createState() => _AddModStudentState();
}

class _AddModStudentState extends State<AddModStudent> {
  TextEditingController _controller = TextEditingController();
  List<String> displayedItems = [];

  List<String> tasks = [];
  AddModType typeForm = AddModType.add;
  String title = "Añadir Estudiante";
  String? nameAlumno = '';
  bool? readCheck = false;
  bool? videoCheck = false;
  bool? imageCheck = false;

  // Formulario para el nombre del alumno
  TextForm titleForm = TextForm(
      requiredField: true,
      titulo: "Nombre del Alumno",
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
    nameAlumno = widget.name;

    getTitle();

    displayedItems.addAll(tasks);
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
      title = 'Modificar Estudiante: $nameAlumno';
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
              Container(
                padding: EdgeInsets.all(20),
                child: titleForm,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("Contraseña del Alumno ordenada"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Imagen pictograma 1
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final picker = ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 100);

                          /*
                          setState(() {
                            selectedImage = pickedFile!.path;
                            _image = File(selectedImage);
                          });*/
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
                                  child: _getImage(""/*selectedImage*/)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Imagen pictograma 2
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final picker = ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 100);

                          /*
                          setState(() {
                            selectedImage = pickedFile!.path;
                            _image = File(selectedImage);
                          });*/
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
                                  child: _getImage(""/*selectedImage*/)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Imagen pictograma 3
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final picker = ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 100);

                          /*
                          setState(() {
                            selectedImage = pickedFile!.path;
                            _image = File(selectedImage);
                          });*/
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
                                  child: _getImage(""/*selectedImage*/)),
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
              const Text('Formatos aptos para el alumno'),
              Container(
                width: 200,
                child: CheckboxListTile(
                  title: const Text('Lectura'),
                  value: readCheck,
                  onChanged: (newValue) {
                    setState(() {
                      readCheck = newValue;
                    });
                  }),
              ),
              Container(
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
              Container(
                width: 200,
                child: CheckboxListTile(
                    title: const Text('Imágenes'),
                    value: imageCheck,
                    onChanged: (newValue) {
                      setState(() {
                        imageCheck = newValue;
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
                  /*
                  if ((title == '' || title == null) ||
                      (description == '' || description == null)) {
                    print("Los campos titulo y descripción son obligatorios");
                  } else {
                    submitForm(idTareas);
                    Navigator.of(context).pop();
                  }
                   */
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
