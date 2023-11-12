import 'package:flutter/material.dart';
import 'task_management.dart';
import 'student_management.dart';

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
        title: Text('Inicio Admin'),
        backgroundColor: Color(0xFF4A6987),
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
                'GESTIONAR ALUMNOS',
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
