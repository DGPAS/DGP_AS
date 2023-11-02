import 'package:flutter/material.dart';

class GestionTareas extends StatefulWidget {
  _GestionTareasState createState() => _GestionTareasState();
}

class _GestionTareasState extends State<GestionTareas> {
  /*
  final ButtonStyle style = ElevatedButton.styleFrom(
    minimumSize: Size(MediaQuery.of(context).size.width - 20, 150), // 180, 150
    textStyle: const TextStyle(fontSize: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Redondear los bordes del botón
    ),
    primary: Colors.teal,
  );
  */

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
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 150), // 180, 150
                  textStyle: const TextStyle(fontSize: 40,
                    color: Colors.black,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Redondear los bordes del botón
                  ),
                  primary: Color(0xFF4A6987),
                  padding: EdgeInsets.symmetric(horizontal: 40), // Margen horizontal
                ),
                onPressed: () {
                  // Acción cuando se presiona el primer botón
                },
                child: Text('Añadir tarea',
                  textAlign: TextAlign.center,),
              ),
            ),
            SizedBox(height: 60,),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF4A6987),
                borderRadius: BorderRadius.circular(30),
              ),
              width: MediaQuery.of(context).size.width - 30,
              padding: EdgeInsets.symmetric(horizontal: 40), // Margen horizontal
              child:
                Column(
                    children: [
                      SizedBox(height: 30,),
                      ...List.generate(
                        3,
                        (index) {
                          return Column(
                            children: [

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 150), // 180, 150
                                  textStyle: const TextStyle(fontSize: 40,
                                    color: Colors.black,),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30), // Redondear los bordes del botón
                                  ),
                                  primary: Color(0xFFF5F5F5),
                                  padding: EdgeInsets.symmetric(horizontal: 40), // Margen horizontal
                                ),
                                onPressed: () {
                                  // acción
                                },
                                child: Text('Tarea ' + index.toString(),
                                  textAlign: TextAlign.center,),
                              ),

                              SizedBox(height: 30),

                            ],
                          );
                        }
                      )
                  ]
                ),
            ),
          ],
        ),
      ),
    );
  }

}