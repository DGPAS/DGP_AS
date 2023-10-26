import 'package:flutter/material.dart';


class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @Override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crer Tareas"),
      ),
      body: Column(
        children: <Widget>[
          Form(child: child),
        ],
      ),
    )
  }
}