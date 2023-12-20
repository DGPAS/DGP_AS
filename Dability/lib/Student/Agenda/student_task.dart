import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../Api_Requests/steps_requests.dart';
import '../../Components/list_step.dart';
import 'task_steps.dart';

/// # Page to show a task
class StudentTask extends StatefulWidget {
  StudentTask({
    Key? key,
    required this.task,
    required this.student
  }) : super(key:key);

  final Map<String, dynamic> task;
  final Map<String, dynamic> student;

  @override
  State<StudentTask> createState() => _StudentTaskState();
}

class _StudentTaskState extends State<StudentTask> {
  bool done = false;

  Map<String, dynamic> task = {};
  List<ListStep> steps = [];

  /// Init state to initialize the variables
  @override
  void initState() {
    super.initState();

    task = widget.task;

    getData(task['idTask'].toString());
  }

  /// Function that calls [getTaskSteps] who returns the DataBase task
  /// steps where idTask is [id] and adds them to [steps]
  Future<void> getData (String id) async {
    List<ListStep> aux = await getTaskSteps(id);
    setState(() {
      steps = aux;
    });
  }

  /// Function thats return the orientation of the device
  Orientation _orientation (double width, double height) {
    return width > height ? Orientation.landscape : Orientation.portrait;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Semantics(label: 'Logo de la aplicación', readOnly: true,
                child: Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),),
              Expanded(
                /// Task title on AppBar
                child: Semantics(label: 'Estás en, ', readOnly: true,
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
            icon: Semantics(label: 'Atrás para ir a agenda', readOnly: false,
                child: Icon(Icons.arrow_back, color: Colors.white,)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color(0xFF4A6987),
        ),
        body: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.015,
              bottom: MediaQuery.of(context).size.height * 0.015
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Task title Box
                  Semantics(label: 'Título de la tarea, ', readOnly: true,
                    child: Container(
                        width: widget.student['text'] == 1 ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          //color: Color(0xFF4A6987),
                          color: Color(0xFFD9D9D9),
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
                        child: Row(
                          mainAxisAlignment: widget.student['text'] == 1 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                          children: [
                            if (widget.student['text'] == 1)
                            Text(
                              task['taskName'].toString().toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // color: Colors.white,
                                   color: Colors.black,
                                fontSize: _orientation(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) == Orientation.landscape
                                    ? MediaQuery.of(context).size.width *0.03     /// landscape
                                    : MediaQuery.of(context).size.width *0.035,    /// portrait
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                            Container(
                              width: _orientation(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) == Orientation.landscape
                                  ? MediaQuery.of(context).size.width *0.20     /// landscape
                                  : MediaQuery.of(context).size.width *0.15,    /// portrait
                              height: _orientation(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) == Orientation.landscape
                                  ? MediaQuery.of(context).size.height *0.20     /// landscape
                                  : MediaQuery.of(context).size.height *0.15,    /// portrait
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Semantics(label: '', readOnly: true,
                                child: Image.network("${dotenv.env['API_URL']}/images/${task['thumbnail'].toString()}",
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
            /// Container for description task
              if (widget.student['text'] == 1)
            Semantics(label: 'Descripción general de la tarea ', readOnly: true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DESCRIPCIÓN',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            task['description'].toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.02,
                            ),
                            textAlign: TextAlign.justify,
                          )
                        ])),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// Tutorial video task
                if (task['video'] != "" && task['video'] != null && widget.student['video'] == 1)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.student['text'] == 1 ? 'TUTORIAL' : "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                      //Aquí iría el vídeo
                    ],
                  ),
                /// Button to access to [task_steps.dart]
                if (steps.isNotEmpty)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.30 * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.30 * 0.05,
                        left: MediaQuery.of(context).size.width * 0.25 * 0.05,
                        right: MediaQuery.of(context).size.width * 0.25 * 0.05,
                      ),
                      //fixedSize: Size(250, 100),
                      //minimumSize: Size(250, 50),
                      //maximumSize: Size(250, 100),
                      //textStyle: const TextStyle(fontSize: 25),
                      maximumSize: Size(MediaQuery.of(context).size.width * 0.25, MediaQuery.of(context).size.height * 0.30),
                      backgroundColor: Color(0xFF4A6987),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskSteps(steps: steps, task: task, student: widget.student)),
                    );
                  },
                  child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.student['text'] == 1 ? 'VER PASOS' : "",
                          textAlign: TextAlign.center,
                          style:
                            TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                        ),

                        Image.asset(
                          'assets/images/instrucciones.png',
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: MediaQuery.of(context).size.height * 0.20,
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
