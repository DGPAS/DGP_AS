import 'package:dability/Components/aux_functions.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StudentTaskChart extends StatefulWidget {

  final List<dynamic> tasks;

  StudentTaskChart({
    Key? key,
    required this.tasks,
  }) :super(key: key);

  @override
  State<StudentTaskChart> createState() => _StudentTaskChartState();
}

class _StudentTaskChartState extends State<StudentTaskChart> {
  /// List that stores, from 0 to 6, the number of done tasks
  List<int> numTaskPerDay = [];

  List<ChartSeries> data = [];

  List <charts.Series> series = [];

  @override
  void initState() {
    final DateTime now = DateTime.now();

    /// The last seven days done tasks
    data = [
      ChartSeries(0, now.day-3),
      ChartSeries(0, now.day-2),
      ChartSeries(0, now.day-1),
      ChartSeries(0, now.day),
      ChartSeries(0, now.day+1),
      ChartSeries(0, now.day+2),
      ChartSeries(0, now.day+3),
    ];

    /// It filters the tasks by the date
    for(var task in widget.tasks) {
      setState(() {
        print(task['dateDone']);
        if ( task['dateDone'] != null) {
          List<String> dateDoneString = task['dateDone'].toString().split('-');
          for (var dat in data) {
            print(dateDoneString.elementAt(2));
            if (dat.days.toString() == dateDoneString.elementAt(2)) {
              dat.numTasks++;
            }
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    List<charts.Series<ChartSeries, String>> series = [
      charts.Series(
        id: "Días",
        data: data,
        domainFn: (ChartSeries series, _) =>
            series.days.toString(),
        measureFn: (ChartSeries series, _) =>
        series.numTasks,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.lightGreen),
      )
    ];

    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Número de\ntareas completadas"),
              SizedBox(
                height:MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.7,
                child: charts.BarChart(series, animate: false),
              ),
            ],
          ),
          const Text("Días de la semana")
        ],
      ),
    );
    // TODO: Mostrar lista de tareas del alumno con filtro nombre | dia y checkbox tareas completadas | no completadas
  }
}

class ChartSeries {
  int numTasks;
  int days;

  ChartSeries(@required this.numTasks, @required this.days);
}