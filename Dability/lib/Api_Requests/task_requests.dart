import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';


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


/// It deletes a task with id = [idTask] from the DataBase
///
/// Throws an [error] if the query fails
Future<void> deleteTask(String idTask) async {
  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/delete_task.php";
  try {
    var res = await http.post(Uri.parse(uri), body: {"idTask": idTask});
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


/// Function that inserts a task on DataBase by calling an API function
///
/// It adds its name, its description, the miniature name and the video name
///
/// Throws an [error] if the query fails
Future<String> insertTaskData(String title, String description) async {
  String actualTaskId = '';
  try {
    /// Uri whose IP is on .env that calls API
    String uri = "${dotenv.env['API_URL']}/insert_task.php";

    var res = await http.post(Uri.parse(uri), body: {
      "taskName": title.trim(),
      "description": description.trim(),
      "video": '',
    });

    var response = jsonDecode(res.body);
    if (response["success"] == "true") {
      print("Datos insertados");

      int newTaskId = response["idTask"];
      print("Nuevo idTareas: $newTaskId");
        actualTaskId = newTaskId.toString();
    } else {
      print("Datos no insertados");
    }
  } catch (error) {
    print(error);
  }

  return actualTaskId;
}


/// Function that updates a task on DataBase by calling an API function
///
/// It updates its name and description by [id]
///
/// Throws an [error] if the query fails
Future<void> updateData (String id, String title, String description) async {
  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/update_data.php";

  try {
    var res=await http.post(Uri.parse(uri),body: {
      "idTask": id,
      "taskName": title.trim(),
      "description": description.trim(),
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


/// Function that uploads the miniature of a task on API directory
/// by calling an API function
///
/// It uploads it with [selectedImage] by [actualTaskId]
///
/// Throws an [error] if the query fails
Future<void> uploadImage(String actualTaskId, String selectedImage) async {
  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/upload_image.php";

  try {
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['idTask'] = actualTaskId;
    var picture = await http.MultipartFile.fromPath("image", selectedImage);
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


/// Function that uploads the video of a task on API directory
/// by calling an API function
///
/// It uploads it with [selectedVideo] by [actualTaskId]
///
/// Throws an [error] if the query fails
Future<void> saveVideo(String actualTaskId, String selectedVideo) async {
  if (selectedVideo == "") {
    print("No se ha seleccionado ningún video");
    return;
  }

  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/saveVideo.php";

  try {
    var request = http.MultipartRequest('POST', Uri.parse(uri));

    // Puedes agregar la lógica para seleccionar un video específico en el emulador
    // Esto puede variar según el emulador que estés utilizando

    // Simplemente usa el path del video seleccionado
    request.fields['idTask'] = actualTaskId;
    var videoFile = await http.MultipartFile.fromPath("video", selectedVideo);
    request.files.add(videoFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Video Uploaded");
      print("Response Body: ${await response.stream.bytesToString()}");
    } else {
      print("Error in uploading video. Status Code: ${response.statusCode}");
    }
  } catch (error) {
    print("Exception during video upload: $error");
  }
}

/// Function that updates the miniature task by searching it on
/// API images directory
Image getThumbnail(String thumbnail) {
  Image thumbnailImage = Image.network("${dotenv.env['API_URL']}/images/$thumbnail");

  return thumbnailImage;
}