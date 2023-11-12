import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
//import 'package:dability/Components/steps_task_form.dart';
import 'package:dability/Components/enum_types.dart';
//import 'package:dability/Components/list_step.dart';

class AddModStudent extends StatefulWidget {
  const AddModStudent({super.key});

  @override
  State<AddModStudent> createState() => _AddModStudentState();
}

class _AddModStudentState extends State<AddModStudent> {
  TextEditingController _controller = TextEditingController();
  List<String> displayedItems = [];

  List<String> tasks = [];

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
        title: Row(
          children: [
            Image.asset('images/DabilityLogo.png', width: 48, height: 48),
            const Expanded(
              child: Text(
                'Gestionar Alumnos',
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
      body: Container(
          padding: EdgeInsets.only(top: 30.0, bottom: 8.0),
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(20),
              child: TextForm(
                  requiredField: true,
                  titulo: "Nombre del Alumno",
                  tipo: TextFormType.title),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: TextForm(
                  requiredField: true,
                  titulo: "Contraseña del Alumno",
                  tipo: TextFormType.title),
            ),
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
    );
  }
}
