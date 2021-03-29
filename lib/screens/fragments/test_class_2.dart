import 'package:cpe_flutter/screens/fragments/test_class_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestClass2 extends StatefulWidget {
  @override
  _TestClass2State createState() => _TestClass2State();
}

class _TestClass2State extends State<TestClass2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Init State for TestClass2 is called..');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: () {
              print('clicked on redirect button class 2');
              /*Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => TestClass1(),
                  ),
                      (Route<dynamic> route) => false);*/
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => TestClass1(),
                ),
              );
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TestClass1(),
                ),
              );*/
              // Navigator.pop(context, true);
            },
            child: Container(
              color: Colors.tealAccent,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text('button 2'),
            ),
          ),
        ),
      ),
    );
  }
}
