import 'package:dability/Teacher/Educator/myStudents/student_statistics.dart';
import 'package:flutter/material.dart';
import 'package:dability/Api_Requests/student_requests.dart';


/// # Page where admin manages students
class MyStudents extends StatefulWidget {
  const MyStudents({super.key});

  @override
  State<MyStudents> createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {
  /// Text controller for student filter
  ///
  /// If the text on the filter changes, it stores changes
  /// TODO: CREO NO ES NECESARIO ESTE CONTROLLER PORQUE NO SE USA
  TextEditingController _controller = TextEditingController();

  String idEducator = '1';

  /// List that stores students form DataBase
  List<dynamic> students = [];
  double widthMax = 500;

  List<dynamic> displayedItems = [];

  /// Init State
  ///
  /// Initialize the list of students by calling [getData]
  @override
  void initState() {
    super.initState();
    getData();
  }

  /// Function that calls [getStudents] who returns the DataBase students
  /// and adds them to [displayedItems]
  Future<void> getData () async {
    students = await getEducatorStudents(idEducator);
    setState(() {
      displayedItems.clear();
      displayedItems.addAll(students);
    });
  }

  /// Function that filters the list of students whose name matches
  /// or contains [query] by updating [displayedItems]
  ///
  /// If they don't match, it adds all students to [displayedItems]
  void filterSearchResults(String query) {
    List<dynamic> searchResults = [];

    if (query.isNotEmpty) {
      for (var i = 0; i < students.length; i++) {
        if (("${students[i]['firstName']} ${students[i]['lastName']}").toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(students[i]);
        }
      }
    } else {
      searchResults.addAll(students);
    }

    setState(() {
      displayedItems.clear();
      displayedItems.addAll(searchResults);
    });
  }

  /// Main builder of the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/DabilityLogo.png', width: 48, height: 48),
            Expanded(
              child: Text(
                "MIS ESTUDIANTES",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF4A6987),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30.0, bottom: 8.0),
        child: Column(
          /// Column that contains a button that adds students,
          /// the students filter and the filterd list of students
          children: [
            /// SizedBox for the filter
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.152,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 15.0, left: 14, right: 14),
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Buscar',
                    hintText: 'Ingrese su búsqueda',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ),
            /// List of students
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Color(0xFF4A6987), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                height: 400,
                width: (MediaQuery.of(context).size.width - 30)
                    .clamp(0.0, widthMax.toDouble()),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ListView(children: [
                  SizedBox(
                    height: 30,
                  ),
                  /// It returns a list of ElevatedButton
                  ///
                  /// One ElevatedButton for each student in [displayedItems]
                  /// Each item of the list contains the name of the student,
                  /// a button for update the student and another one to delete it
                  ...List.generate(displayedItems.length, (index) {
                    return Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                double.infinity,
                                MediaQuery.of(context).size.height *
                                    0.1), // inf, 80
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Color(0xFFF5F5F5),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          onPressed: () {
                            // acción del botón
                          },
                          /// The content of each student
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Name of the student
                                Text(
                                  '${displayedItems[index]['firstName']} ${displayedItems[index]['lastName']}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    children: [
                                      /// Button that navigates to [add_mod_student.dart] with [AddModType.mod]
                                      /// to modify the current student
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StudentStatistics(student: displayedItems[index])),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(10, 20),
                                          backgroundColor: Color(0xFFF5F5F5),
                                          elevation: 0,
                                        ),
                                        child: Image.asset(
                                          'assets/images/statisticsIcon.png',
                                          width: 30,
                                          height: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: 30), // Espacio entre las tareas
                      ],
                    );
                  })
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
