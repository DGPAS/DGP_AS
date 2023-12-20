import 'package:dability/Api_Requests/agenda_requests.dart';
import 'package:flutter/material.dart';

import 'package:dability/Components/student_task_chart.dart';

/// # Page where admin manages students
class StudentStatistics extends StatefulWidget {

  final Map<String, dynamic> student;

  const StudentStatistics({
    Key? key,
    required this.student
  }): super(key:key);

  @override
  State<StudentStatistics> createState() => _StudentStatisticsState();
}

class _StudentStatisticsState extends State<StudentStatistics> {
  /// Text controller for task filter
  ///
  /// If the text on the filter changes, it stores changes
  /// TODO: CREO NO ES NECESARIO ESTE CONTROLLER PORQUE NO SE USA
  TextEditingController _controller = TextEditingController();


  Map<String, dynamic> student = {};
  List<dynamic> tasks = [];
  List<dynamic> filteredTasks = [];

  /// Maximum with of the list of tasks
  double maxWidth = 500;

  /// Init State
  ///
  /// Initialize the list of students by calling [getData]
  @override
  void initState() {
    super.initState();

    student = widget.student;

    getData();
  }

  /// Function that calls [getStudentAgenda] who returns the DataBase students
  /// and adds them to [filteredTasks]
  Future<void> getData () async {
    List<dynamic> aux = await getStudentAgendaAll(student['id'].toString());
    setState(() {
      tasks = aux;
      filteredTasks.clear();
      filteredTasks.addAll(tasks);
    });
  }

  /// Function that filters the list of students whose name matches
  /// or contains [query] by updating [filteredTasks]
  ///
  /// If they don't match, it adds all students to [filteredTasks]
  /// If they don't match, it adds all students to [filteredTasks]
  void filterSearchResults(String query) {
    List<dynamic> searchResults = [];

    if (query.isNotEmpty) {
      for (var i = 0; i < tasks.length; i++) {
        if (("${tasks[i]['taskName']}").toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(tasks[i]);
        }
      }
    } else {
      searchResults.addAll(tasks);
    }

    setState(() {
      filteredTasks.clear();
      filteredTasks.addAll(searchResults);
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
                "GRAFICO DE TAREAS DE\n LA SEMANA DE ${student['firstName'].toString().toUpperCase()} ${student['lastName'].toString().toUpperCase()}",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (tasks.isNotEmpty)
              StudentTaskChart(tasks: tasks),
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
            /// List of tasks
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF4A6987),
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [Color(0xFF4A6987), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              height: 400,
              width: (MediaQuery.of(context).size.width - 30)
                  .clamp(0.0, maxWidth.toDouble()),
              padding:
              EdgeInsets.symmetric(horizontal: 30), // Margen horizontal
              child: ListView(children: [
                SizedBox(
                  height: 30,
                ),
                /// It returns a list of ElevatedButton
                ///
                /// One ElevatedButton for each task in [filteredTasks]
                /// Each item of the list contains the name of the task,
                /// a button for update the task and another one to delete it
                ...List.generate(filteredTasks.length, (index) {
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
                            borderRadius: BorderRadius.circular(
                                30), // Redondear los bordes del botón
                          ),
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20), // Margen horizontal del texto
                        ),
                        onPressed: () {
                          // no action
                        },
                        /// The content of each task
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Name of the task
                              Text(
                                filteredTasks[index]['taskName'],
                                //textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors
                                      .black, // Cambia el color del texto a rojo
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Información de la tarea',
                                                style: TextStyle(color: Colors.black),),
                                              content: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.35,
                                                height: MediaQuery.of(context).size.height * 0.4,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(bottom: 20),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Nombre: ',
                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                                            Text(
                                                              filteredTasks[index]['taskName'] ?? '-',
                                                              style: TextStyle(color: Colors.black),),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                              'Fecha inicio: ',
                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                                          Text(
                                                            filteredTasks[index]['dateStart'],
                                                            style: TextStyle(color: Colors.black),),
                                                        ],
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(bottom: 10),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Fecha fin: ',
                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                                            Text(
                                                              filteredTasks[index]['dateEnd'],
                                                              style: TextStyle(color: Colors.black),),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(bottom: 20),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Fecha finalizada: ',
                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                                            Text(
                                                              filteredTasks[index]['dateDone'] ?? '-',
                                                              style: TextStyle(color: Colors.black),),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Descripción:',
                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                                        ],
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(bottom: 20),
                                                        child: Text(
                                                          filteredTasks[index]['description'] ?? '-',
                                                          style: TextStyle(color: Colors.black),),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Tiene miniatura: ',
                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                                          Text(
                                                            filteredTasks[index]['thumbnail'] == null ? 'NO' : 'SI',
                                                            style: TextStyle(color: Colors.black),),
                                                        ],
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(bottom: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Tiene video: ',
                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                                            Text(
                                                              filteredTasks[index]['video'] == null ? 'NO' : 'SI',
                                                              style: TextStyle(color: Colors.black),),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Cierra el diálogo
                                                  },
                                                  child: Text('Cerrar',
                                                    style: TextStyle(color: Colors.black),),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(10, 20),
                                        backgroundColor: Color(0xFFF5F5F5),
                                        elevation: 0,
                                      ),
                                      child: Image.asset(
                                        'assets/images/info.png',
                                        width: 30,
                                        height: 35,
                                      ),
                                    ),
                                    const Text("Realizada: ", style: TextStyle(color: Colors.grey, fontSize: 14)),
                                    /// Image that represents if the task has been
                                    /// done or not
                                    if (filteredTasks[index]['done'] == 1)
                                    Image.asset(
                                        'assets/images/checkIcon.png',
                                        width: 30,
                                        height: 35,
                                    ),
                                    if (filteredTasks[index]['done'] == 0)
                                      Image.asset(
                                        'assets/images/no.png',
                                        width: 30,
                                        height: 35,
                                      ),
                                  ],
                                ),
                              ),
                              /////
                            ]),
                      ),
                      SizedBox(height: 30), //espacio entre tareas
                    ],
                  );
                })
              ]),
            ),
          ],
        ),
      ),
    );
  }
}