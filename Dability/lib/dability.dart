import 'package:dability/inicio_admin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DAbility());
}

class DAbility extends StatelessWidget {
  const DAbility({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Material es una app que sigue el patron material de google
      title: 'D-Ability',
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
                        MaterialPageRoute(builder: (context) => InicioAdmin()),
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
                    onPressed: () {},
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
