import 'package:dability/Components/upload_form.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
import 'package:dability/Components/form_type.dart';

class AddTaskForms extends StatelessWidget {
  const AddTaskForms({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 30.0, top: 30.0, left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  )
              ),
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: const TextForm(requiredField: true, titulo: "Nombre de la tarea", tipo: TextFormType.title,),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  )
              ),
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(left: 10.0, top: 30.0, right: 20.0),
              child: const TextForm(requiredField: false, titulo: "Descripción de la tarea", tipo: TextFormType.description),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  )
              ),
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(left: 10.0, top: 30.0, right: 20.0),
              child: Column (

                children: <Widget>[
                  const Text('Puede añadir imágenes a la tarea.'),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    child: UploadForm(requiredField: false, titulo: "Seleccionar pictogramas de la galería: ", tipo: ImageFormType.gallery),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    child: UploadForm(requiredField: false, titulo: "Realizar una foto: ", tipo: ImageFormType.camera),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}