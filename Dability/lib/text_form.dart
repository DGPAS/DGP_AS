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
      child: const Column(
        children: <Widget>[
          Column(
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          )
        ],
      ),
    );
  }
}