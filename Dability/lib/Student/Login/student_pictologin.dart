import 'package:dability/Student/student_home.dart';
import 'package:flutter/material.dart';

/// # Student pictologin to access with his/her credentials
///
/// It shows 6 pictures on top and the student can select 3 of them,
/// which will appear on bottom
class StudentPictoLogin extends StatefulWidget {
  final int idStudent;

  const StudentPictoLogin({Key? key, required this.idStudent})
      : super(key: key);

  @override
  State<StudentPictoLogin> createState() =>
      _StudentPictoLoginState(idStudent: idStudent);
}

class _StudentPictoLoginState extends State<StudentPictoLogin> {
  final int idStudent;

  _StudentPictoLoginState({required this.idStudent});

  List<String> elements = [];
  String student = "JUAN";
  List<String> students = [];
  /// It stores the pictures selected by the student
  List<String> displayedItems = [];
  List<String> password = [];

  bool showError = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      elements.add("Spiderman");
      elements.add("Batman");
      elements.add("Superman");
      elements.add("Pantera");
      elements.add("Luffy");
      elements.add("Goku");

      students.add("JOAQUIN");
      students.add("MANUEL");
      students.add("SARA");
      students.add("RUBEN");
      students.add("JUAN");
      students.add("ALICIA");

      student = students[idStudent];

      password = ["Spiderman", "Batman", "Superman"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
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
                    'assets/images/userIcon.png',
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
              /// Grid that shows all the picto-password
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
                    imagePath = 'assets/images/spiderman.png';
                  } else if (index == 1) {
                    imagePath = 'assets/images/batman.jpeg';
                  } else if (index == 2) {
                    imagePath = 'assets/images/superman.jpg';
                  } else if (index == 3) {
                    imagePath = 'assets/images/pantera.jfif';
                  } else if (index == 4) {
                    imagePath = 'assets/images/luffy.jpeg';
                  } else if (index == 5) {
                    imagePath = 'assets/images/goku.jpg';
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
                            displayedItems.add(elements[index]);
                          }
                        });
                        /// if displayedItems is not equal to  password
                        for (int i = 0; i < displayedItems.length; i++) {
                          if (displayedItems[i] != password[i]) {
                            /// if picto-passwords doesn't match it shows an X
                            setState(() {
                              displayedItems.clear();
                              showError = true;
                            });
                            /// After 1 seconds, the X dissappear
                            Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                showError = false;
                              });
                            });

                            break;
                          }
                        }

                        if(displayedItems.length == 3){
                          /// If the password is Ok, it goes to the [student_home.dart]
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                StudentHome(idStudent: idStudent)),
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
            /// Container to show the [displayedItems] pictures
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

                    int elementIndex = elements.indexOf(currentElement);

                    if (elementIndex == 0) {
                      imagePath = 'assets/images/spiderman.png';
                    } else if (elementIndex == 1) {
                      imagePath = 'assets/images/batman.jpeg';
                    } else if (elementIndex == 2) {
                      imagePath = 'assets/images/superman.jpg';
                    } else if (elementIndex == 3) {
                      imagePath = 'assets/images/pantera.jpeg';
                    } else if (elementIndex == 4) {
                      imagePath = 'assets/images/luffy.jpeg';
                    } else if (elementIndex == 5) {
                      imagePath = 'assets/images/goku.jpeg';
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
                  /// Container show the X if it the password doesn't match
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
            // TODO: Quitar boton limpiar
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

