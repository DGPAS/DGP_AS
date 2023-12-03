import 'package:dability/Components/enum_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'add_mod_student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class StudentManagement extends StatefulWidget {
  const StudentManagement({super.key});

  @override
  State<StudentManagement> createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  TextEditingController _controller = TextEditingController();

  List<dynamic> students = []; // lista de alumnos
  double widthMax = 500;

  List<dynamic> displayedItems = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData () async {
    await getStudents();
    displayedItems.addAll(students);
  }

  // Funcion que devuelve los alumnos de la base de datos
  Future<void> getStudents() async {
    // La direccion ip debe ser la de red del portatil para conectar con
    // la tablet ó 10.0.2.2 para conectar con emuladores
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
    } catch (e) {
      print(e);
    }
  }

  // Funcion que borra una tarea concreta de la base de datos
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

  void filterSearchResults(String query) {
    List<dynamic> searchResults = [];

    if (query.isNotEmpty) {
      for (var i = 0; i < students.length; i++) {
        if (students[i]['nombre'].toLowerCase().contains(query.toLowerCase())) {
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
          // columna con el boton de añadir, y el container de la lista
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // AÑADIR ESTUDIANTE
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
            SizedBox(
              // BUSCADOR
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
              // BLOQUE ALUMNOS
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
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${displayedItems[index]['nombre']} ${displayedItems[index]['Apellido']}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
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
                                                    AddModStudent(typeForm: AddModType.mod, idStudent: displayedItems[index]['id'], name: displayedItems[index]['nombre'], surname: displayedItems[index]['Apellido'], readCheck: displayedItems[index]['texto'], soundCheck: displayedItems[index]['audio'], videoCheck: displayedItems[index]['video'], photo: displayedItems[index]['foto'])),
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
                                          'images/DeleteIcon.png',
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
