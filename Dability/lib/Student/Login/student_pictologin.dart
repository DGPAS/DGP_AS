import 'dart:convert';

import 'package:dability/Student/student_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:dability/Api_Requests/student_login_requests.dart';

class StudentPictoLogin extends StatefulWidget {
  final int id_student;

  const StudentPictoLogin({Key? key, required this.id_student})
      : super(key: key);

  @override
  State<StudentPictoLogin> createState() =>
      _StudentPictoLoginState(id_student: this.id_student);
}

class _StudentPictoLoginState extends State<StudentPictoLogin> {
  final int id_student;

  _StudentPictoLoginState({required this.id_student});

  List<dynamic> psswd = [];
  List<dynamic> psd = [];
  List<dynamic> displayedItems = [];
  List<int> intro = [];
  String secuencia = "451";

  bool showError = false;

  @override
  void initState() {
    super.initState();
    print('Init');
    getData();
    secuencia = psswd[6];
  }

  Future<void> getData() async{
    psd = await getPswd(id_student);
    setState(() {
      psswd = psd;
      secuencia = psswd[6];
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
                'PictoLogin ',
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
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 6,
                itemBuilder: (context, int index) {
                  String imagePath = 'images/';
                  if (index == 0) {
                    imagePath = imagePath + psswd[0];
                  } else if (index == 1) {
                    imagePath = imagePath + psswd[1];
                  } else if (index == 2) {
                    imagePath = imagePath + psswd[2];
                  } else if (index == 3) {
                    imagePath = imagePath + psswd[3];
                  } else if (index == 4) {
                    imagePath = imagePath + psswd[4];
                  } else if (index == 5) {
                    imagePath = imagePath + psswd[5];
                  }


                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF4A6987)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF4A6987), elevation: 0),
                      onPressed: () {
                        print(index);
                        setState(() {
                          if (displayedItems.length < 3) {
                            displayedItems.add(psswd[index]);
                            intro.add(index);
                          }
                        });
                        // si displayedItems no es igual a password
                        for (int i = 0; i < displayedItems.length; i++) {
                          if (intro[i] != int.parse(secuencia[i])) {
                            // si deja de coincidir
                            setState(() {
                              displayedItems.clear();
                              intro.clear();
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
                                StudentHome(idStudent: id_student.toString())),
                          );
                        }
                      },
                      child:

                      Image.network("${dotenv.env['API_URL']}/${imagePath}",
                        width: MediaQuery.sizeOf(context).width * 0.3,
                        height: MediaQuery.sizeOf(context).height * 0.2,
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
                    String imagePath = 'images/';

                    int elementIndex = psswd.indexOf(currentElement);
                    if (elementIndex == 0) {
                      imagePath = imagePath + psswd[0];
                    } else if (elementIndex == 1) {
                      imagePath = imagePath + psswd[1];
                    } else if (elementIndex == 2) {
                      imagePath = imagePath + psswd[2];
                    } else if (elementIndex == 3) {
                      imagePath = imagePath + psswd[3];
                    } else if (elementIndex == 4) {
                      imagePath = imagePath + psswd[4];
                    } else if (elementIndex == 5) {
                      imagePath = imagePath + psswd[5];
                    }

                    return Column(
                      children: [
                        Container(

                          child: Image.network("${dotenv.env['API_URL']}/${imagePath}",
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
