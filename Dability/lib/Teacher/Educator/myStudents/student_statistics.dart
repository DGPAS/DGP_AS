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

  Map<String, dynamic> student = {};
  List<dynamic> tasks = [];
  List<dynamic> filteredTasks = [];


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
    List<dynamic> aux = await getStudentAgenda(student['id'].toString());
    setState(() {
      tasks = aux;
      filteredTasks.clear();
      filteredTasks.addAll(tasks);
    });
  }

  /// Function that filters the list of students whose name matches
  /// or contains [query] by updating [displayedItems]
  ///
  /// If they don't match, it adds all students to [displayedItems]
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
      body: Column(
        children: [
          if (tasks.isNotEmpty)
            StudentTaskChart(tasks: tasks),
        ],
      ),
    );
  }
}