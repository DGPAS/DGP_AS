import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Teacher/Educator/educator_home.dart';
import 'Teacher/login/teacher_login.dart';
import 'Student/Login/student_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  /// Loads the environment variables from .env
  await dotenv.load();
  runApp(const DAbility());
} 

class DAbility extends StatelessWidget {
  const DAbility({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D-Ability',
      // Remove the debug tag
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme(
            brightness:  Brightness.light,
            primary: Colors.white,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.red,
            background: Colors.white,
            onBackground:  Colors.black,
            surface:  Colors.white,
            onSurface: Colors.black),
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

///  Main Page
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
            /// Logo
            Container(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'assets/images/Logo.png',
                  height: 100,
                )),
            /// Slogan
            Text(
              "Soluciones de accesibilidad para la independencia y facilidad de todos",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4A6987),
                fontSize: 20.0, //MediaQuery.of(context).size.height * 0.03,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// Button to access as administrator
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        //fixedSize: Size(250, 100),
                        minimumSize: Size(250, 50),
                        maximumSize: Size(250, 100),
                        //textStyle: const TextStyle(fontSize: 25),
                        backgroundColor: Color(0xFF4A6987),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AdminLogin()),
                      );
                    },
                    child: const Text(
                      'Acceso para profesorado',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                /// Button to access as student
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        //fixedSize: Size(250, 100),
                        minimumSize: Size(250, 50),
                        maximumSize: Size(250, 100),
                        //textStyle: const TextStyle(fontSize: 25),
                        backgroundColor: Color(0xFF4A6987),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudentLogin()),
                      );
                    },
                    child: const Text(
                      'Acceder como Estudiante',
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
