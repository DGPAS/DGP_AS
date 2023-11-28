import 'package:flutter/material.dart';
import 'task_management.dart';
import 'student_management.dart';
import 'dability.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('images/DabilityLogo.png', width: 48, height: 48),
            Expanded(
              child: Text(
                'Inicio Admin',
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
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentManagement()),
                );
              },
              child: Text(
                'GESTIONAR ESTUDIANTES',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskManagement()),
                );
              },
              child: Text(
                'GESTIONAR TAREAS',
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
