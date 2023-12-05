import 'package:flutter/material.dart';
import 'student_task.dart';

//Modificar según sea necesario
class Task {
  String name;
  String imagePath;
  int id;

  Task(this.name, this.imagePath, this.id);
}

class ToDoList extends StatefulWidget {
  int counter = 0;
  //Obtener de la BD
  List<Task> tasks = [
    Task('Tarea 1', 'images/planTask.png', 1),
    Task('Tarea 2', 'images/microwaveTask.png', 2),
    Task('Tarea 3', 'images/domesticTask.png', 3),
    Task('Tarea 4', 'images/planTask.png', 4),
    Task('Tarea 5', 'images/microwaveTask.png', 5),
    Task('Tarea 6', 'images/domesticTask.png', 6),
    Task('Tarea 7', 'images/planTask.png', 7),
    Task('Tarea 8', 'images/microwaveTask.png', 8),
    Task('Tarea 9', 'images/domesticTask.png', 9),
    Task('Tarea 10', 'images/planTask.png', 10),
    Task('Tarea 11', 'images/microwaveTask.png', 11),
    Task('Tarea 12', 'images/domesticTask.png', 12),
    Task('Tarea 13', 'images/planTask.png', 13),
  ];
  int numTasksPerPage = 3;
  int numPages = 0;
  List<bool> isImageVisibleList = [];

  ToDoList(int value) {
    counter = value;
    numPages = (tasks.length / numTasksPerPage).ceil();
    isImageVisibleList = List.generate(tasks.length, (index) => false);
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
    endIndex > widget.tasks.length ? widget.tasks.length : endIndex;
    List<Task> currentTasks = widget.tasks.sublist(startIndex, endIndex);
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
        child: Stack(
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
                                            builder: (context) => StudentTask(currentTasks[i].id)),
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
                      mainAxisAlignment: widget.counter == 1
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.spaceBetween,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.counter > 1)
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
                                  'images/formerPageArrow.png',
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
                        if (widget.counter < widget.numPages)
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
                                  'images/nextPageArrow.png',
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
      /*body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: taskQuantity,
              padding: EdgeInsets.only(top: verticalPadding, left: horizontalPadding, right: horizontalPadding),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: gridElementSize, // Tamaño máximo deseado para cada elemento
                crossAxisSpacing: columnSpace, // Espaciado entre columnas
                mainAxisSpacing: rowSpace, // Espaciado entre filas
                childAspectRatio: 1.0, // Relación de aspecto para mantener la forma cuadrada
              ),
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentTask(0)),    //Pasar el ID de la tarea en la BD
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: Color(0xFF4A6987),
                  ),
                  child: Image.asset(
                    'images/microwaveTask.png',
                  ),
                );
              },
            ),
          ),
        ],
      ),*/
    );
  }
}
