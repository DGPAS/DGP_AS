import 'package:dability/Student/student_home.dart';
import 'package:flutter/material.dart';
import '../../Api_Requests/agenda_requests.dart';
import 'student_task.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


/// # Page where the student sees his/her tasks
class Agenda extends StatefulWidget {

    final Map<String, dynamic> student;

  const Agenda({Key? key, required this.student});

  @override
    State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  _AgendaState();

  Map<String, dynamic> student = {};
  List<dynamic> tasks = [];
  List<dynamic> currentTasks = [];

  /// Variable to show [numTasksPerPage] tasks on each page
  final int numTasksPerPage = 3;
  int numPages = 0;
  bool isImageVisible = false;
  int counter = 1;

  @override
  void initState () {
    super.initState();

    student = widget.student;

    getData(student['id'].toString());

    print(student['text']);
  }

  /// Function that calls [getStudentAgenda] who returns the DataBase student
  /// tasks where idStudent is [id] and adds them to [tasks]
  Future<void> getData (String id) async {
    List<dynamic> aux = await getStudentAgenda(id);
    setState(() {
      tasks = aux;
      numPages = (tasks.length / numTasksPerPage).ceil();
    });
  }

  /// Function thats return the orientation of the device
  Orientation _orientation (double width, double height) {
    return width > height ? Orientation.landscape : Orientation.portrait;
  }

  @override
  Widget build(BuildContext context) {
    int startIndex = (counter - 1) * numTasksPerPage;
    int endIndex = startIndex + numTasksPerPage;
    endIndex = endIndex > tasks.length ? tasks.length : endIndex;
    setState(() {
      currentTasks = tasks.sublist(startIndex, endIndex);
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            Expanded(
              child: Text(
              student['text'] == 1 ? 'AGENDA' : "",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  StudentHome(idStudent: student['id'].toString())),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(padding:
            EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.01,
                right: MediaQuery.of(context).size.width * 0.01,
                top:  MediaQuery.of(context).size.height * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.01
            ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < currentTasks.length; i++)
                    Flexible(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.22,
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Container for each task
                                SizedBox(
                                  width: student['text'] == 1 ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.4,
                                  child: ElevatedButton(
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
                                            builder: (context) => StudentTask(task: currentTasks[i], student: student)),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 15, right: 15),
                                      child: Row(
                                          mainAxisAlignment: student['text'] == 1 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                                          children: [
                                            /// Task name
                                            if (student['text'] == 1)
                                            Text(
                                              currentTasks[i]['taskName'].toString().toUpperCase(),
                                              style: TextStyle(
                                                fontSize: _orientation(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) == Orientation.landscape
                                                    ? MediaQuery.of(context).size.width *0.04   /// landscape
                                                    : MediaQuery.of(context).size.width *0.04,  /// portrait
                                              ),
                                            ),
                                            if (student['text'] == 1)
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.075,
                                            ),
                                            Container(
                                              width: _orientation(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) == Orientation.landscape
                                                ? MediaQuery.of(context).size.width *0.20     /// landscape
                                                : MediaQuery.of(context).size.width *0.20,    /// portrait
                                              height: _orientation(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) == Orientation.landscape
                                                ? MediaQuery.of(context).size.height *0.20     /// landscape
                                                : MediaQuery.of(context).size.height *0.17,    /// portrait
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Image.network("${dotenv.env['API_URL']}/images/${currentTasks[i]['thumbnail'].toString()}",
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ],
                                        ),
                                    ),
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
        ],
      ),
    );
  }
}
