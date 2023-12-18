import 'package:dability/Api_Requests/student_requests.dart';
import 'package:dability/dability.dart';
import 'package:flutter/material.dart';
import 'Agenda/agenda.dart';

/// # Home page of Student
class StudentHome extends StatefulWidget {
  final String idStudent;

  const StudentHome({Key? key, required this.idStudent});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  Map<String,dynamic> student = {};
  String name = 'ALUMNO';

  _StudentHomeState();

  /// Init state
  @override
  void initState() {
    super.initState();

    getData();
  }

  /// Function that calls [getStudentById] who returns the DataBase student
  /// with id [widget.idStudent] and adds them to [student]
  Future<void> getData () async {
    Map<String,dynamic> aux = await getStudentById(widget.idStudent);

    setState(() {
      student = aux;
      name = student['firstName'].toString().toUpperCase();
    });
  }

  /// Function that returns the title of [AppBar]
  ///
  /// If [typeForm] == [AddModType.add], it updates it to creating a task
  ///
  /// If [typeForm] == [AddModType.mod], it updates it to modifying a task
  String _getTitle () {
      return 'INICIO $name';
  }

  /// Main builder of the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            Expanded(
              child: Text(
                _getTitle(),
                textAlign: TextAlign.center, // Centra el texto
                style: TextStyle(color: Colors.white),
              ),
            ),
            Image.asset('assets/images/currentPageIcon.png', width: 46, height: 46),
            SizedBox(
              width: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A6987),
                  elevation: 0, // Elimina la sombra
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(0), // Elimina los bordes
                  )),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/userIcon.png', width: 48, height: 48),
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
                  DAbility()),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          /// Button to access [to_do_list.dart]
          Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  maximumSize: Size(double.infinity, double.infinity),
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30.0),
                  ),
                  backgroundColor: Color(0xFF4A6987),
                  padding: EdgeInsets.all(40),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Agenda(student: student)),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(student['text'] == 1)
                    Text(
                      'AGENDA PERSONAL',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    Image.asset(
                      'assets/images/agendaLogo.png',
                      width: student['text'] == 1 ? MediaQuery.of(context).size.width * 0.15 : MediaQuery.of(context).size.width * 0.2,
                    ),
                  ],
                ),
              )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0xFF4A6987), // Color del rectángulo
                height: MediaQuery.of(context).size.height * 0.075,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
