import 'package:flutter/material.dart';
import 'task_management.dart';
import 'student_management.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Admin'),
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
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30.0),
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
                        // Aquí puedes realizar la lógica de autenticación
                        // utilizando los datos del formulario (_emailController.text, _passwordController.text)
                        // Por ejemplo, puedes llamar a una función para autenticar al usuario.
                        // authenticateUser(_emailController.text, _passwordController.text);
                        // Si la autenticación es exitosa, puedes navegar a la siguiente pantalla.
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                      }
                    },
                    child: Text('ACCEDER'),
                  ),
                  SizedBox(height: 30,),
                  Text('¿No tienes cuenta? Regístrate')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
