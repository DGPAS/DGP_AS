import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// It saves all the task that are stored from DataBase in a dynamic
/// list [tasks]
///
/// Throws an [error] if the query fails
Future<List<dynamic>> getTasks() async {
  List<dynamic> tasks = [];

  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/view_tasks.php";
  try {
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
        tasks = json.decode(response.body);
    } else {
      print('Error en la solicitud getTasks: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
  }

  return tasks;
}


/// It deletes a task with id = [idTasks] from the DataBase
///
/// Throws an [error] if the query fails
Future<void> deleteTask(String idTasks) async {
  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/delete_task.php";
  try {
    var res = await http.post(Uri.parse(uri), body: {"idTask": idTasks});
    var response = jsonDecode(res.body);
    if (response["success"] == true) {
      print("Task deleted");
      // Refresh the task list after deletion
    } else {
      print("Task not deleted. Server response: ${response['error']}");
    }
  } catch (e) {
    print("Error during task deletion: $e");
  }
}


