import 'package:flutter/material.dart';


class TaskSteps extends StatefulWidget {

  @override
  State<TaskSteps> createState() => _TaskStepsState();
  int index = 0, numberOfSteps = 0;
  TaskSteps(int initialPage, int stepsQuantity){
    index = initialPage;
    numberOfSteps = stepsQuantity;
  }
}


class _TaskStepsState extends State<TaskSteps> {
  bool isImageVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('images/DabilityLogo.png', width: 48, height: 48),
            const Expanded(
              child: Text(
                'TAREA',
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
      body:
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.025,
                left: MediaQuery.of(context).size.width * 0.0125,
                right: MediaQuery.of(context).size.width * 0.0125,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Color(0xFFD9D9D9),
                        child: SizedBox(
                          width: 80,
                          height: 160,
                          child: Image.asset('images/1.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: widget.index == 0
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.index > 0)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.index -= 1;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4A6987),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Image.asset('images/formerPageArrow.png'),
                        ),
                      if (widget.index < widget.numberOfSteps - 1)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.index += 1;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4A6987),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Image.asset('images/nextPageArrow.png'),
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
