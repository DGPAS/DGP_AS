import 'package:dability/Components/steps_task_form.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
import 'package:dability/Components/form_type.dart';
import 'package:dability/Components/list_step.dart';
import 'dart:developer';

class AddTaskForms extends StatefulWidget {
  const AddTaskForms({super.key});

  @override
  _AddTaskFormsState createState() => _AddTaskFormsState ();
}

class _AddTaskFormsState extends State<AddTaskForms> {

  _AddTaskFormsState ();

  // Formulario para el titulo de la tarea
  TextForm titleForm = TextForm(requiredField: true, titulo: "Nombre de la tarea", tipo: TextFormType.title);


  List<ListStep> steps = [];
  List<ListStep> copy = [];

  @override
  void initState() {
    super.initState();

    steps = [];
  }

  List<Widget> getSteps() {
    return steps.map((step) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.topLeft,
            child: Text ('Paso ${step.numStep}'),
          ),
          if (step.image != '' && step.image != null)
            Image(image: AssetImage(step.image), fit: BoxFit.contain),
          if (step.description != '' && step.description != null)
            Container(
              alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 20, top: 20),
                child: Text (
                  step.description,
                  textAlign: TextAlign.justify,
                ),
            ),
          if (step.video != '' && step.video != null)
            Image(image: AssetImage(step.image), fit: BoxFit.contain),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              child: titleForm,
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
              child: TextForm(requiredField: false, titulo: "Descripción de la tarea", tipo: TextFormType.description),
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
                  const Text('Puede añadir pasos a la tarea.'),
                  const Text('Tenga en cuenta que puede añadir el mismo paso en distintos formatos, luego se le mostrará a cada alumno el formato de pasos más indicado.'),
                  const Text('Seleccione que tipo de paso desea añadir a continuación: '),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        copy = await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => StepsTaskForm(requiredField: false, titulo: "Realizar una foto", tipo: StepsFormType.camera, steps: steps),
                        ));
                        setState(() {
                          steps = copy;
                        });
                      },
                      child: const Text('Añadir una imagen con la cámara'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        copy = await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => StepsTaskForm(requiredField: false, titulo: "Seleccionar una foto de la galeria", tipo: StepsFormType.gallery, steps: steps),
                        ));
                        setState(() {
                          steps = copy;
                        });
                      },
                      child: const Text('Añadir una imagen desde galería'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        copy = await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => StepsTaskForm(requiredField: false, titulo: "Añadir un paso con texto", tipo: StepsFormType.description, steps: steps),
                        ));
                        setState(() {
                          steps = copy;
                        });
                      },
                      child: const Text('Añadir un paso con texto'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        copy = await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => StepsTaskForm(requiredField: false, titulo: "Añadir un paso con imagen y texto", tipo: StepsFormType.image_description, steps: steps),
                        ));
                        setState(() {
                          steps = copy;
                        });
                      },
                      child: const Text('Añadir un paso con imagen y texto'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        copy = await Navigator.push(context, MaterialPageRoute(
                          builder: (context) => StepsTaskForm(requiredField: false, titulo: "Añadir un vídeo", tipo: StepsFormType.description, steps: steps),
                        ));
                        setState(() {
                          steps = copy;
                        });
                      },
                      child: const Text('Añadir un vídeo'),
                    ),
                  ),
                ],
              ),
            ),
            if (steps.length > 0)
            Container(
              width: 1000,
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
                children: [
                  Container(
                    child: Text(titleForm.getText()),
                  ),
                  Column(
                    children: getSteps(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),


    // Botones "Cancelar y Crear"
    bottomNavigationBar: BottomAppBar(
      color: Colors.blue,
      height: 50,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              ),
              onPressed: null,
              child: Row(
                children: <Widget>[
                Text('Cancelar ', style: TextStyle(color: Colors.black)),
                Icon(Icons.cancel_presentation, color: Colors.redAccent),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)
              ),
                onPressed: null,
                child: Row(
                  children: <Widget>[
                    Text('Crear ', style: TextStyle(color: Colors.black)),
                    Icon(Icons.add, color: Colors.lightGreenAccent),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}