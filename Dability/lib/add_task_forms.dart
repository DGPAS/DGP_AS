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
              child: const TextForm(requiredField: true, titulo: "Nombre de la tarea", tipo: FormType.title,),
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
              child: const TextForm(requiredField: false, titulo: "Descripción de la tarea", tipo: FormType.description),
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
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    child: UploadForm(requiredField: false, titulo: "Añadir pictogramas del proceso a realizar", tipo: FormType.imagesUpload),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 10.0, top: 30.0, right: 10.0),
                    child: const TextForm(requiredField: false, titulo: "Descripción de las imágenes", tipo: FormType.description),
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