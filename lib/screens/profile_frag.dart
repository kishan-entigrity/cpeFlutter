import 'package:cpe_flutter/constant.dart';
import 'package:flutter/material.dart';

class ProfileFrag extends StatefulWidget {
  @override
  _ProfileFragState createState() => _ProfileFragState();
}

class _ProfileFragState extends State<ProfileFrag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Frag Screen',
          style: kTextTitleFragc,
        ),
      ),
    );
  }
}
