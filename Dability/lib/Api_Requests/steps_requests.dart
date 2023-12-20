import 'dart:convert';
import 'package:dability/Components/list_step.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Function that saves the steps on a [ListStep] list [steps] of the
/// existing task with id = [idTareas] from DataBase
///
/// Throws an [error] if the query fails
Future<List<ListStep>> getTaskSteps(String idTask) async {
  List<ListStep> loadedSteps = [];

  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/view_steps.php?idTask=$idTask";
  try {
    var response = await http.get(
      Uri.parse(uri),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);

      for (var stepData in responseData) {
        loadedSteps.add(ListStep(
          stepData['numStep'],
          stepData['image'],
          stepData['description'],
        ));
      }
    } else {
      print('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
  }

  return loadedSteps;
}


/// Function that inserts a [step] of a task on DataBase by calling an API function
///
/// It adds its step number [numStep], its description and its image name by the [actualTaskId]
///
/// Throws an [error] if the query fails
Future<void> insertStepsData(String actualTaskId, ListStep step) async {
  try {
    /// Uri whose IP is on .env that calls API
    String uri = "${dotenv.env['API_URL']}/insert_steps.php";

    var res = await http.post(Uri.parse(uri), body: {
      "numStep": step.numStep.toString(),
      "idTask": actualTaskId,
      "description": step.description,
    });

    var response = jsonDecode(res.body);
    if (response["success"] == "true") {
      print("Datos insertados");
    } else {
      print("Datos no insertados");
    }
  } catch (error) {
    print(error);
  }
}

Future<void> uploadImageSteps(String idTask, String selectedImage, String numStep) async {
  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/upload_image_step.php";

 try {
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['id'] = idTask;
    var picture = await http.MultipartFile.fromPath("image", selectedImage);
    request.files.add(picture);
    request.fields['numStep'] = numStep;
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
/// Function that updates the steps of a task on DataBase by calling an API function
///
/// It updates them with [steps] by [id]
///
/// Throws an [error] if the query fails
Future<void> updateSteps (String idTask, List<ListStep> steps) async {
  /// Uri whose IP is on .env that calls API
  String uri = "${dotenv.env['API_URL']}/update_steps.php";

  try {
    var res=await http.post(Uri.parse(uri),body: {
      "steps": jsonEncode(steps.map((step) => step.toJson()).toList()),
      "idTask": idTask,
    });

    var response=jsonDecode(res.body);

    if(response["success"]=="true"){
      print("Steps actualizados");
    }else{
      print("Some issue");

    }
  } catch (error) {
    print(error);
  }
}