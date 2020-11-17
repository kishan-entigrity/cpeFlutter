import 'package:cpe_flutter/constant.dart';
import 'package:flutter/material.dart';

class CertificateFrag extends StatefulWidget {
  @override
  _CertificateFragState createState() => _CertificateFragState();
}

class _CertificateFragState extends State<CertificateFrag> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Certificate Frag Screen',
          style: kTextTitleFragc,
        ),
      ),
    );
  }
}
