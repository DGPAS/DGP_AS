import 'package:flutter/material.dart';

class InicioAdmin extends StatefulWidget {
  _InicioAdminState createState() => _InicioAdminState();
}

class _InicioAdminState extends State<InicioAdmin> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    minimumSize: Size(250, 150),
    textStyle: const TextStyle(fontSize: 45),
    alignment: Alignment.center,
  );

  final ButtonStyle style_1 =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30),);

  //        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),);
  final ButtonStyle style2 =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio Admin'),
      ),
      body:
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    // Acción cuando se presiona el primer botón
                  },
                 child: Text('GESTIONAR ALUMNOS'),
                ),
            ),
            SizedBox(height: 80,),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    // Acción cuando se presiona el primer botón
                  },
                  child: Text('GESTIONAR TAREAS'),
              ),
            )
          ],
        ),



      ),
    );
  }

}