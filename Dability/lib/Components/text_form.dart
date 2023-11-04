import 'package:flutter/material.dart';
import 'package:dability/Components/form_type.dart';

class TextForm extends StatefulWidget {
  final bool requiredField;
  final String titulo;
  final TextFormType tipo;
  String text = "";

  TextForm({
    Key? key,
    required this.requiredField,
    required this.titulo,
    required this.tipo,
  }) : super(key: key);

  String getText() {
    return text;
  }

  @override
  _TextFormState createState() => _TextFormState(requiredField: requiredField, titulo: titulo, tipo: tipo);
}

class _TextFormState extends State<TextForm> {
  final _formKey = GlobalKey<FormState>();
  String campoRequerido = "* Campo requerido";
  String titulo = "";
  TextFormType tipo = TextFormType.title;
  final bool requiredField;
  final controller = TextEditingController();

  _TextFormState({required this.requiredField, required this.titulo, required this.tipo});

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    controller.addListener(_getLastValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    controller.dispose();
    super.dispose();
  }

  void _getLastValue () {
    widget.text = controller.text;
  }

  double getContentPadding () {
    if (tipo == TextFormType.title) {
      return 12.0;
    } else if (tipo == TextFormType.description) {
      return 200.0;
    } else {
      return 12.0; // Valor por defecto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '$titulo${requiredField ? ' *' : ''}',
            ),
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(10,20,0,getContentPadding()),
              helperText: requiredField ? campoRequerido : null,
              alignLabelWithHint: true,
            ),
            textAlignVertical: TextAlignVertical.top,
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (value) {
              return (value == null || value.isEmpty) ? '' : null;
            },
          ),
        ],
      ),
    );
  }
}
