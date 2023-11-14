import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'add_mod_task.dart';
import 'Components/enum_types.dart';
import 'package:http/http.dart' as http;

class TaskManagement extends StatefulWidget {
  const TaskManagement({super.key});

  @override
  State<TaskManagement> createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {
  TextEditingController _controller = TextEditingController();

  List<dynamic> userdata = [];

  // Funcion que devuelve las tareas de la base de datos
  Future<void> getrecord() async {
    // La direccion ip debe ser la de red del portatil para conectar con
    // la tablet ó 10.0.2.2 para conectar con emuladores
    String uri = "http://192.168.1.136:80/view_data.php";
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          userdata = json.decode(response.body);
        });
        print('Datos recibidos: $userdata');
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  // Funcion que borra una tarea concreta de la base de datos
  Future<void> deleteTask(String idTareas) async {
    String uri = "http://192.168.1.136:80/delete_data.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {"idTareas": idTareas});
      var response = jsonDecode(res.body);
      if (response["success"] == true) {
        print("Task deleted");
        // Refresh the task list after deletion
        getrecord();
      } else {
        print("Task not deleted. Server response: ${response['error']}");
      }
    } catch (e) {
      print("Error during task deletion: $e");
    }
  }

  List<String> tasks = [];
  double maxWidt = 500;

  List<String> displayedItems = [];

  @override
  void initState() {
    super.initState();

    getrecord();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión tareas'),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30.0, bottom: 8.0),
        child: Column(
          // columna con el boton de añadir, y el container de la lista
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // tiene el elevated button de añadir tarea
              // width: (MediaQuery.of(context).size.width - 30).clamp(0.0, maxAnchoMaximo.toDouble()),
              alignment: Alignment.center,
              // padding: EdgeInsets.symmetric(horizontal: 14),
              padding: EdgeInsets.only(left: 14, right: 14, bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.1), // inf, 70
                  textStyle: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Color(0xFF4A6987),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40), // Margen horizontal
                ),
                onPressed: () {
                  // Irá a la pantalla de añadir tarea - descomentar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddModTask(typeForm: AddModType.add)),
                  );
                },
                child: Text(
                  'Añadir tarea',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.152,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 15.0, left: 14, right: 14),
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
            Expanded(
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
                width: (MediaQuery.of(context).size.width - 30)
                    .clamp(0.0, maxWidt.toDouble()),
                padding:
                    EdgeInsets.symmetric(horizontal: 30), // Margen horizontal
                child: ListView(children: [
                  SizedBox(
                    height: 30,
                  ),
                  ...List.generate(userdata.length, (index) {
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
                                  userdata[index]['nombre'],
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddModTask(
                                                        typeForm:
                                                            AddModType.mod, title: userdata[index]['nombre'], description: userdata[index]['descripcion'], idTareas: userdata[index]['idTareas'],)),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(10, 20),
                                          backgroundColor: Color(0xFFF5F5F5),
                                          elevation: 0,
                                        ),
                                        child: Image.asset(
                                          'images/EditIcon.png',
                                          width: 30,
                                          height: 35,
                                        ),
                                      ),
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
                                                      deleteTask(userdata[index]['idTareas']);
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
          ],
        ),
      ),
    );
  }
}
