import 'package:flutter/material.dart';

class MyCredit extends StatefulWidget {
  @override
  _MyCreditState createState() => _MyCreditState();
}

class _MyCreditState extends State<MyCredit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('My Credit'),
      ),
    );
  }
}
