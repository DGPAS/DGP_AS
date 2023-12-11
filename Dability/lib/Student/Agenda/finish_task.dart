import 'package:flutter/material.dart';
import 'package:dability/Student/Agenda/agenda.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../Api_Requests/agenda_requests.dart';

/// # Page to see each step of a task
class FinishTask extends StatefulWidget {

  final Map<String, dynamic> task;
  final Map<String, dynamic> student;

  FinishTask ({
    Key? key,
    required this.task,
    required this.student
  }) : super(key:key);

  @override
  State<FinishTask> createState() => _FinishTaskState();
}


class _FinishTaskState extends State<FinishTask> {
  _FinishTaskState();

  String taskName = 'TAREA';
  String id = '';

  @override
  void initState () {
    super.initState();

    taskName = widget.task['taskName'];
    id = widget.task['idTask'].toString();
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
                taskName.toUpperCase(),
                textAlign: TextAlign.center,
              ),
            ),
            Image.network("${dotenv.env['API_URL']}/images/${widget.task['thumbnail'].toString()}",
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.0125,
              right: MediaQuery.of(context).size.width * 0.0125,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                /// Step description
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      "¿Has terminado la tarea?".toUpperCase(),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),

                /// Button to go to the previous or the next step
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /// Back button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4A6987),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("NO"),
                              Text(
                                'X',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    /// Yes button
                    ElevatedButton(
                      onPressed: () {
                        updateFinishedTask(id);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Agenda(student: widget.student)),
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
                        margin: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("SI"),
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
