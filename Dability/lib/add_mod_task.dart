import 'dart:convert';

import 'package:dability/Components/steps_task_form.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:dability/Components/list_step.dart';
import 'package:http/http.dart' as http;


class AddModTask extends StatefulWidget {
  AddModTask(
      {Key? key,
      required this.typeForm,
      this.steps,
      this.title,
      this.description,
      this.idTareas})
      : super(key: key);

  AddModType typeForm;
  List<ListStep>? steps;
  String? title;
  String? description;
  String? idTareas;

  @override
  State<AddModTask> createState() => _AddModTaskState(
      typeForm: typeForm,
      stepsInit: steps,
      title: title,
      description: description,
      idTareas: idTareas,
  );
}




class _AddModTaskState extends State<AddModTask> {
  _AddModTaskState(
      {required this.typeForm, this.stepsInit, this.title, this.description, this.idTareas});

  // Formulario para el titulo de la tarea
  TextForm titleForm = TextForm(
      requiredField: true,
      titulo: "Nombre de la tarea",
      tipo: TextFormType.title);
  // Formulario para la descripción de la tarea
  TextForm descriptionForm = TextForm(
      requiredField: false,
      titulo: "Descripción general de la tarea",
      tipo: TextFormType.description);

  // Variables donde se almacenará el valor del titulo y la descripcion
  String? title;
  String? description;
  String? idTareas;
  // isPressed: variable para la ayuda de añadir pasos
  bool isPressed = false;
  AddModType typeForm;

  List<ListStep>? stepsInit;
  List<ListStep> steps = [];
  List<ListStep> copy = [];
  List<ListStep> auxSteps = [];

  @override
  void initState() {
    super.initState();
    // Si title o description es nulo
    // (es decir, si lo que se quiere es añadir una tarea y no modificarla)
    // se inicializan segun el valor del controlador
    title ??= titleForm.getText();
    description ??= descriptionForm.getText();

    titleForm.originalText = title;
    titleForm.text = title!;
    descriptionForm.originalText = description;
    descriptionForm.text = description!;

    // Si stepsInit es nulo
    // (es decir, si lo que se quiere es añadir una tarea y no modificarla)
    // se inicializa a vacío
    if (stepsInit != null) {
      steps = stepsInit!; // La ! es de nullCheck
    }

    isPressed = false;
  }

  // TODO: Añadir al formulario la opcion de insertar una miniatura

  void submitForm (String? idTareas) {
    if (typeForm == AddModType.add) {
      insertData();
    } else {
      updateData(idTareas);
    }
  }

  Future<void> insertData() async {
    try {
        String uri = "http://10.0.2.2:80/insert_data.php";

        print("Datos a enviar: ${title}, 0, ${description}, null, null, null, null");

        var res = await http.post(Uri.parse(uri), body: {
          "nombre": title?.trim(),
          "realizada": "0",
          "descripcion": description?.trim(),
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Datos insertados");
        } else {
          print("Datos no insertados");
        }
      } catch (e) {
        print(e);
      }
  }

  Future<void> updateData (String? idTareas) async {
    String uri = "http://10.0.2.2/update_data.php";

    try {
      print("Datos a modificar: ${title}, ${description}");

      var res=await http.post(Uri.parse(uri),body: {
        "idTareas": idTareas,
        "nombre": title?.trim(),
        "descripcion": description?.trim(),
      });

      var response=jsonDecode(res.body);

      if(response["success"]=="true"){
        print("Datos actualizados");
      }else{
        print("Some issue");

      }
    } catch (e) {
      print(e);
    }
  }



  // Función para cambiar el titulo de la barra segun sea crear o modificar
  String getTitle () {
    if (typeForm == AddModType.add) {
      return 'Crear Tarea';
    } else {
      return 'Modificar tarea: $title';
    }
  }

  String getSubmitButton () {
    if (typeForm == AddModType.add) {
      return 'Crear';
    } else {
      return 'Modificar';
    }
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
                Text('Paso ${step.numStep}, formatos:',
                    style: const TextStyle(fontWeight: FontWeight.bold)),

                // Botón para eliminar el paso
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.red),
                    ),
                    child: const Text('Eliminar Paso'),
                    onPressed: () {
                      auxSteps = steps;
                      auxSteps.removeWhere((stepToDelete) =>
                          stepToDelete.numStep == step.numStep);
                      setState(() {
                        steps = auxSteps;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          if (step.image != '')
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  alignment: Alignment.topLeft,
                  child: const Text('Imagen'),
                ),
                Image(image: AssetImage(step.image), fit: BoxFit.contain),
              ],
            ),
          if (step.description != '')
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  alignment: Alignment.topLeft,
                  child: const Text('Descripción'),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 30, top: 20),
                  child: Text(
                    step.description,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          if (step.video != '')
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  alignment: Alignment.topLeft,
                  child: const Text('Descripción'),
                ),
                Image(
                    image: AssetImage(step.image),
                    fit: BoxFit
                        .contain), // TO DO: Manejar los ficheros de tipo vídeo
              ],
            ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
              bottom: 30.0, top: 30.0, left: 10.0, right: 10.0),
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
                    )),
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
                    )),
                padding: const EdgeInsets.all(20.0),
                margin:
                    const EdgeInsets.only(left: 10.0, top: 30.0, right: 20.0),
                child: descriptionForm,
              ),
              // Contenedor con diferentes botones para introducir formatos diversos a cada paso de la tarea
              // TO DO: Cambiar IU para que se muestren los botones en un Grid
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(
                    left: 10.0, top: 30.0, right: 20.0, bottom: 20.0),

                // Columna que muestra instrucciones en forma de texto y una serie de botones
                // que llevan a las páginas para añadir pasos de la tarea en diferente formato
                child: Container(
                  width: 1000,
                  child: Column(
                    children: <Widget>[
                      Row(
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
                              child: Container(
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
                              )),
                          child: const Column(
                            children: [
                              Text(
                                  'Tenga en cuenta que para cada paso, puede añadir distintos formatos y no es necesario que contenga todos, aunque si recomendable. Para ello, rellene los campos deseados e introduzca el número de paso al que corresponde.'),
                              Text(
                                  'Luego se le mostrará a cada alumno el formato de pasos más indicado.'),
                              Text(
                                  'Además, si ya ha creado un paso, puede modificar sus valores o añadir formatos nuevos introduciendo el número de paso dentro.'),
                            ],
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.only(
                            left: 10.0, top: 10.0, right: 10.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            copy = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StepsTaskForm(
                                      requiredField: false, steps: steps),
                                ));
                            setState(() {
                              steps = copy;
                            });
                          },
                          child: const Text('Añadir un paso'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Container para mostrar los pasos añadidos
              const Text('Previsualización de la tarea en creación:'),
              Container(
                width: 1000,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                padding: const EdgeInsets.all(20.0),
                margin:
                    const EdgeInsets.only(left: 10.0, top: 10.0, right: 20.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
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
                      Text(
                        'Título: $title',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    if (description != "")
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: [
                            const Text('Descripción general',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(description ?? '',
                                textAlign: TextAlign.justify),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white),
                ),
                onPressed:
                    null, // TODO: Implementar funcionalidad al presionar botón Cancelar
                child: Row(
                  children: <Widget>[
                    Text('Cancelar ', style: TextStyle(color: Colors.black)),
                    Icon(Icons.cancel_presentation, color: Colors.redAccent),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.white)),
                onPressed: () {
                  if ((title == '' || title == null) ||
                  (description == '' || description == null)) {
                  print("Los campos titulo y descripción son obligatorios");
                  } else {
                    submitForm(idTareas);
                    Navigator.of(context).pop();
                  }
                },
                    child: Row(
                  children: <Widget>[
                    Text(getSubmitButton(), style: TextStyle(color: Colors.black)),
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
