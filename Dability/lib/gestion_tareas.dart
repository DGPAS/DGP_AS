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
        backgroundColor: Color(0xFF4A6987),
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
                  minimumSize: Size(double.infinity, 80), // 180, 150
                  textStyle: const TextStyle(fontSize: 30,
                    color: Colors.black,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Redondear los bordes del botón
                  ),
                  primary: Color(0xFF4A6987),
                  padding: EdgeInsets.symmetric(horizontal: 40), // Margen horizontal
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => AddTask()),
                  // );
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
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      SizedBox(height: 30,),
                      ...List.generate(
                        7,
                        (index) {
                          return Column(
                            children: [

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 80), // 180, 150
                                  textStyle: const TextStyle(fontSize: 20,
                                    color: Colors.black,),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30), // Redondear los bordes del botón
                                  ),
                                  primary: Color(0xFFF5F5F5),
                                  padding: EdgeInsets.symmetric(horizontal: 20), // Margen horizontal del texto
                                ),
                                onPressed: () {
                                  // acción
                                },
                                child:
                                  Row(
                                    children: [
                                      Text(
                                        'Tarea ' + index.toString(),
                                        //textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black, // Cambia el color del texto a rojo
                                        ),
                                      ),

                                      /////
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          //color: Colors.blue,
                                          child: Row(
                                            children: [

                                              ElevatedButton(
                                                onPressed: () {
                                                  // Acción del botón
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(10, 20),
                                                  primary: Color(0xFF4A6987)
                                                ),
                                                child: Icon(
                                                    Icons.edit,
                                                ),
                                              ),

                                              SizedBox(width: 10,), // cambiar?
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Acción del botón
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    minimumSize: Size(10, 20),
                                                    primary: Color(0xFF4A6987)
                                                ),
                                                child: Icon(
                                                  Icons.delete,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      /////
                                    ]
                                  ),



                              ),

                              SizedBox(height: 30),

                            ],
                          );
                        }
                      )
                  ]
                ),
              ),
              //////
            ),
          ],
        ),
      ),
    );
  }

}