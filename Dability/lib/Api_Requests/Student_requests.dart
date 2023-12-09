import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


/// It saves all the students that are stored on DataBase in a dynamic
/// list [students]
///
/// Throws an [error] if the query fails
Future<List<dynamic>> getStudents() async {
  List<dynamic> students = [];

  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/view_students.php";
  try {
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
        students = json.decode(response.body);
    } else {
      print('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
  }

  return students;
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
    } else {
      print("Task not deleted. Server response: ${response['error']}");
    }
  } catch (e) {
    print("Error during task deletion: $e");
  }
}