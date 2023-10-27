import 'package:flutter/material.dart';

class GestionTareas extends StatefulWidget {
  _GestionTareasState createState() => _GestionTareasState();
}

class _GestionTareasState extends State<GestionTareas> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    // minimumSize: Size(180, 150),
    textStyle: const TextStyle(fontSize: 20),
    //alignment: Alignment.center,
  );

  final List<Color> containerColors = [Colors.red, Colors.green, Colors.blue]; // Colores de los contenedores

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión tareas'),
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
                child: Text('Añadir tarea',
                  textAlign: TextAlign.center,),
              ),
            ),
            Column(
              children: List.generate(
                3,
                  (index) {
                    return ElevatedButton(
                      style: style,
                      onPressed: () {
                        // acción
                      },
                      child: Text('Tarea' + index.toString(),
                        textAlign: TextAlign.center,),
                    );
                  }
              )
            ),
          ],
        ),



      ),
    );
  }

}