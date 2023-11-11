import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class view_data extends StatefulWidget {
  const view_data({Key? key}) : super(key: key);

  @override
  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {
  List<dynamic> userdata = [];

  Future<void> getrecord() async {
    String uri = "http://10.0.2.2/view_data.php";
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        // La solicitud fue exitosa
        userdata = json.decode(response.body);
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
              title: Text(userdata[index]['id']),
              subtitle: Text(userdata[index]['email']),
            ),
          );
        },
      ),
    );
  }
}
