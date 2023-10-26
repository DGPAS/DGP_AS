import 'package:flutter/material.dart';
import 'package:dability/text_form.dart';


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
            padding: EdgeInsets.all(30.0),
            child: const TextForm(),
          ),
        ],
      ),
    );
  }
}