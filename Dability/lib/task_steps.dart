import 'package:flutter/material.dart';


class TaskSteps extends StatefulWidget {

  @override
  State<TaskSteps> createState() => _TaskStepsState();
  int index = 0, numberOfSteps = 0;
  List<bool> checkedStep = List.generate(0, (index) => false);
  TaskSteps(int initialPage, int stepsQuantity, List<bool> checks){
    index = initialPage;
    numberOfSteps = stepsQuantity;
    checkedStep = checks;
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.checkedStep[widget.index] = !widget.checkedStep[widget.index];
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
                              Text('Paso completado'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.025,
                              ),
                              widget.checkedStep[widget.index] ?
                                Image.asset('images/checkIcon.png',
                                    height: MediaQuery.of(context).size.height * 0.125,
                                ):
                                Image.asset('images/greyIcon.jpg',
                                  height: MediaQuery.of(context).size.height * 0.125,
                                ) ,
                            ],
                          ),

                        //  child: widget.checkedStep[widget.index] ?
                          //Image.asset('images/checkIcon.png'):
                          //Image.asset('images/greyIcon.jpg') ,
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
