import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// It saves all the student tasks that are stored on DataBase in a dynamic
/// list [tasks]
///
/// Throws an [error] if the query fails
Future<List<dynamic>> getStudentAgenda(String id) async {
  List<dynamic> tasks = [];

  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/view_student_tasks.php?idStudent=$id";
  try {
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      tasks = json.decode(response.body);
    } else {
      print('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
  }

  return tasks;
}

/// Function that updates a task on DataBase by calling an API function
///
/// It updates its attribute "done" by [id]
///
/// Throws an [error] if the query fails
Future<void> updateFinishedTask (String id) async {
  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/update_finished_task.php";

  try {
    var res=await http.post(Uri.parse(uri),body: {
      "idTask": id,
    });

    var response=jsonDecode(res.body);

    if(response["success"]=="true"){
      print("Tarea actualizada");
    }else{
      print("Some issue");

    }
  } catch (error) {
    print(error);
  }
}