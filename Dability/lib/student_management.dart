import 'package:flutter/material.dart';
import 'add_mod_student.dart';

class StudentManagement extends StatefulWidget {
  const StudentManagement({super.key});

  @override
  State<StudentManagement> createState() => _StudentManagementState();

// _StudentManagementState createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  TextEditingController _controller = TextEditingController();

  List<String> students = []; // lista de tareas
  double widthMax = 500;

  List<String> displayedItems = [];

  @override
  void initState() {
    super.initState();
    students.add("Alumno 1");
    students.add("Alumno 2");
    students.add("Alumno 3");
    students.add("Alumno 4");
    students.add("Alumno 5");
    students.add("Alumno 6");
    students.add("Alumno 7");

    displayedItems.addAll(students);
  }

  void filterSearchResults(String query) {
    List<String> searchResults = [];

    if (query.isNotEmpty) {
      for (var i = 0; i < students.length; i++) {
        if (students[i].toLowerCase().contains(query.toLowerCase())) {
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
        title: Text('Gestión alumnos'),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30.0, bottom: 8.0),
        child: Column(
          // columna con el boton de añadir, y el container de la lista
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // AÑADIR TAREA
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
                    MaterialPageRoute(builder: (context) => AddModStudent()),
                  );
                },
                child: const Text(
                  'Añadir alumno',
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
              // BLOQUE TAREAS
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
                                  displayedItems[index],
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
                                                    AddModStudent()),
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
                                                      setState(() {
                                                        students.remove(
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
