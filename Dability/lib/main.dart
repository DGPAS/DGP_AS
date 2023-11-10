import 'package:flutter/material.dart';
import 'package:dability/add_task.dart';
import 'package:dability/DataBase/connection.dart';
import 'package:mysql1/mysql1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'D-Ability'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var db = MySql();

  String mail = "";

  void _connection () {
    db.getConnection().then((conn) {
      String sql = "SELECT * FROM prueba.pruebaT WHERE mail=luisperezcruz01@gmail.com;";
      conn.query(sql).then((res) {
        for (var row in res) {
          setState(() {
            mail = row[0];
          });
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than haviScang to individually change instances of widgets.
    return Scaffold(
      body: Column(
        children: [ElevatedButton(
        onPressed: () {
          _connection();
        },
        child: const Text('Mostrar correo'),
      ),
          Text(mail),
    ],
    ),
    );
  }
}
