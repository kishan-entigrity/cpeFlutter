import 'package:flutter/material.dart';

class MyTranscation extends StatefulWidget {
  @override
  _MyTranscationState createState() => _MyTranscationState();
}

class _MyTranscationState extends State<MyTranscation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('My Transcation'),
      ),
    );
  }
}
