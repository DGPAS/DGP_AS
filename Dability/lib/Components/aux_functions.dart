import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// add_mod_student
// Future<void> getData (int actualStudentId) async {
//   List<String> selectedDBPasswd;
//   List<String> selectedPasswd;
//
//   selectedPasswd = await getStudentPassword(actualStudentId);
//   setState(() {
//     selectedDBPasswd.clear();
//     selectedDBPasswd.addAll(selectedPasswd);
//   });
//   print("------------------------ ${selectedDBPasswd}");
// }
//


// add_mod_student
String getTitle (AddModType? typeForm, String? nameStudent) {
  if (typeForm == AddModType.add) {
    return 'Crear Estudiante';
  } else {
    return 'Modificar Estudiante: $nameStudent';
  }
}

// add_mod_task
String getTitleTask (AddModType? typeForm, String? title) {
  if (typeForm == AddModType.add) {
    return 'Crear Tarea';
  } else {
    return 'Modificar tarea: $title';
  }
}


// add_mod_student y add_mod_task
String getSubmitButton (AddModType? typeForm) {
  if (typeForm == AddModType.add) {
    return 'Crear';
  } else {
    return 'Modificar';
  }
}

// agenda
/// Function thats return the orientation of the device
Orientation orientation (double width, double height) {
  return width > height ? Orientation.landscape : Orientation.portrait;
}

// add_mod_student
// Widget _getImage(AddModType typeForm, String? urlPath) {
//   if (urlPath == null || urlPath == '') {
//     return const Image(
//         image: AssetImage('assets/images/no_image.png'), fit: BoxFit.contain);
//   } else {
//     if (typeForm == AddModType.add || (typeForm == AddModType.mod && urlPath != widget.student?['picture'])) {
//       return Image.file(File(urlPath), fit: BoxFit.cover);
//     }
//     else {
//       return Image.network("${dotenv.env['API_URL']}/images/students/$urlPath");
//     }
//   }
// }

// Widget _getPasswd(AddModType typeForm, String? urlPath, int numImage) {
//   if (urlPath == null || urlPath == '') {
//     print("getPasswd -------- Cargo del asset");
//     return const Image(
//         image: AssetImage('assets/images/no_image.png'), fit: BoxFit.contain);
//   } else {
//     if (typeForm == AddModType.add || (typeForm == AddModType.mod && (urlPath != selectedDBPasswd[numImage]))) {
//       //print("$urlPath == ${selectedDBPasswd[numImage]}");
//       print("getPasswd -------- Cargo del file (add)");
//       return Image.file(File(urlPath), fit: BoxFit.cover);
//     }
//     else {
//       print("getPasswd -------- Cargo de network (else)");
//       return Image.network("${dotenv.env['API_URL']}/images/students/passwords/$urlPath");
//     }
//   }
// }
