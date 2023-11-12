import 'package:flutter/material.dart';
import 'student_task.dart';

class Task {
  String name;
  String imagePath;

  Task(this.name, this.imagePath);
}

class ToDoList extends StatefulWidget {
  int counter = 0;
  List<Task> tareas = [
    Task('Tarea 1', 'images/planTask.png'),
    Task('Tarea 2', 'images/microwaveTask.png'),
    Task('Tarea 3', 'images/domesticTask.png'),
    Task('Tarea 4', 'images/planTask.png'),
    Task('Tarea 5', 'images/microwaveTask.png'),
    Task('Tarea 6', 'images/domesticTask.png'),
    Task('Tarea 7', 'images/planTask.png'),
    Task('Tarea 8', 'images/microwaveTask.png'),
    Task('Tarea 9', 'images/domesticTask.png'),
    Task('Tarea 10', 'images/planTask.png'),
    Task('Tarea 11', 'images/microwaveTask.png'),
    Task('Tarea 12', 'images/domesticTask.png'),
    Task('Tarea 13', 'images/planTask.png'),
  ];
  int numTasksPerPage = 3;
  int numPages = 0;
  List<bool> isImageVisibleList = [];

  ToDoList(int value) {
    counter = value;
    numPages = (tareas.length / numTasksPerPage).ceil();
    isImageVisibleList = List.generate(tareas.length, (index) => false);
  }

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  bool isImageVisible = false;

  @override
  Widget build(BuildContext context) {
    int startIndex = (widget.counter - 1) * widget.numTasksPerPage;
    int endIndex = startIndex + widget.numTasksPerPage;
    endIndex =
        endIndex > widget.tareas.length ? widget.tareas.length : endIndex;
    List<Task> currentTasks = widget.tareas.sublist(startIndex, endIndex);
    final double buttonSize = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('images/DabilityLogo.png', width: 48, height: 48),
            const Expanded(
              child: Text(
                'AGENDA',
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              'images/agendaLogo.png',
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
                    'images/userIcon.png',
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
      body: Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.01,
            right: MediaQuery.of(context).size.width * 0.01,
            top: 25),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  for (int i = 0; i < currentTasks.length; i++)
                    Flexible(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    maximumSize: Size(
                                        MediaQuery.of(context).size.width *
                                            0.75,
                                        MediaQuery.of(context).size.height *
                                            0.40),
                                    alignment: Alignment.centerLeft,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    backgroundColor: Color(0xFF4A6987),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StudentTask()),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentTasks[i]
                                            .name, // NOMBRE DE LA TAREA
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        ),
                                      ),
                                      Image.asset(
                                        currentTasks[i].imagePath,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.20,
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(width: MediaQuery.of(context).size.width * 0.025,),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        child: Text(
                                          'Marcar como\nrealizada ',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0075,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          //primary: Color(0xFF0000),
                                          // maximumSize: Size(buttonSize, buttonSize)
                                          elevation: 0,
                                          backgroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            widget.isImageVisibleList[
                                                startIndex + i] = true;
                                          });
                                        },
                                        child: widget.isImageVisibleList[
                                                startIndex + i]
                                            ? Image.asset(
                                                'images/checkIcon.png',
                                                height: buttonSize,
                                                width: buttonSize,
                                              )
                                            : Image.asset(
                                                'images/greyIcon.jpg',
                                                height: buttonSize,
                                                width: buttonSize,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.075,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF4A6987),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: widget.counter > 1
                          ? () {
                              setState(() {
                                widget.counter -= 1;
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
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF4A6987)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'images/formerPageArrow.png',
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Text(
                      '${widget.counter} / ${widget.numPages}',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    ElevatedButton(
                      onPressed: widget.counter < widget.numPages
                          ? () {
                              setState(() {
                                widget.counter += 1;
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
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF4A6987)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'images/nextPageArrow.png',
                            width: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      /*Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  for (int i = 0; i < currentTasks.length; i++)
                    Column(
                      children: [
                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                maximumSize: Size(800, 150),
                                alignment: Alignment.centerLeft,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                primary: Color(0xFF4A6987),
                                padding: EdgeInsets.all(32.0),
                              ),
                              onPressed: () {
                                // Acción cuando se presiona el botón de la tarea
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to the left and right
                                children: [
                                  Text(
                                    currentTasks[i].name,
                                    style: const TextStyle(
                                      fontSize: 45,
                                    ),
                                  ),
                                  Image.asset(
                                    currentTasks[i].imagePath,
                                    width: 200, // Adjust the width as needed
                                    height: 200, // Adjust the height as needed
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Align(
                                  child: Text(
                                    'Marcar tarea\nrealizada',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    maximumSize: Size(85, 85),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    primary: Color(0xD9D9D9),
                                    padding: EdgeInsets.all(0),
                                  ),
                                  onPressed: () {
                                    // Acción cuando se presiona el botón "Marcar tarea realizada"
                                    setState(() {
                                      widget.isImageVisibleList[startIndex + i] = true;
                                    });
                                  },
                                  child: widget.isImageVisibleList[startIndex + i]
                                      ? Image.asset('images/checkIcon.png', fit: BoxFit.fill)
                                      : SizedBox(height: 100, width: 100),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 30), // Separación entre tareas
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 25), // Espacio entre el último botón y el rectángulo

            //Rectángulo de abajo
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color(0xFF4A6987),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: widget.counter > 1 ? () {
                          print(widget.counter);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => personalAgenda(widget.counter - 1)),
                          );
                        } : null,

                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(Color(0xFF4A6987)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('images/formerPageArrow.png'),
                          ],
                        ),
                      ),
                      SizedBox(width:50),
                      Text((widget.counter).toString() + ' / ' + widget.numPages.toString(),
                        style: const TextStyle(
                          fontSize: 45,
                        ),
                      ),
                      SizedBox(width:50),
                      ElevatedButton(
                        onPressed: widget.counter < widget.numPages ? () {
                          print(widget.counter);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => personalAgenda(widget.counter + 1)),
                          );
                        } : null,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(Color(0xFF4A6987)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('images/nextPageArrow.png'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}
