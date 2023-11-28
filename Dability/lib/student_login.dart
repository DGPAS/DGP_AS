import 'package:dability/student_pictologin.dart';
import 'package:flutter/material.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {

  List<String> students = []; // lista de tareas

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
            Image.asset('images/DabilityLogo.png', width: 48, height: 48),
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
                    'images/userIcon.png',
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
          itemCount: 6, // Número total de elementos en el grid (3 filas x 2 columnas = 6 elementos)
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
                  // llevarte al alumno seleccionado
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentPictoLogin(id_alumno: index)),
                  );
                },
                child: Column(
                  children: [
                    Image.asset(
                      'images/student_image.png',
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


