import 'dart:convert';

import 'package:flutter/material.dart';
import 'add_mod_task.dart';
import 'Components/enum_types.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// # Page where admin manages tasks
class TaskManagement extends StatefulWidget {
  const TaskManagement({super.key});

  @override
  State<TaskManagement> createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {
  /// Text controller for task filter
  ///
  /// If the text on the filter changes, it stores changes
  /// TODO: CREO NO ES NECESARIO ESTE CONTROLLER PORQUE NO SE USA
  TextEditingController _controller = TextEditingController();

  /// List that stores tasks form DataBase
  List<dynamic> tasks = [];

  /// It saves all the task that are stored from DataBase in a dynamic
  /// list [tasks]
  ///
  /// Throws an [error] if the query fails
  Future<void> getTasks() async {
    /// Uri whose IP is on .env that calls API
    String uri = "${dotenv.env['API_URL']}/view_data.php";
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          tasks = json.decode(response.body);
        });
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }

  /// It deletes a task with id = [idTasks] from the DataBase
  ///
  /// Throws an [error] if the query fails
  Future<void> deleteTask(String idTasks) async {
    /// Uri whose IP is on .env that calls API
    String uri = "${dotenv.env['API_URL']}/delete_data.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {"idTasks": idTasks});
      var response = jsonDecode(res.body);
      if (response["success"] == true) {
        print("Task deleted");
        // Refresh the task list after deletion
        getTasks();
      } else {
        print("Task not deleted. Server response: ${response['error']}");
      }
    } catch (e) {
      print("Error during task deletion: $e");
    }
  }

  /// Maximum with of the list of tasks
  double maxWidth = 500;

  /// Filtered list of tasks
  List<dynamic> displayedItems = [];

  /// Function that calls [getTasks] who returns the DataBase tasks
  /// and adds them to [displayedItems]
  Future<void> getData () async {
    await getTasks();
    displayedItems.addAll(tasks);
  }

  /// Init State
  ///
  /// Initialize the list of task by calling [getData]
  @override
  void initState() {
    super.initState();

    getData();
  }

  /// Function that filters the list of tasks whose name matches
  /// or contains [query] by updating [displayedItems]
  ///
  /// If they don't match, it adds all tasks to [displayedItems]
  void filterSearchResults(String query) {
    List<dynamic> searchResults = [];

    if (query.isNotEmpty) {
      for (var i = 0; i < tasks.length; i++) {
        if (tasks[i]['name'].toLowerCase().contains(query.toLowerCase())) {
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

  /// Main builder of the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión tareas'),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30.0, bottom: 8.0),
        /// Column that contains a button that adds tasks,
        /// the task filter and the filterd list of tasks
        child: Column(
          children: [
            Container(
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
                  /// When pressed it goes to [add_mod_task.dart] with [AddModType.add]
                  /// to add a new task
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
            /// SizedBox for the filter
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
            /// List of tasks
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
                    .clamp(0.0, maxWidth.toDouble()),
                padding:
                    EdgeInsets.symmetric(horizontal: 30), // Margen horizontal
                child: ListView(children: [
                  SizedBox(
                    height: 30,
                  ),
                  /// It returns a list of ElevatedButton
                  ///
                  /// One ElevatedButton for each task in [displayedItems]
                  /// Each item of the list contains the name of the task,
                  /// a button for update the task and another one to delete it
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
                            // no action
                          },
                          /// The content of each task
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Name of the task
                                Text(
                                  displayedItems[index]['name'],
                                  //textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors
                                        .black, // Cambia el color del texto a rojo
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      /// Button that navigates to [add_mod_task.dart] with [AddModType.mod]
                                      /// to modify the current task
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddModTask(
                                                        typeForm:
                                                            AddModType.mod, title: displayedItems[index]['name'], description: displayedItems[index]['description'], idTasks: displayedItems[index]['idTasks'], thumbnail: displayedItems[index]['thumbnail'])),
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
                                      /// Button that deletes the current task
                                      ///
                                      /// It shows a dialog to confirm the action
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
                                                      deleteTask(displayedItems[index]['idTasks']);
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
