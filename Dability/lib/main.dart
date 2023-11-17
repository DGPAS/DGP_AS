  import 'dart:convert';
  import 'dart:developer';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'package:date_time_picker/date_time_picker.dart';
  import 'package:intl/intl.dart';

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'D-Ability',
        home: const HomePage(),
      );
    }
  }

  class HomePage extends StatelessWidget {
    const HomePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewData()),
              );
            },
            child: const Text('Ir a la pantalla de datos'),
          ),
        ),
      );
    }
  }

  class ViewData extends StatefulWidget {
    const ViewData({Key? key}) : super(key: key);

    @override
    State<ViewData> createState() => _ViewDataState();
  }

  class _ViewDataState extends State<ViewData> {
    List<dynamic> userdata = [];

    Future<void> getrecord() async {
      String uri = "http://10.0.2.2:80/view_data.php";
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

    Future<void> deleteTask(String idTareas) async {
    String uri = "http://10.0.2.2:80/delete_data.php";
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

    @override
    void initState() {
      super.initState();
      getrecord();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('D-Ability'),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemCount: userdata.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(userdata[index]['idTareas'].toString()),
                subtitle: Text(
                  'nombre: ${userdata[index]['nombre']}\n'
                  'realizada: ${userdata[index]['realizada']}\n'
                  'descripción: ${userdata[index]['descripción']}\n'
                  'inicio: ${userdata[index]['inicio']}\n'
                  'final: ${userdata[index]['final']}\n'
                  'agenda_id: ${userdata[index]['agenda_id']}\n'
                  'miniatura: ${userdata[index]['miniatura']}\n',
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Call the deleteTask function when the button is pressed
                    deleteTask(userdata[index]['idTareas'].toString());
                  },
                  child: Text('Eliminar'),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InsertDataScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    }
  }

  class InsertDataScreen extends StatefulWidget {
    const InsertDataScreen({Key? key}) : super(key: key);

    @override
    _InsertDataScreenState createState() => _InsertDataScreenState();
  }

  class _InsertDataScreenState extends State<InsertDataScreen> {
    TextEditingController nameController = TextEditingController();
    bool realizadaValue = false;
    TextEditingController descripcionController = TextEditingController();
    String? inicioDate;
    String? finalDate;
    TextEditingController agendaIdController = TextEditingController();
    TextEditingController miniaturaController = TextEditingController();

    Future<void> insertData() async {
      if (nameController.text.isEmpty ||
          realizadaValue == null ||
          descripcionController.text.isEmpty ||
          inicioDate == null ||
          finalDate == null ||
          miniaturaController.text.isEmpty) {
        print("Todos los campos son obligatorios");
      } else {
        try {
          String uri = "http://10.0.2.2:80/insert_data.php";

          print("Datos a enviar: ${nameController.text}, ${realizadaValue ? "1" : "0"}, ${descripcionController.text}, $inicioDate, $finalDate, ${agendaIdController.text}, ${miniaturaController.text}");

          var res = await http.post(Uri.parse(uri), body: {
            "nombre": nameController.text.trim(),
            "realizada": realizadaValue != null ? (realizadaValue ? "1" : "0") : "0",
            "descripcion": descripcionController.text.trim(),
            "inicio": inicioDate ?? "",
            "final": finalDate ?? "",
            "agenda_id": agendaIdController.text.trim(),
            "miniatura": miniaturaController.text.trim(),
          });

          var response = jsonDecode(res.body);
          if (response["success"] == "true") {
            print("Datos insertados");
          } else {
            print("Datos no insertados");
          }
        } catch (e) {
          print(e);
        }
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Insertar Datos'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              CheckboxListTile(
                title: const Text('Realizada'),
                value: realizadaValue ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    realizadaValue = value ?? false;
                  });
                },
              ),
              TextField(
                controller: descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                readOnly: true,
                controller: TextEditingController(text: inicioDate),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      inicioDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Inicio'),
              ),
              TextField(
                readOnly: true,
                controller: TextEditingController(text: finalDate),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      finalDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Final'),
              ),
              TextField(
                controller: agendaIdController,
                decoration: const InputDecoration(labelText: 'Número de Agenda'),
              ),
              TextField(
                controller: miniaturaController,
                decoration: const InputDecoration(labelText: 'Miniatura'),
              ),
              ElevatedButton(
                onPressed: insertData,
                child: const Text('Insertar Datos'),
              ),
            ],
          ),
        ),
      );
    }
  }
