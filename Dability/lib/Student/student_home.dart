import 'package:dability/dability.dart';
import 'package:flutter/material.dart';
import 'Agenda/agenda.dart';

/// # Home page of Student
class StudentHome extends StatefulWidget {
  final int idStudent;

  const StudentHome({Key? key, required this.idStudent}); // deberia recibir el id del alumno

  @override
  State<StudentHome> createState() =>
      _StudentHomeState(idStudent: this.idStudent);
}

class _StudentHomeState extends State<StudentHome> {
  final int idStudent;

  _StudentHomeState({required this.idStudent});


  /// Data example pre-DataBase
  String student = "JUAN";
  List<String> students = [];

  /// Init state
  @override
  void initState() {
    super.initState();
    setState(() {
      students.add("JOAQUIN");
      students.add("MANUEL");
      students.add("SARA");
      students.add("RUBEN");
      students.add("JUAN");
      students.add("ALICIA");

      student = students[idStudent];
    });
  }

  /// Main builder of the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('images/DabilityLogo.png', width: 48, height: 48),
            Expanded(
              child: Text(
                'INICIO ' + student,
                textAlign: TextAlign.center, // Centra el texto
              ),
            ),
            Image.asset('images/currentPageIcon.png', width: 46, height: 46),
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
                  Image.asset('images/userIcon.png', width: 48, height: 48),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF4A6987),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                    MaterialPageRoute(builder: (context) => ToDoList(1)),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                      'images/agendaLogo.png',
                      width: MediaQuery.of(context).size.width * 0.1,
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
