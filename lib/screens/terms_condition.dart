import 'package:flutter/material.dart';

class TermsCondition extends StatefulWidget {
  @override
  _TermsConditionState createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Terms and condition'),
      ),
    );
  }
}
