import 'package:cpe_flutter/screens/fragments/test_class_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestClass1 extends StatefulWidget {
  @override
  _TestClass1State createState() => _TestClass1State();
}

class _TestClass1State extends State<TestClass1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Init State for TestClass1 is called..');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: () {
              print('clicked on redirect button class 1');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TestClass2(),
                ),
              );
            },
            child: Container(
              color: Colors.tealAccent,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text('button 1'),
            ),
          ),
        ),
      ),
    );
  }
}
