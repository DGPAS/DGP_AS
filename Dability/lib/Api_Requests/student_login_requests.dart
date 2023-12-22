import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


Future<List<dynamic>> getPswd(int id_student) async{
  List<dynamic> psd = [];
  String uri = "${dotenv.env['API_URL']}/get_student_password_v2.php?idStudent=$id_student";
  try {
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
        Map<String, dynamic> decodedData = json.decode(response.body);

        // Accede a la propiedad 'data' del mapa
        Map<String, dynamic> data = decodedData['data'];

        // Crear una lista de strings con los valores de las propiedades 'pictogram1' a 'pictogram6'
        psd = [
          data['pictogram1'],
          data['pictogram2'],
          data['pictogram3'],
          data['pictogram4'],
          data['pictogram5'],
          data['pictogram6'],
          data['pass'],
        ];
    } else {
      print('Error en la solicitud: ${response.statusCode}');
    }
  } catch (e) {
    print(e);
  }
  return psd;
}