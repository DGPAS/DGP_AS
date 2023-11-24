import 'package:flutter/material.dart';
import 'task_management.dart';
import 'student_management.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Student'),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

          )
        ],
      ),
    );
  }
}
