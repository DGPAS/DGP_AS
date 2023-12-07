import 'package:flutter/material.dart';
import 'student_task.dart';

/// Auxiliary class while it is on local
  class Task {
  String name;
  String imagePath;
  int id;

  Task(this.name, this.imagePath, this.id);
}

/// # Page where the student sees his/her tasks
class Agenda extends StatefulWidget {

  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  _AgendaState();

  /// Variable to show [numTasksPerPage] tasks on each page
  final int numTasksPerPage = 3;
  int numPages = 0;
  bool isImageVisible = false;
  int counter = 1;

  /// Obtain it from DataBase
  final List<Task> tasks = [
    Task('Tarea 1', 'assets/images/planTask.png', 1),
    Task('Tarea 2', 'assets/images/microwaveTask.png', 2),
    Task('Tarea 3', 'assets/images/domesticTask.png', 3),
    Task('Tarea 4', 'assets/images/planTask.png', 4),
    Task('Tarea 5', 'assets/images/microwaveTask.png', 5),
    Task('Tarea 6', 'assets/images/domesticTask.png', 6),
    Task('Tarea 7', 'assets/images/planTask.png', 7),
    Task('Tarea 8', 'assets/images/microwaveTask.png', 8),
    Task('Tarea 9', 'assets/images/domesticTask.png', 9),
    Task('Tarea 10', 'assets/images/planTask.png', 10),
    Task('Tarea 11', 'assets/images/microwaveTask.png', 11),
    Task('Tarea 12', 'assets/images/domesticTask.png', 12),
    Task('Tarea 13', 'assets/images/planTask.png', 13),
  ];

  @override
  void initState () {
    super.initState();

    numPages = (tasks.length / numTasksPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    int startIndex = (counter - 1) * numTasksPerPage;
    int endIndex = startIndex + numTasksPerPage;
    endIndex =
    endIndex > tasks.length ? tasks.length : endIndex;
    List<Task> currentTasks = tasks.sublist(startIndex, endIndex);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            const Expanded(
              child: Text(
                'AGENDA',
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              'assets/images/agendaLogo.png',
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
      body: Stack(
        children: [
          Padding(padding:
            EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.01,
                right: MediaQuery.of(context).size.width * 0.01,
                top:  MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.01
            ),
            child: Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < currentTasks.length; i++)
                    Flexible(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20,
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    maximumSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.40),
                                    alignment: Alignment.centerLeft,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    backgroundColor: Color(0xFF4A6987),
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.40 * 0.05,
                                      bottom: MediaQuery.of(context).size.height * 0.40 * 0.05,
                                      left: MediaQuery.of(context).size.width * 0.01,
                                      right: MediaQuery.of(context).size.width * 0.01,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StudentTask(taskID: currentTasks[i].id)),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentTasks[i].name, // NOMBRE DE LA TAREA
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.05,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.075,
                                      ),
                                      Image.asset(
                                        currentTasks[i].imagePath,
                                        width: MediaQuery.of(context).size.height * 0.20,
                                        height: MediaQuery.of(context).size.height * 0.20,
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(width: MediaQuery.of(context).size.width * 0.025,),
                              ],
                            ),
                          ),
                          // SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: counter == 1
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.spaceBetween,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (counter > 1)
                        ElevatedButton(
                          onPressed: counter > 1
                              ? () {
                            setState(() {
                              counter -= 1;
                            });
                            //Navigator.push(
                            //context,
                            //MaterialPageRoute(builder: (context) => personalAgenda(widget.counter - 1)),
                            //);
                          }
                              : null,
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            backgroundColor:
                            MaterialStateProperty.all(Color(0xFF4A6987)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/formerPageArrow.png',
                                width: MediaQuery.of(context).size.height * 0.1,
                              ),
                            ],
                          ),
                        ),
                      /*SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Text(
                    '${widget.counter} / ${widget.numPages}',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),*/
                      if (counter < numPages)
                        ElevatedButton(
                          onPressed: counter < numPages
                              ? () {
                            setState(() {
                              counter += 1;
                            });
                            /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => personalAgenda(widget.counter + 1)),
                        );*/
                          }
                              : null,
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            backgroundColor:
                            MaterialStateProperty.all(Color(0xFF4A6987)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/nextPageArrow.png',
                                width: MediaQuery.of(context).size.height * 0.1,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
