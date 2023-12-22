import 'package:dability/Student/Login/student_pictologin.dart';
import 'package:flutter/material.dart';

/// # Page to list all the students
///
/// It shows the photo of the students to select one and access to his
/// pictologin
class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {

  List<String> students = []; // lista de estudiantes

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
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            const Expanded(
              child: Text(
                'Login Student',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(20),
        /// It builds all the students list
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Column number
            crossAxisSpacing: 8.0, // Horizontal gap in grid
            mainAxisSpacing: 8.0, // Vertical gap in grid
          ),
          itemCount: 6, // Total number of Students on grid (3 rows x 2 columns = 6 elements)
          itemBuilder: (context, int index) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFF4A6987)
              ),
              // color: Colors.blue,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4A6987),
                    elevation: 0
                ),
                onPressed: () {
                  /// On pressed, it goes to the [student_pictologin.dart]
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentPictoLogin(id_student: 23)), /// Pasar el id del alumno correspondiente o un Map<String, dynamic> student completo
                  );
                },
                child: Column(
                    children: [
                      Image.asset(
                        'assets/images/student_image.png',
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.width * 0.35,
                      ),
                      Text(
                        students[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ]
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


