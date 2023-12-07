import 'package:flutter/material.dart';

/// # Page to see each step of a task
class TaskSteps extends StatefulWidget {

  final int index;
  final int numberOfSteps;
  final List<bool> checkedStep;

  TaskSteps({
    required this.index,
    required this.numberOfSteps,
    required this.checkedStep,
  });

  @override
  State<TaskSteps> createState() => _TaskStepsState();
}


class _TaskStepsState extends State<TaskSteps> {
  _TaskStepsState();

  int index = 0;
  int numberOfSteps = 0;
  List<bool> checkedStep = [];
  bool isImageVisible = false;

  @override
  void initState () {
    super.initState();

    index = widget.index;
    numberOfSteps = widget.numberOfSteps;
    checkedStep = widget.checkedStep;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            /// Task title on AppBar
            const Expanded(
              child: Text(
                'TAREA',
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  /// Step Task Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/pruebaPaso.png',
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
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consequat in nunc id pharetra. '
                          'Phasellus et gravida risus, vel pulvinar tortor. Proin dictum, dolor vel volutpat lacinia, '
                          'velit turpis cursus orci, et dictum erat est et quam. Sed sed arcu ut libero vulputate '
                          'suscipit quis ultricies magna. In ut vestibulum turpis'.toUpperCase(),
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
                                'Paso completado',
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

                        //  child: checkedStep[index] ?
                          //Image.asset('assets/images/checkIcon.png'):
                          //Image.asset('assets/images/greyIcon.jpg') ,
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
                      if (index < numberOfSteps - 1)
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
