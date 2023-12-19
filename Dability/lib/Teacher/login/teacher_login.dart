import 'package:dability/Teacher/Admin/admin_home.dart';
import 'package:dability/Teacher/Educator/educator_home.dart';
import 'package:flutter/material.dart';

/// # Login page for Admin
class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  /// Example credentials
  String userEmail = "prueba@correo.es";
  String userPassword = "123";
  String educatorEmail = "educador@correo.es";
  String educatorPassword = "123";

  bool loginError = false;

  /// Function that checks if [email] and [password] are identical
  /// to [userEmail] and [userPassword] or to [educatorEmail] and [educatorPassword]
  ///
  /// If they are, it returns 1 or 2
  ///
  /// Else, it returns 0
  int authenticateUser(String email, String password){
    int rol = 0;
    if(email == userEmail && password == userPassword){
      rol = 1;
    }
    else if (email == educatorEmail && password == educatorPassword) {
      rol = 2;
    }

    return rol;
  }

  /// Main builder for the login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            const Expanded(
              child: Text(
                'Login Admin',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Title of the login
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
                  /// Label for email
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.6
                    constraints: BoxConstraints(
                      maxWidth: 800.0, // Establece el ancho máximo del contenedor
                      // maxHeight: 0.0, // Establece la altura máxima del contenedor
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.black)),
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, introduce tu email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  /// Label for the password
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 800.0, // Establece el ancho máximo del contenedor
                      // maxHeight: 0.0, // Establece la altura máxima del contenedor
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Contraseña', labelStyle: TextStyle(color: Colors.black)),
                      style: TextStyle(color: Colors.black),
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

                  /// Handler error controller
                  if (loginError)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Email y/o contraseña incorrectos',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                  /// Submit access button
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
                        int rol = authenticateUser(
                            _emailController.text, _passwordController.text);

                        setState(() {
                          if (rol == 0) {
                            loginError = !loginError;
                          }
                        });

                        if(rol == 1){  /// It goes to admin
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdminHome()),
                          );
                        }
                        if(rol == 2){  /// It goes to educator
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
                  /// Register (TODO: Delete it)
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
