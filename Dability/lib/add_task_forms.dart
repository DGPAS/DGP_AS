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
  // Formulario para la descripción de la tarea
  TextForm descriptionForm = TextForm(requiredField: false, titulo: "Descripción general de la tarea", tipo: TextFormType.description);

  // Variables donde se almacenará el valor del titulo y la descripcion
  String title = "";
  String description = "";
  // isPressed: variable para la ayuda de añadir pasos
  bool isPressed = false;


  List<ListStep> steps = [];
  List<ListStep> copy = [];
  List<ListStep> auxSteps = [];

  @override
  void initState() {
    super.initState();

    title = titleForm.getText();
    description = descriptionForm.getText();

    steps = [];

    isPressed = false;
  }

  // Función que devuelve en columna todos los pasos añadidos
  List<Widget> getSteps() {
    return steps.map((step) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text ('Paso ${step.numStep}, formatos:', style: const TextStyle(fontWeight: FontWeight.bold)),

                // Botón para eliminar el paso
                Container(
                  child: ElevatedButton (
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                    ),
                    child: const Text('Eliminar Paso'),
                    onPressed: () {
                      auxSteps = steps;
                      auxSteps.removeWhere((stepToDelete) => stepToDelete.numStep == step.numStep);
                      setState(() {
                        steps = auxSteps;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          if (step.image != '' && step.image != null)
            Column (
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                    alignment: Alignment.topLeft,
                    child: const Text('Imagen'),
                  ),
                  Image(image: AssetImage(step.image), fit: BoxFit.contain),
                ],
            ),
          if (step.description != '' && step.description != null)
            Column (
              children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                alignment: Alignment.topLeft,
                child: const Text('Descripción'),
              ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 30, top: 20),
                  child: Text (
                    step.description,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          if (step.video != '' && step.video != null)
            Column (
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  alignment: Alignment.topLeft,
                  child: const Text('Descripción'),
                ),
                Image(image: AssetImage(step.image), fit: BoxFit.contain),    // TODO: Manejar los ficheros de tipo vídeo
              ],
            ),
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
            // Contenedor para introducir el título de la tarea en el formulario
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
            // Contenedor para introducir la descripción de la tarea en el formulario
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
              child: descriptionForm,
            ),
            // Contenedor con diferentes botones para introducir formatos diversos a cada paso de la tarea
            // TODO: Cambiar IU para que se muestren los botones en un Grid
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
              margin: const EdgeInsets.only(left: 10.0, top: 30.0, right: 20.0, bottom: 20.0),


              // Columna que muestra instrucciones en forma de texto y una serie de botones
              // que llevan a las páginas para añadir pasos de la tarea en diferente formato
              child: Container (
                width: 1000,
                child: Column (
                  children: <Widget>[
                    Row (
                      children: [
                        const Text('Puede añadir pasos a la tarea.'),
                        Container(
                          child: GestureDetector(
                            onTapDown: (_) {
                              setState(() {
                                isPressed = true;
                              });
                            },
                            onTapUp: (_) {
                              setState(() {
                                isPressed = false;
                              });
                            },
                            child: Container (
                              child: const Icon(Icons.help),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Contenedor con la ayuda
                    if (isPressed == true)
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            )
                        ),
                        child: const Column (
                          children: [
                            Text('Tenga en cuenta que para cada paso, puede añadir distintos formatos. Para ello, elija el formato abajo y una vez seleccionado, introduzca el número de paso deseado.'),
                            Text('Luego se le mostrará a cada alumno el formato de pasos más indicado.'),
                            Text('Además, si ya ha creado un paso, puede modificar sus valores o añadir formatos nuevos introduciendo el número de paso dentro.'),
                          ],
                        ),
                      ),

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
            ),

            // Container para mostrar los pasos añadidos
            const Text ('Previsualización de la tarea en creación:'),
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
              margin: const EdgeInsets.only(left: 10.0, top: 10.0, right: 20.0),
              child: Column (
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: ElevatedButton (
                      child: const Text('Refrescar'),
                      onPressed: () {
                        setState(() {
                          title = titleForm.getText();
                          description = descriptionForm.getText();
                        });
                      },
                    ),
                  ),
                  if (title != "")
                    Text('Título: ${title}', style: const TextStyle(fontWeight: FontWeight.bold),),
                  if (description != "")
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        children: [
                          const Text('Descripción general', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(description, textAlign: TextAlign.justify),
                        ],
                      ),
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
              onPressed: null,  // TODO: Implementar funcionalidad al presionar botón Cancelar
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
                onPressed: null,  // TODO: Implementar funcionalidad al presionar botón Crear
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