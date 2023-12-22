import 'dart:convert';

import 'package:dability/Teacher/Admin/admin_home.dart';
import 'package:dability/Teacher/Educator/educator_home.dart';
import 'package:flutter/material.dart';
import 'package:dability/Api_Requests/user_requests.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool loginError = false;
  List<dynamic> adminsList = [];
  List<dynamic> admins = [];
  List<dynamic> teachersList = [];
  List<dynamic> teachers = [];

  @override
  void initState(){
    super.initState();
    getData();
  }

  Future<void> getData () async {
    adminsList = await getAdminsLogins();
    setState(() {
      admins = adminsList;
    });

    teachersList = await getTeachersLogins();
    setState(() {
      teachers = teachersList;
    });
  }

  int authenticateUser(String email, String password, List<dynamic> admins, List<dynamic> teachers) {
    for (var i = 0; i < admins.length; i++) {
      if (admins[i]['login'] == email && admins[i]['password'] == password) {
        return 0;
      }
      if (teachers[i]['login'] == email && teachers[i]['password'] == password) {
        return 1;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.jpeg', width: 48, height: 48),
            const Expanded(
              child: Text(
                'Login Admin',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFF4A6987)
              ),
              child: Text(
                'ACCESO ADMINISTRADORES Y EDUCADORES',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container( // antes padding
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.6
                    constraints: BoxConstraints(
                      maxWidth: 800.0, // Establece el ancho máximo del contenedor
                      // maxHeight: 0.0, // Establece la altura máxima del contenedor
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, introduce tu email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 800.0, // Establece el ancho máximo del contenedor
                      // maxHeight: 0.0, // Establece la altura máxima del contenedor
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Contraseña'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, introduce tu contraseña';
                        }
                        // else if(loginError){
                        //   return 'Email y/o contraseña incorrectos';
                        // }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30.0),

                  if (loginError)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Email y/o contraseña incorrectos',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color(0xFF4A6987),
                        // padding: EdgeInsets.symmetric(horizontal: 100),
                        minimumSize: Size(180, 60)
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        int loginCorrecto = authenticateUser(
                            _emailController.text, _passwordController.text, adminsList, teachersList);

                        if(loginCorrecto == 0 || loginCorrecto == 1){
                          setState(() {
                            loginError = false;
                          });
                        }
                        else{
                          setState(() {
                            loginError = true;
                          });
                        }


                        if(loginCorrecto == 0){ // se redirecciona
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdminHome()),
                          );
                        }
                        else if(loginCorrecto == 1){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EducatorHome()),
                          );
                        }
                      }
                    },
                    child: Text(
                      'ACCEDER',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text('¿No tienes cuenta?'),
                        SizedBox(width: 12,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4A6987),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => SignUpPage()),
                              // );
                            },
                            child: Text(
                              'Registrate',
                              style: TextStyle(color: Colors.white),
                            )
                        )
                      ]
                  ),
                  // Text('¿No tienes cuenta? Regístrate')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}