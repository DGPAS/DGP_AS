import 'package:dability/Components/enum_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'add_mod_student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


/// # Page where admin manages students
class StudentManagement extends StatefulWidget {
  const StudentManagement({super.key});

  @override
  State<StudentManagement> createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  /// Text controller for student filter
  ///
  /// If the text on the filter changes, it stores changes
  /// TODO: CREO NO ES NECESARIO ESTE CONTROLLER PORQUE NO SE USA
  TextEditingController _controller = TextEditingController();

  /// List that stores students form DataBase
  List<dynamic> students = []; // lista de alumnos
  double widthMax = 500;

  List<dynamic> displayedItems = [];

  /// Init State
  ///
  /// Initialize the list of students by calling [getData]
  @override
  void initState() {
    super.initState();
    getData();
  }

  /// Function that calls [getStudents] who returns the DataBase students
  /// and adds them to [displayedItems]
  Future<void> getData () async {
    await getStudents();
    displayedItems.addAll(students);
  }

  /// It saves all the students that are stored from DataBase in a dynamic
  /// list [students]
  ///
  /// Throws an [error] if the query fails
  Future<void> getStudents() async {
    /// Uri whose IP is on .env that calls API
    String uri = "${dotenv.env['API_URL']}/view_students.php";
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          students = json.decode(response.body);
        });
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
  }

  /// It deletes a student with id = [idStudent] from the DataBase
  ///
  /// Throws an [error] if the query fails
  Future<void> deleteStudent(String idStudent) async {
    String uri = "${dotenv.env['API_URL']}/delete_student.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {"idStudent": idStudent});
      var response = jsonDecode(res.body);
      if (response["success"] == true) {
        print("Student deleted");
        // Refresh the task list after deletion
        await getStudents();
      } else {
        print("Task not deleted. Server response: ${response['error']}");
      }
    } catch (e) {
      print("Error during task deletion: $e");
    }
  }

  /// Function that filters the list of students whose name matches
  /// or contains [query] by updating [displayedItems]
  ///
  /// If they don't match, it adds all students to [displayedItems]
  void filterSearchResults(String query) {
    List<dynamic> searchResults = [];

    if (query.isNotEmpty) {
      for (var i = 0; i < students.length; i++) {
        if (("${students[i]['firstName']} ${students[i]['lastName']}").toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(students[i]);
        }
      }
    } else {
      searchResults.addAll(students);
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
        title: Text('Gestión estudiantes'),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30.0, bottom: 8.0),
        child: Column(
          /// Column that contains a button that adds students,
          /// the students filter and the filterd list of students
          children: [
            Container(
              /// ADD STUDENT
              alignment: Alignment.center,
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
                  padding: EdgeInsets.symmetric(horizontal: 40),
                ),
                onPressed: () {
                  /// When pressed it goes to [add_mod_student.dart] with [AddModType.add]
                  /// to add a new student
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddModStudent(typeForm: AddModType.add)),
                  );
                },
                child: const Text(
                  'Añadir estudiante',
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
            /// List of students
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A6987), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                height: 400,
                width: (MediaQuery.of(context).size.width - 30)
                    .clamp(0.0, widthMax.toDouble()),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ListView(children: [
                  SizedBox(
                    height: 30,
                  ),
                  /// It returns a list of ElevatedButton
                  ///
                  /// One ElevatedButton for each student in [displayedItems]
                  /// Each item of the list contains the name of the student,
                  /// a button for update the student and another one to delete it
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
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Color(0xFFF5F5F5),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          onPressed: () {
                            // acción del botón
                          },
                          /// The content of each student
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Name of the student
                                Text(
                                  '${displayedItems[index]['firstName']} ${displayedItems[index]['lastName']}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      /// Button that navigates to [add_mod_student.dart] with [AddModType.mod]
                                      /// to modify the current student
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddModStudent(typeForm: AddModType.mod, idStudent: displayedItems[index]['id'], name: displayedItems[index]['firstName'], surname: displayedItems[index]['lastName'], readCheck: displayedItems[index]['text'], soundCheck: displayedItems[index]['audio'], videoCheck: displayedItems[index]['video'], photo: displayedItems[index]['picture'])),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(10, 20),
                                          backgroundColor: Color(0xFFF5F5F5),
                                          elevation: 0,
                                        ),
                                        child: Image.asset(
                                          'assets/images/EditIcon.png',
                                          width: 30,
                                          height: 35,
                                        ),
                                      ),
                                      /// Button that deletes the current student
                                      ///
                                      /// It shows a dialog to confirm the action
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Confirmar eliminación'),
                                                content: const Text(
                                                    '¿Estás seguro de que deseas eliminar esta tarea?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Cierra el diálogo
                                                    },
                                                    child:
                                                        const Text('Cancelar'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      deleteStudent(displayedItems[index]['id']);
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
                              ]),
                        ),
                        SizedBox(height: 30), // Espacio entre las tareas
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