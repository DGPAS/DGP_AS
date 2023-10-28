import 'package:flutter/material.dart';
import 'package:dability/Components/add_task_bar.dart';
import 'package:dability/add_task_forms.dart';


class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crer Tarea"),
      ),
      body: AddTaskForms(),
      bottomNavigationBar: AddTaskBar(),
    );
  }
}