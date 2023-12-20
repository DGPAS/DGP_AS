import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../Components/list_step.dart';
import 'package:dability/Student/Agenda/finish_task.dart';

/// # Page to see each step of a task
class TaskSteps extends StatefulWidget {

  final List<ListStep> steps;
  final Map<String, dynamic> task;
  final Map<String, dynamic> student;

  TaskSteps ({
    Key? key,
    required this.steps,
    required this.task,
    required this.student
  }) : super(key:key);

  @override
  State<TaskSteps> createState() => _TaskStepsState();
}


class _TaskStepsState extends State<TaskSteps> {
  _TaskStepsState();

  Map<String, dynamic> task = {};
  List<ListStep> steps = [];
  int index = 0;
  int numberOfSteps = 0;
  List<bool> checkedStep = [];
  bool isImageVisible = false;

  @override
  void initState () {
    super.initState();

    task = widget.task;

    steps = widget.steps;
    numberOfSteps = steps.length;
    checkedStep = List.generate(numberOfSteps, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Semantics(label: 'Logo de la aplicación', readOnly: true,
              child: Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),),
            /// Task title on AppBar
            Expanded(
              child: Semantics(label: 'Estás en, paso ${index+1} de la tarea , ', readOnly: true,
                child: Text(
                  widget.student['text'] == 1 ? task['taskName'].toString().toUpperCase() : "",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Image.network("${dotenv.env['API_URL']}/images/${task['thumbnail'].toString()}",
              width: 46,
              height: 46,
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
              child: Semantics(label: 'Perfil, se ve tu cara', readOnly: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network("${dotenv.env['API_URL']}/images/students/${widget.student['picture'].toString()}", width: 48, height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Semantics(label: 'Atrás para salir de los pasos de la tarea', readOnly: false,
              child: Icon(Icons.arrow_back, color: Colors.white,)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF4A6987),
      ),
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.025,
                left: MediaQuery.of(context).size.width * 0.0125,
                right: MediaQuery.of(context).size.width * 0.0125,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  /// Step Task Image
                  if (steps[index].image != null && steps[index].image != '')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Semantics(label: 'Imagen que describe el paso ${index + 1}', readOnly: true,
                        child: Image.network("${dotenv.env['API_URL']}/images/steps/${steps[index].image.toString()}",
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.75,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  /// Step description
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Semantics(label: 'Descripción del paso ${index+1},', readOnly: true,
                        child: Text(
                          widget.student['text'] == 1 ? steps[index].description.toString().toUpperCase() : "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                            ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  /// Button to achieve the step
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              checkedStep[index] = !checkedStep[index];
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(20),
                              //fixedSize: Size(250, 100),
                              //minimumSize: Size(250, 50),
                              //maximumSize: Size(250, 100),
                              //textStyle: const TextStyle(fontSize: 25),
                              backgroundColor: Color(0xFF4A6987),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                          ),
                          child: Row(
                            children: [
                              if(widget.student['text'] == 1)
                              Text(
                                'MARCAR PASO COMPLETADO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.height * 0.030
                                ),
                              ),
                              if(widget.student['text'] == 1)
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.025,
                              ),
                              checkedStep[index] ?
                                Semantics(label: 'Estado actual, paso completado', readOnly: true,
                                  child: Image.asset('assets/images/checkIcon.png',
                                      height: MediaQuery.of(context).size.height * 0.1,
                                  ),
                                ):
                                Semantics(label: 'Estado actual, paso NO completado', readOnly: true,
                                  child: Image.asset('assets/images/greyIcon.jpg',
                                    height: MediaQuery.of(context).size.height * 0.075,
                                  ),
                                ) ,
                            ],
                          ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  /// Button to go to the previous or the next step
                  Row(
                    mainAxisAlignment: index == 0
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      /// Back button
                      if (index > 0)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              index -= 1;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4A6987),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Semantics(label: 'Flecha para ir al paso anterior', readOnly: false,
                            child: Image.asset(
                                'assets/images/formerPageArrow.png',
                                width: MediaQuery.of(context).size.height * 0.1,
                            ),
                          ),
                        ),
                      /// Next button
                      if (index < numberOfSteps - 1 && checkedStep[index] == true)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              index += 1;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4A6987),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Semantics(label: 'Flecha para ir al paso siguiente', readOnly: false,
                            child: Image.asset(
                                'assets/images/nextPageArrow.png',
                                width: MediaQuery.of(context).size.height * 0.1,
                            ),
                          ),
                        ),
                      if (index == numberOfSteps-1 && checkedStep[index] == true)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FinishTask(task: task, student: widget.student)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4A6987),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            width: widget.student['text'] == 1 ? MediaQuery.of(context).size.width * 0.2 : MediaQuery.of(context).size.width * 0.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if(widget.student['text'] == 1)
                                const Text("TERMINAR",
                                  style: TextStyle(color: Colors.white),),
                                Image.asset(
                                  'assets/images/checkIcon.png',
                                  width: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
