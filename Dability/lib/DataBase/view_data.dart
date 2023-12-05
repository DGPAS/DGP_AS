import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List<dynamic> userdata = [];

  Future<void> delRecord(String idTasks) async {
    String uri = "http://10.0.2.2:80/delete_data.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {"idTasks": idTasks});
      var response = jsonDecode(res.body);
      if (response["success"] == true) {
        print("Record deleted");
      } else {
        print("Some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getRecord() async {
    String uri = "http://10.0.2.2:80/view_data.php";
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        // The request was successful
        setState(() {
          userdata = json.decode(response.body);
        });
      } else {
        // The request failed, print the status code
        print('Error in the request: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('D-Ability'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: userdata.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(userdata[index]['id'].toString()),
              subtitle: Text(userdata[index]['email']),
              onTap: () {
                // Call the delRecord function when a ListTile is tapped
                delRecord(userdata[index]['id'].toString());
              },
            ),
          );
        },
      ),
    );
  }
}