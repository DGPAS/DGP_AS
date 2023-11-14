import 'package:flutter/material.dart';
import 'package:dability/admin_home.dart';
import 'student_home.dart';

void main() {
  runApp(const DAbility());
}

// TODOLIST
// TODO: AGREGAR TABLAS TAREASASIGNADAS
//    Contiene idAgenda, idTarea, realizada, fechaIni, fechaFin
// TODO: REALIZAR INSERCION DE TAREAS EN AGENDAS
// TODO: VISUALIZAR AGENDAS CON TAREAS
// TODO: CREAR ALUMNOS
// TODO: INSERTAR ALUMNOS
// TODO: MODIFICAR ALUMNOS Y LISTA DE TAREAS DE ALUMNOS
// TODO: ELIMINAR ALUMNOS



class DAbility extends StatelessWidget {
  const DAbility({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //MaterialApp means the app follows material pattern by google
      title: 'D-Ability',
      // Elimina la etiqueta de debug
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'D-Ability'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.0, 1.5),
          radius: 3,
          colors: [Color(0xFF4A6987), Colors.white],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(40.0),
              child: Image.asset('images/Logo.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.8),
            ),
            Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Soluciones de accesibilidad para la independencia y facilidad de todos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4A6987),
                    fontSize: 30.0, //MediaQuery.of(context).size.height * 0.03,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        fixedSize: Size(250, 100),
                        textStyle: const TextStyle(fontSize: 25),
                        backgroundColor: Color(0xFF4A6987),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminHome()),
                      );
                    },
                    child: const Text(
                      'Acceder como Administrador',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        fixedSize: Size(250, 100),
                        textStyle: const TextStyle(fontSize: 25),
                        backgroundColor: Color(0xFF4A6987),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentHome()),
                      );
                    },
                    child: const Text(
                      'Acceder como Alumno',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
