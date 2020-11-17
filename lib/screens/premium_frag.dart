import 'package:cpe_flutter/constant.dart';
import 'package:flutter/material.dart';

class PremiumFrag extends StatefulWidget {
  @override
  _PremiumFragState createState() => _PremiumFragState();
}

class _PremiumFragState extends State<PremiumFrag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Premium Frag Screen',
          style: kTextTitleFragc,
        ),
      ),
    );
  }
}
