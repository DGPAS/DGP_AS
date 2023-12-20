import 'package:dability/Teacher/Educator/myStudents/my_students.dart';
import 'package:flutter/material.dart';
import 'package:dability/dability.dart';

/// # Home page of Educator
class EducatorHome extends StatefulWidget {
  const EducatorHome({super.key});

  @override
  State<EducatorHome> createState() => _EducatorHomeState();
}

class _EducatorHomeState extends State<EducatorHome> {

  /// Main builder of the page
  ///
  /// It contains an appBar and two buttons in a Column
  /// One goes to student management and the other to task management
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            Expanded(
              child: Text(
                'INICIO EDUCADOR',
                textAlign: TextAlign.center, // Centra el texto
                style: TextStyle(color: Colors.white),
              ),
            ),
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
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Utiliza la función personalizada para manejar la navegación hacia atrás
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
          /// Button that navigates to [student_management.dart]
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyStudents()),
                );
              },
              child: Text(
                'ESTADÍSTICAS ESTUDIANTES',
                textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Predefined style for buttons
  final ButtonStyle style = ElevatedButton.styleFrom(
    minimumSize: Size(400, 120),
    textStyle: const TextStyle(
      fontSize: 30,
      color: Colors.black,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    backgroundColor: Color(0xFF4A6987),
    padding: EdgeInsets.symmetric(horizontal: 40),
  );
}
