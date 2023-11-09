import 'package:flutter/material.dart';

class GestionTareas extends StatefulWidget {
  _GestionTareasState createState() => _GestionTareasState();
}

class _GestionTareasState extends State<GestionTareas> {

  List<String> tasks = [];  // lista de tareas
  double maxAnchoMaximo = 500;
  // final List<Color> containerColors = [Colors.red, Colors.green, Colors.blue]; // Colores de los contenedores


  @override
  void initState() {
    super.initState();
    tasks.add("Tarea 1");
    tasks.add("Tarea 2");
    tasks.add("Tarea 3");
    tasks.add("Tarea 4");
    tasks.add("Tarea 5");
    tasks.add("Tarea 6");
    tasks.add("Tarea 7");
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión tareas'),
        backgroundColor: Color(0xFF4A6987),
      ),
      body:
      Container(
          padding: EdgeInsets.only(top: 45.0, bottom: 10.0),
          child: Column( // columna con el boton de añadir, y el container de la lista
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container( // tiene el elevated button de añadir tarea
                // width: (MediaQuery.of(context).size.width - 30).clamp(0.0, maxAnchoMaximo.toDouble()),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                    // Irá a la pantalla de añadir tarea - descomentar
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
              Expanded(
                child:
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF4A6987),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 400,
                    width: (MediaQuery.of(context).size.width - 30).clamp(0.0, maxAnchoMaximo.toDouble()),
                    padding: EdgeInsets.symmetric(horizontal: 30), // Margen horizontal
                      child: ListView(
                          children: [
                            SizedBox(height: 30,),
                            ...List.generate(
                              tasks.length,
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              tasks[index],
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
                                                        // Irá a la pantalla de añadir tarea
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(builder: (context) => EditTask()),
                                                        // );
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        minimumSize: Size(10, 20),
                                                        primary: Color(0xFFF5F5F5),
                                                        elevation: 0,
                                                      ),
                                                      child: Image.asset(
                                                        'images/EditIcon.png',
                                                        width: 30,
                                                        height: 35,
                                                      ),
                                                    ),

                                                    SizedBox(width: 10,), // cambiar?
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: Text('Confirmar eliminación'),
                                                              content: Text('¿Estás seguro de que deseas eliminar esta tarea?'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop(); // Cierra el diálogo
                                                                  },
                                                                  child: Text('Cancelar'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      tasks.remove(tasks[index]);
                                                                    });
                                                                    Navigator.of(context).pop(); // Cierra el diálogo
                                                                  },
                                                                  child: Text('Eliminar'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          minimumSize: Size(10, 20),
                                                          primary: Color(0xFFF5F5F5),
                                                          elevation: 0,
                                                      ),
                                                      child: Image.asset(
                                                        'images/DeleteIcon.png',
                                                        width: 30,
                                                        height: 35,
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
              ),
            ],
          ),
      ),
    );
  }

}