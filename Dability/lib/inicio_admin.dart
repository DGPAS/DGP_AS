import 'package:flutter/material.dart';
import 'gestion_tareas.dart';

class InicioAdmin extends StatefulWidget {
  _InicioAdminState createState() => _InicioAdminState();
}

class _InicioAdminState extends State<InicioAdmin> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    minimumSize: Size(double.infinity, 80), // 180, 150
    textStyle: const TextStyle(fontSize: 30,
      color: Colors.black,),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Redondear los bordes del botón
    ),
    primary: Color(0xFF4A6987),
    padding: EdgeInsets.symmetric(horizontal: 40), // Margen horizontal
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio Admin'),
        backgroundColor: Color(0xFF4A6987),
      ),
      body:
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                //alignment: Alignment.center,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    // Acción cuando se presiona el primer botón
                  },
                 child: Text('GESTIONAR ALUMNOS',
                   textAlign: TextAlign.center,),
                ),
            ),
            SizedBox(height: 80,),
            Container(
                //alignment: Alignment.center,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GestionTareas()),
                    );
                  },
                  child: Text('GESTIONAR TAREAS',
                    textAlign: TextAlign.center,),
              ),
            )
          ],
        ),



      ),
    );
  }

}