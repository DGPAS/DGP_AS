//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'student_task.dart';

class ToDoList extends StatefulWidget {

  @override
  State<ToDoList> createState() => _ToDoListState();
  int counter = 0;
  ToDoList(int value){
    counter = value;
  }
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    double columnSpace;
    double rowSpace;
    double verticalPadding =  MediaQuery.of(context).size.height * 0.05;
    double horizontalPadding = MediaQuery.of(context).size.width * 0.05;
    double gridElementSize;
    int maximumTasks = 8;
    List<int> elements = [1, 2, 3, 4, 5, 6, 7, 8];
    int numPages = (elements.length ~/ maximumTasks) + 1;
    int currentDisplay = elements.length;
    if (currentDisplay > maximumTasks){
      currentDisplay -= maximumTasks;
    }

    if (MediaQuery.of(context).orientation == Orientation.landscape){
      columnSpace = MediaQuery.of(context).size.width * 0.1;
      rowSpace = MediaQuery.of(context).size.height * 0.05;
      gridElementSize = MediaQuery.of(context).size.height * 0.33;
    }
    else{
      columnSpace = MediaQuery.of(context).size.width * 0.1;
      rowSpace = MediaQuery.of(context).size.height * 0.05;
      gridElementSize = MediaQuery.of(context).size.height * 0.25;
    }

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
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: maximumTasks,
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
                      MaterialPageRoute(builder: (context) => StudentTask()),
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
/*
          if (elements.length > maximumTasks)
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
                      onPressed:
                      widget.counter > 1 ? () {
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
                      '${widget.counter} / ${numPages}',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    ElevatedButton(
                      onPressed: widget.counter < numPages
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
            ),*/
        ],
      ),
    );
  }
}
