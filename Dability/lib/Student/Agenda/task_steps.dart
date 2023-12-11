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
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            /// Task title on AppBar
            Expanded(
              child: Text(
                task['taskName'].toString().toUpperCase(),
                textAlign: TextAlign.center,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network("${dotenv.env['API_URL']}/images/steps/${steps[index].image.toString()}",
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.75,
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
                      Text(
                        steps[index].description.toString().toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.025,
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
                              Text(
                                'MARCAR PASO COMPLETADO',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.030
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.025,
                              ),
                              checkedStep[index] ?
                                Image.asset('assets/images/checkIcon.png',
                                    height: MediaQuery.of(context).size.height * 0.075,
                                ):
                                Image.asset('assets/images/greyIcon.jpg',
                                  height: MediaQuery.of(context).size.height * 0.075,
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
                          child: Image.asset(
                              'assets/images/formerPageArrow.png',
                              width: MediaQuery.of(context).size.height * 0.1,
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
                          child: Image.asset(
                              'assets/images/nextPageArrow.png',
                              width: MediaQuery.of(context).size.height * 0.1,
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
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("TERMINAR"),
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
