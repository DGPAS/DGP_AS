import 'package:dability/add_task_forms.dart';
import 'package:flutter/material.dart';
import 'package:dability/add_task.dart';


class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crer Tareas"),
      ),
      body: AddTaskForms(),
    );
  }
}