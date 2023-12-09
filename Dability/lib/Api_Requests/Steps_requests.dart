import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:dability/Admin/taskManagement/steps_task_form.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:dability/Components/list_step.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// Function that saves the steps on a [ListStep] list [steps] of the
/// existing task with id = [idTareas] from DataBase
///
/// Throws an [error] if the query fails
Future<List<ListStep>> getInitialSteps(String idTask) async {
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

  print(loadedSteps);

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
      "image": step.image
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