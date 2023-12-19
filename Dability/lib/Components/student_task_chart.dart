import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StudentTaskChart extends StatefulWidget {

  final List<dynamic> tasks;

  const StudentTaskChart({
    Key? key,
    required this.tasks,
  }) :super(key: key);

  @override
  State<StudentTaskChart> createState() => _StudentTaskChartState();
}

class _StudentTaskChartState extends State<StudentTaskChart> {
  List<dynamic> tasks = [];

  @override
  void initState() {
    final DateTime now = DateTime.now();
    print("NOW ----------------- ${now.toString()}");

    /// It filters the tasks by the date
    print(widget.tasks);
    for(var task in widget.tasks) {
      List<String> dateTaskIni = task['dateStart'].toString().split('-');
      final DateTime ini = DateTime.utc(int.parse(dateTaskIni.elementAt(0)), int.parse(dateTaskIni.elementAt(1)), int.parse(dateTaskIni.elementAt(2))); /// Year - Month - Day
      print("INI ----------------- ${ini.toString()}");


      List<String> dateTaskFin = task['dateEnd'].toString().split('-');
      final DateTime fin = DateTime.utc(int.parse(dateTaskFin.elementAt(0)), int.parse(dateTaskFin.elementAt(1)), int.parse(dateTaskFin.elementAt(2))); /// Year - Month - Day
      print("FIN ----------------- ${fin.toString()}");

      /// If the dates of tasks are between the week
      if (ini.isBefore(now) && ini.isAfter(DateTime(now.year,now.month,now.day-3)) && fin.isAfter(now) && fin.isBefore(DateTime(now.year,now.month,now.day+3))) {
        setState(() {
          tasks.add(task);
          print(tasks);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Text(tasks.toString());
    // TODO: Mostrar gráfica ---- Eje x = dias de la semana ||| Eje y = numero de tareas completadas por dia
    // TODO: Mostrar lista de tareas del alumno con filtro nombre | dia y checkbox tareas completadas | no completadas
  }
}