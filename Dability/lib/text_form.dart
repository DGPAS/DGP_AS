import 'package:flutter/material.dart';

// Define a custom Form widget.
class TextForm extends StatefulWidget {
  const TextForm({super.key});

  @override
  TextFormState createState() {
    return TextFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class TextFormState extends State<TextForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),

        ),
        position: DecorationPosition.background,
        child: Column(
          children: <Widget>[
            Container (
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: const Text("Nombre de la tarea"),
            ),
            TextField (
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nombre de la tarea',
              ),
            ),
          ],
        ),

      ),
    );
  }
}