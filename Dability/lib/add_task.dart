import 'package:flutter/material.dart';
import 'package:dability/text_form.dart';
import 'package:dability/form_type.dart';


class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crer Tareas"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(30.0),
            child: const TextForm(requiredField: true, titulo: "Nombre de la tarea", tipo: FormType.title,),
          ),
          Container(
            padding: const EdgeInsets.all(30.0),
            child: const TextForm(requiredField: false, titulo: "Descripción de la tarea", tipo: FormType.description),
          ),
        ],
      ),
    );
  }
}