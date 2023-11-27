import 'package:flutter/material.dart';
import 'task_steps.dart';
class StudentTask extends StatefulWidget {
  const StudentTask({super.key});

  @override
  State<StudentTask> createState() => _StudentTaskState();
}

class _StudentTaskState extends State<StudentTask> {
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset('images/DabilityLogo.png', width: 48, height: 48),
              const Expanded(
                child: Text(
                  'PONER MICROONDAS',
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
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              top: 25),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: ShapeDecoration(
                        color: Color(0xFF4A6987),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Text(
                        "Poner el \n Microondas",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: Text(
                            'Marcar como\nrealizada ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              fixedSize: Size(100, 100),
                              elevation: 0,
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                done = !done;
                              });
                            },
                            child: done
                                ? Image.asset(
                                    'images/checkIcon.png',
                                    width: 100,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Descripción',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur adipiscing elit, tristique non montes congue rhoncus Lorem ipsum dolor sit amet consectetur adipiscing elit, tristique non montes congue rhoncus orci et nam, molestie enim habitasse mus in ornare. Nascetur hendrerit interdum natoque venenatis iaculis quis praesent, commodo luctus dictum eu pellentesque in litora, lacus sodales nullam metus himenaeos vestibulum.',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.justify,
                        )
                      ])),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, //MainAxisAlignment.spaceBetween
              children: [
                Image.asset(
                  'images/tutorialVideo.png',
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      //fixedSize: Size(250, 100),
                      //minimumSize: Size(250, 50),
                      //maximumSize: Size(250, 100),
                      //textStyle: const TextStyle(fontSize: 25),
                      backgroundColor: Color(0xFF4A6987),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaskSteps(0, 3, List.generate(3, (index) => false))),
                    );
                  },
                  child:
                    Column(
                      children: [
                        Text(
                          'VER\nPASOS',
                          textAlign: TextAlign.center,
                          style:
                            TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                        ),

                        Image.asset(
                          'images/taskImage.png',
                        ),
                      ],
                    )

                ),
              ],
            )
          ]),
        ));
  }
}
