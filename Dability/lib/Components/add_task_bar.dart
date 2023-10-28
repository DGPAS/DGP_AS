import 'package:dability/main.dart';
import 'package:flutter/material.dart';

class AddTaskBar extends StatelessWidget {
  const AddTaskBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
            ),
            onPressed: null,
            child: Row(
              children: <Widget>[
                const Text('Cancelar '),
                const Icon(Icons.cancel_rounded, color: Colors.redAccent),
              ],
            ),
            ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)
            ),
            onPressed: null,
            child: Row(
              children: <Widget>[
                const Text('Crear '),
                const Icon(Icons.add, color: Colors.green),
              ],
            ),
            ),
        ],
      ),
    );
  }
}
