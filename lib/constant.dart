import 'package:flutter/material.dart';

const kLabelTitleTextStyle = TextStyle(
  fontFamily: 'Whitney Bold',
  fontSize: 35.0,
  color: themeBlueLight,
);

/*const lLabelTagSelected = BoxDecoration(
  borderRadius: BorderRadius.circular(30.0),
  border: Border.all(color: Color(0xFF000000), width: 1.0),
  color: Color(0xFFFFFFFF),
);*/

const kKeyLableWebinarDetailExpand = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 17.0,
  color: black50,
);

const kValueLableWebinarDetailExpand = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 17.0,
  color: Colors.black,
);

const kUserDataTestimonials = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 17.0,
  color: Colors.black,
);

const kUserDataBlueTestimonials = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 19.0,
  color: themeBlue,
);

const kDateTestimonials = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 15.0,
  color: black50,
);

const kOthersTitle = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 17.0,
  color: Colors.black,
);

const kOthersAddress = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 16.0,
  color: black80,
);

const kOthersDescription = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 16.0,
  color: black50,
);

const kWebinarStatusBig = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 21.0,
  letterSpacing: 0.5,
  color: Colors.white,
);

const kWebinarStatusSmall = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 17.0,
  color: Colors.white,
);

const kDownloadWebinarDetailExpand = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 16.0,
  color: Colors.white,
);

const lTextFlieldStyleEmail = InputDecoration(
  hintText: 'Email',
  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
  // border: OutlineInputBorder(),
  border: UnderlineInputBorder(),
);

const lTextFlieldStyleOldPass = InputDecoration(
  hintText: 'Old Password',
  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
  // border: OutlineInputBorder(),
  border: UnderlineInputBorder(),
);

const lTextFlieldStyleNewPass = InputDecoration(
  hintText: 'New Password',
  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
  // border: OutlineInputBorder(),
  border: UnderlineInputBorder(),
);

const lTextFlieldStyleConfirmPass = InputDecoration(
  hintText: 'Confirm Password',
  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
  // border: OutlineInputBorder(),
  border: UnderlineInputBorder(),
);

const lTextFlieldStylePass = InputDecoration(
  hintText: 'Password',
  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
  // border: OutlineInputBorder(),
  border: UnderlineInputBorder(),
);

const kButtonLabelTextStyle = TextStyle(
  fontFamily: 'Whitney Bold',
  fontSize: 35.0,
  color: Colors.black,
);

const kWebinarTitleLabelTextStyle = TextStyle(
  fontFamily: 'Whitney Bold',
  fontSize: 20.0,
  color: Colors.black,
);

const kWebinarButtonLabelTextStyleGreen = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 15.0,
  color: Color(0xFF00A81B),
);

const kWebinarButtonLabelTextStyle = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 15.0,
  color: Colors.black,
);

const kWebinarButtonLabelTextStyleWhite = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 17.0,
  color: Colors.white,
);

const kWebinarSpeakerNameLabelTextStyle = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 17.0,
  color: Colors.black,
);

const kTextLableLoginUnderline = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  decoration: TextDecoration.underline,
  color: themeBlueLight,
  fontSize: 17.0,
  letterSpacing: 1,
);

const kTextLableLoginUnderlineGray = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  decoration: TextDecoration.underline,
  color: underLineGray,
  fontSize: 17.0,
  letterSpacing: 1,
);

const kTextTitleFragc = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
);

convertCamelCase(String status) {
  var part = status.split(' ');
  int len = part.length;
  print('Lenght for converCamelCase is : $len');
  if (status.isEmpty) {
    return " ";
  } else {
    if (part.length > 1) {
      String lowerCase = part[0].toLowerCase();
      String lowerCase1 = part[1].toLowerCase();
      String convert = lowerCase[0].toUpperCase() +
          lowerCase.substring(1) +
          " " +
          lowerCase1[0].toUpperCase() +
          lowerCase1.substring(1);
      return "$convert";
    } else {
      String lowerCase = part[0].toLowerCase();
      String convert = lowerCase[0].toUpperCase() + lowerCase.substring(1);
      return "$convert";
    }
  }
}

// ConstColor Files from here..
const Color testColor = const Color(0xFFF3F5F9);
const Color themeBlue = const Color(0xFF08264c);
const Color themeYellow = const Color(0xFFFBB42C);
const Color black50 = const Color(0x501F2227);
const Color black80 = const Color(0x801F2227);
const Color themeBlueLight = const Color(0xFF193F70);
const Color underLineGray = const Color(0xFFA0A2B0);
