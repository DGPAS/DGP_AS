import 'dart:convert';

import 'package:dability/Student/Login/student_pictologin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {

  List<dynamic> students = [];
  List<dynamic> stds = [];

  Future<void> getAlumnos() async{
    String uri = "${dotenv.env['API_URL']}/view_students.php";
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          stds = json.decode(response.body);
        });
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getData() async{
    await getAlumnos();
    students.addAll(stds);
  }

  @override
  void initState() {
    super.initState();
    print("init");
    getData();
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
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Número de columnas
            crossAxisSpacing: 8.0, // Espaciado horizontal entre los elementos del grid
            mainAxisSpacing: 8.0, // Espaciado vertical entre los elementos del grid
          ),
          itemCount: students.length, // Número total de elementos en el grid (3 filas x 2 columnas = 6 elementos)
          itemBuilder: (context, int index) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFF4A6987)
              ),
              // color: Colors.blue, // Puedes cambiar el color según tus necesidades
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF4A6987), // Establece el color de fondo del botón como transparente
                    elevation: 0
                ),
                onPressed: () {
                  print(int.parse(students[index]["id"]));
                  // llevarte al alumno seleccionado
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (context) => StudentPictoLogin(id_alumno: int.parse(students[index]["id"]))),
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
                        students[index]['firstName'],
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


