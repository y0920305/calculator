import 'package:flutter/material.dart';

class mytest extends StatefulWidget {
  const mytest({Key? key}) : super(key: key);

  @override
  _mytestState createState() => _mytestState();
}

class _mytestState extends State<mytest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Mobile"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              height: 250,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
