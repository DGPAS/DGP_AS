import 'package:flutter/material.dart';

/// # Page where admin manages students
class StudentStatistics extends StatefulWidget {

  final Map<String, dynamic> student;

  const StudentStatistics({
    Key? key,
    required this.student
  }): super(key:key);

  @override
  State<StudentStatistics> createState() => _StudentStatisticsState();
}

class _StudentStatisticsState extends State<StudentStatistics> {

  Map<String, dynamic> student = {};

  @override
  void initState () {
    student = widget.student;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            Expanded(
              child: Text(
                "ESTADISTICAS ALUMNO",
                textAlign: TextAlign.center,
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
        backgroundColor: Color(0xFF4A6987),
      ),
      body: const Text("En desarrollo"),  // TODO: Filtro de tareas del alumno y checkbox de realizadas-noRealizadas
    );
  }
}