import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const view_data());
}

class view_data extends StatefulWidget {
  const view_data({Key? key}) : super(key: key);

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {
  List<dynamic> userdata = [];

  Future<void> getrecord() async {
    String uri = "http://localhost/view_data.php";
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        // La solicitud fue exitosa
        userdata = json.decode(response.body);
        print('Datos recibidos: $userdata');  // Agrega este print para debug
      } else {
        // La solicitud falló, imprime el código de estado
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getrecord();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                title: Text(userdata[index]['id'].toString()),  // Asegúrate de convertir a String si es necesario
                subtitle: Text(userdata[index]['email'] ?? ''),  // Asegúrate de manejar el caso en que 'email' sea nulo
              ),
            );
          },
        ),
      ),
    );
  }
}
