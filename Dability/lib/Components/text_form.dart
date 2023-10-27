import 'package:flutter/material.dart';
import 'package:dability/Components/form_type.dart';

class TextForm extends StatefulWidget {
  final bool requiredField;
  final String titulo;
  final FormType tipo;

  const TextForm({
    Key? key,
    required this.requiredField,
    required this.titulo,
    required this.tipo,
  }) : super(key: key);

  @override
  _TextFormState createState() => _TextFormState(requiredField: requiredField, titulo: titulo, tipo: tipo);
}

class _TextFormState extends State<TextForm> {
  final _formKey = GlobalKey<FormState>();
  String campoRequerido = "* Campo requerido";
  String titulo = "";
  FormType tipo = FormType.title;
  final bool requiredField;

  _TextFormState({required this.requiredField, required this.titulo, required this.tipo});

  double getContentPadding () {
    if (tipo == FormType.title) {
      return 12.0;
    } else if (tipo == FormType.description) {
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
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(10,20,0,getContentPadding()),
              helperText: requiredField ? campoRequerido : null,
              alignLabelWithHint: true,
            ),
            textAlignVertical: TextAlignVertical.top,
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
            },
          ),
        ],
      ),
    );
  }
}