import 'package:flutter/material.dart';
import 'gestion_tareas.dart';

class InicioAdmin extends StatefulWidget {
  const InicioAdmin({super.key});

  @override
  State<InicioAdmin> createState() => _InicioAdminState();
}

class _InicioAdminState extends State<InicioAdmin> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    minimumSize: Size(400, 120), // 180, 150
    textStyle: const TextStyle(
      fontSize: 30,
      color: Colors.black,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Redondear los bordes del botón
    ),
    backgroundColor: Color(0xFF4A6987),
    padding: EdgeInsets.symmetric(horizontal: 40), // Margen horizontal
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio Admin'),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              style: style,
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => GestionAlumnos()),
                // );
              },
              child: Text(
                'GESTIONAR ALUMNOS',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GestionTareas()),
                );
              },
              child: Text(
                'GESTIONAR TAREAS',
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
