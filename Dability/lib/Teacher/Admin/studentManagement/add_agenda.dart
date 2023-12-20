import 'package:dability/Api_Requests/task_requests.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dability/Teacher/Admin/taskManagement/steps_task_form.dart';
import 'package:flutter/material.dart';
import 'package:dability/Components/text_form.dart';
import 'package:dability/Components/enum_types.dart';
import 'package:dability/Components/list_step.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:dability/Api_Requests/agenda_requests.dart';

/// # Page for add or modify a task
///
/// It receives a required param [typeForm] that indicates if it is
/// for add a task or modify the given one with [task]
class AddAgendaTask extends StatefulWidget {
  AddAgendaTask(
      {Key? key,
        this.student
      })
      : super(key: key);

  final Map<String, dynamic>? student;

  @override
  State<AddAgendaTask> createState() => _AddAgendaTaskState();
}


class _AddAgendaTaskState extends State<AddAgendaTask> {
  _AddAgendaTaskState();
  List<dynamic> tasks = [];
  double widthMax = 500;

  List<dynamic> displayedItems = [];

  /// Variables where it will be stored the data of a task
  DateTime? startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime? endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime? doneDate = null;
  /// Variables to manage the task data
  String actualTaskId = '';
  String actualStudentId = '';


  /// Init State
  ///
  /// Initialize the task data and its steps, if it has,
  /// by calling [getTaskSteps]
  @override
  void initState() {
    super.initState();
    actualStudentId = widget.student?['id'];
  }


  /// Function that calls funtions that calls API
  ///
  /// If it is adding a task, it insert the task data,
  /// it uploads the miniature, the video and, for
  /// each step in [steps], it adds each one
  ///
  /// If it is modifying a task, it updates the task by
  /// its id [id], it updates the miniature and
  /// it updates its steps
  Future<void> submitForm (String? id) async {
    await(insertAgendaTask(actualStudentId, id.toString(), startDate.toString(), endDate.toString()));
  }

  /// Function that calls [getStudents] who returns the DataBase students
  /// and adds them to [displayedItems]
  Future<void> getData () async {
    tasks = await getTasks();
    setState(() {
      displayedItems.clear();
      displayedItems.addAll(tasks);
    });
  }

  /// Function that returns the title of [AppBar]
  ///
  /// If [typeForm] == [AddModType.add], it updates it to creating a task
  ///
  /// If [typeForm] == [AddModType.mod], it updates it to modifying a task
  String getTitle () {
    return "Añadiendo tarea a agenda del alumno";
  }


  /// Function that returns the submit button name of [BottomNavigationBar]
  ///
  /// If [typeForm] == [AddModType.add], it updates it to create (a task)
  ///
  /// If [typeForm] == [AddModType.mod], it updates it to modify (a task)
  String getSubmitButton () {
    return 'Modificar';
  }

  /// Main builder of the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            Expanded(
              child: Text(
                getTitle(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A6987),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/userIcon.png',
                    width: 48,
                    height: 48,
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
              bottom: 30.0, top: 30.0, left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[

              /// Container to introduce the [startDate] of the task
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
                child: Column(
                  children: [
                    const Text("Selecciona la fecha de inicio de la tarea"),
                    Text(DateFormat('yyyy-MM-dd').format(startDate!)),
                    /*ElevatedButton(
                      onPressed: () => selectDate(context, startDate, true),

                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        elevation: 0,
                      ),
                      child: Icon(
                        Icons.calendar_today,
                        size: 100,
                      ),
                    ),*/

                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );

                        if (picked != null){
                          setState(() {
                            startDate = picked;
                            endDate = picked;
                          });
                        }
                        //Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.calendar_today,
                        size: 100,
                      ),
                    ),
                  ],
                ),
              ),
              /// Container to introduce the [endDate] of the task
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
                child: Column(
                  children: [
                    const Text("Selecciona la fecha de finalización de la tarea"),
                    Text(DateFormat('yyyy-MM-dd').format(endDate!)),
                    /*ElevatedButton(
                      onPressed: () => selectDate(context, endDate, false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        elevation: 0,
                      ),
                      child: Icon(
                        Icons.calendar_today,
                        size: 100,
                      ),
                    ),*/

                    GestureDetector(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: startDate ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                          firstDate: startDate!,
                          lastDate: DateTime(2101),
                        );


                        if (picked != null){
                          setState(() {
                            endDate = picked;
                          });
                        }
                        //Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.calendar_today,
                        size: 100,
                      ),
                    ),
                  ],
                ),
              ),
              ...List.generate(displayedItems.length, (index) {
                return Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            double.infinity,
                            MediaQuery.of(context).size.height *
                                0.1), // inf, 80
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Color(0xFFF5F5F5),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      onPressed: () {
                        submitForm(displayedItems[index]['idTask']);
                        Navigator.pop(context);
                      },
                      /// The content of each student
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Task info
                            Text(
                              '${displayedItems[index]['taskName']}',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(height: 30), // Espacio entre las tareas
                  ],
                );
              }),
            ],
          ),
        ),
      ),

      /// BottomAppBar to submit or cancel the action
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF4A6987),
        height: 50,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              /// Cancel button
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: <Widget>[
                    Text('Cancelar ', style: TextStyle(color: Colors.black)),
                    Icon(Icons.cancel_presentation, color: Colors.redAccent),
                  ],
                ),
              ),

              /// Submit button
              ///
              /// On pressed, it updates data task and check if they are not
              /// null. After that, it calls [submitForm] with [id] and
              /// pops to previous page
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.white)),
                onPressed: () {
                  submitForm(actualTaskId);
                  Navigator.of(context).pop();
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

  /// Predefined style for some containers
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ));
  }
}
