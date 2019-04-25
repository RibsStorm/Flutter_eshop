import 'package:flutter/material.dart';

void main() => runApp(MyAPP());

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Hello Moto"),),
        body: Center(
          child: Text("Hello World!"),
        ),
      ),
    );
  }
}
