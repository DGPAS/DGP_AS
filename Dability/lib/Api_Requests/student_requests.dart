import 'dart:io';
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

/// It saves all the students with educator [id] that are stored on DataBase
/// in a dynamic list [students]
///
/// Throws an [error] if the query fails
Future<List<dynamic>> getEducatorStudents(String id) async {
  List<dynamic> students = [];

  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/view_students_by_educator.php?idEducator=$id";
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

  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/delete_student.php";
  try {
    var res = await http.post(Uri.parse(uri), body: {"idStudent": idStudent});
    var response = jsonDecode(res.body);
    if (response["success"] == true) {
      print("Student deleted");
    } else {
      print("Task not deleted. Server response: ${response['error']}");
    }
  } catch (error) {
    print("Error during task deletion: $error");
  }
}


/// Function that saves the student password on a [String] list [selectedPasswd] and [selectedDBPasswd] of the
/// existing student with id = [actualStudentId] from DataBase
///
/// Throws an [error] if the query fails
Future<List<String>> getStudentPassword(String actualStudentId) async {
  List<String> selectedPasswd =  ['','','',''];

  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/view_student_password.php?idStudent=$actualStudentId";
  try {
    var res = await http.get(Uri.parse(uri));

    var response = jsonDecode(res.body);
    if (response["success"] == "true") {
      print("Contraseña obtenida");
        selectedPasswd[1] = response["data"]["pictogram1"].toString();
        selectedPasswd[2] = response["data"]["pictogram2"].toString();
        selectedPasswd[3] = response["data"]["pictogram3"].toString();
    } else {
      print("Error en response getStudentPassword");
    }
  } catch (error) {
    print(error);
  }

  return selectedPasswd;
}


/// Function that inserts an student on DataBase by calling an API function
///
/// It adds its [name], its [surname], the picture string and the boolean
/// format attributes [read], [sound], [video]
///
/// It returns the id of the created student
///
/// Throws an [error] if the query fails
Future<String> insertStudent(String name, String surname,
    bool read, bool sound, bool video) async {
  String actualStudentId = '';

  try {
    /// Uri whose IP is on .env that calls API
    String uri = "${dotenv.env['API_URL']}/insert_student.php";

    var res = await http.post(Uri.parse(uri), body: {
      "firstName": name,
      "lastName": surname,
      "picture": '',
      "text": read.toString() == 'true' ? '1' : '0',
      "audio": sound.toString() == 'true' ? '1' : '0',
      "video": video.toString() == 'true' ? '1' : '0',
    });

    var response = jsonDecode(res.body);
    if (response["success"] == "true") {
      print("Datos insertados");
      int newStudentId = response["idStudent"];
        actualStudentId = newStudentId.toString();
        print("Nuevo idStudent: $actualStudentId");
    } else {
      print("Datos no insertados");
    }
  } catch (error) {
    print(error);
  }

  return actualStudentId;
}


/// Function that uploads the photo of an student on API directory
/// by calling an API function
///
/// It uploads it with [_photo] by [actualStudentId]
///
/// Throws an [error] if the query fails
Future<void> uploadPhoto(String actualStudentId, File photo) async {
  String uri = "${dotenv.env['API_URL']}/upload_student_photo.php";

  try {
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['idStudent'] = actualStudentId;
    var picture = await http.MultipartFile.fromPath("image", photo.path);
    request.files.add(picture);
    var response = await request.send();

    if (response.statusCode == 200) {
      print ("Image Uploaded");
    }
    else {
      print("Error en la subida");
    }

  } catch (error) {
    print(error);
  }
}


/// Function that uploads the password of an student on API directory
/// by calling an API function
///
/// It uploads it with [selectedPasswd] by [actualStudentId]
///
/// Throws an [error] if the query fails
Future<void> uploadPassword(String actualStudentId, List<String> selectedPasswd) async {
  String uri = "${dotenv.env['API_URL']}/upload_password.php";
  try {
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['idStudent'] = actualStudentId;
    var pictogram1 = await http.MultipartFile.fromPath(
        "pictogram1", selectedPasswd[1]);
    request.files.add(pictogram1);
    var pictogram2 = await http.MultipartFile.fromPath(
        "pictogram2", selectedPasswd[2]);
    request.files.add(pictogram2);
    var pictogram3 = await http.MultipartFile.fromPath(
        "pictogram3", selectedPasswd[3]);
    request.files.add(pictogram3);
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image Uploaded");
    }
    else {
      print("Error en la subida");
    }
  } catch (error) {
    print(error);
  }
}


/// Function that updates an student password on DataBase by calling an API function
///
/// It updates it with [selectedPasswd] by [actualStudentId]
///
/// Throws an [error] if the query fails
Future<void> updatePassword(String actualStudentId, List<String> selectedPasswd) async {
  String uri = "${dotenv.env['API_URL']}/update_password.php";
  try {
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['idStudent'] = actualStudentId;
    var pictogram1 = await http.MultipartFile.fromPath(
        "pictogram1", selectedPasswd[1]);
    request.files.add(pictogram1);
    var pictogram2 = await http.MultipartFile.fromPath(
        "pictogram2", selectedPasswd[2]);
    request.files.add(pictogram2);
    var pictogram3 = await http.MultipartFile.fromPath(
        "pictogram3", selectedPasswd[3]);
    request.files.add(pictogram3);
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Password Updated");
    }
    else {
      print("Error en la subida");
    }
  } catch (error) {
    print(error);
  }
}


/// Function that updates an student on DataBase by calling an API function
///
/// It updates its [name], its [surname] and the boolean
/// format attributes [read], [sound], [video] by [idStudent]
///
///
/// Throws an [error] if the query fails
Future<void> updateStudent (String idStudent, String name, String surname,
    bool read, bool sound, bool video) async {
  String uri = "${dotenv.env['API_URL']}/update_student.php";

  try {
    var res=await http.post(Uri.parse(uri),body: {
      "idStudent": idStudent,
      "firstName": name,
      "lastName": surname,
      "text": read.toString() == 'true' ? '1' : '0',
      "audio": sound.toString() == 'true' ? '1' : '0',
      "video": video.toString() == 'true' ? '1' : '0',
    });

    var response=jsonDecode(res.body);

    if(response["success"]=="true"){
      print("Datos actualizados");
    }else{
      print("Some issue");

    }
  } catch (error) {
    print(error);
  }
}


/// It gets a student with id = [idStudent] from the DataBase
///
/// Throws an [error] if the query fails
Future<Map<String,dynamic>> getStudentById(String idStudent) async {
  Map<String,dynamic> student = {};

  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/view_student_by_id.php?idStudent=$idStudent";
  try {
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      student = json.decode(response.body)['data'];
    } else {
      print('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
  }

  return student;
}