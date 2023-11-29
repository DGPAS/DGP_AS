import 'package:dability/student_home.dart';
import 'package:flutter/material.dart';

class StudentPictoLogin extends StatefulWidget {
  final int id_alumno;

  const StudentPictoLogin({Key? key, required this.id_alumno})
      : super(key: key);

  @override
  State<StudentPictoLogin> createState() =>
      _StudentPictoLoginState(id_alumno: this.id_alumno);
}

class _StudentPictoLoginState extends State<StudentPictoLogin> {
  final int id_alumno;

  _StudentPictoLoginState({required this.id_alumno});

  List<String> elementos = [];
  String student = "JUAN";
  List<String> students = [];
  List<String> displayedItems = [];
  List<String> password = [];

  bool showError = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      elementos.add("Spiderman");
      elementos.add("Batman");
      elementos.add("Superman");
      elementos.add("Pantera");
      elementos.add("Luffy");
      elementos.add("Goku");

      students.add("JOAQUIN");
      students.add("MANUEL");
      students.add("SARA");
      students.add("RUBEN");
      students.add("JUAN");
      students.add("ALICIA");

      student = students[id_alumno];

      password = ["Spiderman", "Batman", "Superman"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('images/DabilityLogo.png', width: 48, height: 48),
            Expanded(
              child: Text(
                'PictoLogin ' + student,
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
                    'images/userIcon.png',
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 6,
                itemBuilder: (context, int index) {
                  String imagePath = "";

                  if (index == 0) {
                    imagePath = 'images/spiderman.png';
                  } else if (index == 1) {
                    imagePath = 'images/batman.jpeg';
                  } else if (index == 2) {
                    imagePath = 'images/superman.jpg';
                  } else if (index == 3) {
                    imagePath = 'images/pantera.jfif';
                  } else if (index == 4) {
                    imagePath = 'images/luffy.jpeg';
                  } else if (index == 5) {
                    imagePath = 'images/goku.jpg';
                  }

                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF4A6987)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF4A6987), elevation: 0),
                      onPressed: () {
                        setState(() {
                          if (displayedItems.length < 3) {
                            displayedItems.add(elementos[index]);
                          }
                        });
                        // si displayedItems no es igual a password
                        for (int i = 0; i < displayedItems.length; i++) {
                          if (displayedItems[i] != password[i]) {
                            // si deja de coincidir
                            setState(() {
                              displayedItems.clear();
                              showError = true;
                            });
                            // Después de 1 segundo, ocultar la X
                            Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                showError = false;
                              });
                            });

                            break;
                          }
                        }

                        if(displayedItems.length == 3){
                          // contraseña correcta
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                StudentHome(id_alumno: id_alumno)),
                          );
                        }
                      },
                      child: Image.asset(
                        imagePath,
                        width: MediaQuery.of(context).size.width * 0.30,
                        height: MediaQuery.of(context).size.width * 0.30,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Container para mostrar las imágenes correspondientes a displayedItems
            Container(
              height: 200,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(displayedItems.length, (index) {
                    String currentElement = displayedItems[index];

                    // Selecciona la imagen en función de la comprobación
                    String imagePath = "";

                    int elementIndex = elementos.indexOf(currentElement);

                    if (elementIndex == 0) {
                      imagePath = 'images/spiderman.png';
                    } else if (elementIndex == 1) {
                      imagePath = 'images/batman.jpeg';
                    } else if (elementIndex == 2) {
                      imagePath = 'images/superman.jpg';
                    } else if (elementIndex == 3) {
                      imagePath = 'images/pantera.jpeg';
                    } else if (elementIndex == 4) {
                      imagePath = 'images/luffy.jpeg';
                    } else if (elementIndex == 5) {
                      imagePath = 'images/goku.jpeg';
                    }

                    return Column(
                      children: [
                        Container(
                          child: Image.asset(
                            imagePath,
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            height: MediaQuery.sizeOf(context).height * 0.2,
                          ),
                        ),
                      ],
                    );
                  }),
                  // Container para mostrar la X en caso de error
                  Visibility(
                    visible: showError,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'X',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  displayedItems.clear();
                });
              },
              child: Text('Limpiar'),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

