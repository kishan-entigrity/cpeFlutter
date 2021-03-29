import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

double text01 = 1.0.sp;
double text02 = 2.0.sp;
double text03 = 3.0.sp;
double text04 = 4.0.sp;
double text05 = 5.0.sp;
double text17 = 17.0.sp;

const kLabelTitleTextStyle = TextStyle(
  fontFamily: 'Whitney Bold',
  fontSize: 35.0,
  color: themeBlueLight,
);

final kLableTextCancelStyle = TextStyle(
  fontSize: 12.0.sp,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
  fontFamily: 'Whitney Medium',
);

final kLableSearchHomeStyle = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 12.0.sp,
  color: Color(0x80000000),
);

final kLableSignUpHintLableStyle = TextStyle(
  fontFamily: 'Whitney Bold',
  fontSize: 10.0.sp,
  color: Colors.black,
);

final kLableSignUpHintStyle = TextStyle(
  fontFamily: 'Whitney Bold',
  fontSize: 15.0.sp,
  color: Color(0xFFBDBFCA),
);

final kLableSignUpTextStyle = TextStyle(
  fontFamily: 'Whitney Bold',
  fontSize: 15.0.sp,
  color: Colors.black,
);

final kDataSliderTitle = TextStyle(
  fontFamily: 'Whitney Bold',
  fontSize: 17.0.sp,
  color: Color(0xFF013872),
);

final kDataSliderData = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 12.0.sp,
  color: Color(0xFF0F2138),
);

final kDataLoginSignUpSlider = TextStyle(
  fontFamily: 'Whitney Bold',
  fontSize: 13.0.sp,
  color: Colors.white,
);

final kDataSingleSelectionBottomNav = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 14.0.sp,
  color: Color(0xFF1F2227),
);

/*const lLabelTagSelected = BoxDecoration(
  borderRadius: BorderRadius.circular(30.0),
  border: Border.all(color: Color(0xFF000000), width: 1.0),
  color: Color(0xFFFFFFFF),
);*/

final kKeyLableWebinarDetailExpand = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 12.0.sp,
  color: black50,
);

final kValueLableWebinarDetailExpand = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 12.0.sp,
  color: Colors.black,
);

final kUserDataTestimonials = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 13.2.sp,
  color: Colors.black,
);

const kUserDataBlueTestimonials = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 19.0,
  color: themeBlue,
);

final kDateTestimonials = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 13.0.sp,
  color: black50,
);

final kOthersTitle = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 13.0.sp,
  color: Colors.black,
);

const kOthersAddress = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 16.0,
  color: black80,
);

final kOthersDescription = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 13.0.sp,
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

final kDownloadWebinarDetailExpand = TextStyle(
  fontFamily: 'Whitney Medium',
  fontSize: 12.0.sp,
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

const kStepText = TextStyle(
  fontFamily: 'Whitney Bold',
  fontSize: 14.0,
  color: Colors.black45,
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

final kWebinarButtonLabelTextStyleWhiteTest = TextStyle(
  fontFamily: 'Whitney Semi Bold',
  fontSize: 15.0.sp,
  color: Colors.teal,
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
  if (status.isEmpty) {
    return " ";
  } else {
    if (part.length > 1) {
      String lowerCase = part[0].toLowerCase();
      String lowerCase1 = part[1].toLowerCase();
      String convert = lowerCase[0].toUpperCase() + lowerCase.substring(1) + " " + lowerCase1[0].toUpperCase() + lowerCase1.substring(1);
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

const Color answerBlue = const Color(0xFF013872);
const Color answerGreen = const Color(0xFF29bd4e);
const Color answerRed = const Color(0xFFee1818);
const Color answerWhite = const Color(0xFFFFFFFF);
const Color answerBlack = const Color(0xFF000000);

// ConstString Files from here..const
const String fnameEmptyMsg = 'Please enter first name';
const String lnameEmptyMsg = 'Please enter last name';
const String emailEmptyMsg = 'Please enter email';
const String emailInValidMsg = 'Please enter valid email id';
const String phoneEmptyMsg = 'Please enter phone number';
const String phoneLengthMsg = 'Phone number must be 10 digits long';
const String extLengthMsg = 'Phone extention must be 3 digits';
const String passEmptyMsg = 'Please enter password';
const String confPassEmptyMsg = 'Please enter confirm password';
const String passLengthMsg = 'Please enter password';
const String confPassLengthMsg = 'Please enter confirm password';
const String passValidLengthMsg = 'Password must be 6 characters';
const String confPassValidLengthMsg = 'Confirm password must be 6 characters';
const String passConfPassEqualMsg = 'Password and confirm password must be same';
const String countryMsg = 'Please select country';
const String stateMsg = 'Please select state';
const String cityMsg = 'Please select city';
const String mobileInfoMsg =
    'We encourage you provide professional email as it will help you managing in credits as all comunication related to CPE credits.';

const String companyEmptyMsg = 'Please enter company name';
const String selectOrganizationSizeMsg = 'Please select organization size';
const String selectJobTitleMsg = 'Please select job title/designation';
const String selectIndustryMsg = 'Please select industry';
const String selectPrefCredsMsg = 'Please select professional credentials';
const String selectAddiQualificationMsg = 'Please select additional qualifications';

const String ptinInfoMsg = 'PTIN number is required, if you are an Enrolled Agent and you want myCPE to report your attendance to the IRS';
const String ctecInfoMsg = 'CTEC ID is required, if you are an California Registered Tax Professional (CRTP) and you want myCPE to report your '
    'attendance to the California Tax Education Council.';
const String cfpInfoMsg = 'CFP Board ID is required, if you are an Certified Financial Planner (CFP) and you want myCPE to report your attendance '
    'to the CFP Board.';

const String termsConditionMsg = 'Please accept terms and conditions by accepting the checkbox.';

const String ptinLenght = 'PTIN number should not more than 8 digits';
const String ctecLenght = 'CTEC Id should not more than 6 digits';

const String sharedPrefsNot = 'Prefs not available';
const String urlnotFound = 'Oops we didn\'t found url';

const String strUpcomingNotFound = 'No Webinar Available';
const String strPendingEvoNotFound = 'No Pending Evalution Available';
const String strDidNotAttendNotFound = 'No Attendees Available';
const String strPollMissedNotFound = 'No Attendees Available';
const String strCompletedNotFound = 'No Completed Webinar Available';

const String strEnrolledSSNotFound = 'No Completed Webinar Available';
const String strQuizPendingSSNotFound = 'No Completed Webinar Available';
const String strPendingEvoSSNotFound = 'No Pending Evaluation Available';
const String strCompletedSSNotFound = 'No Completed Webinar Available';

const bool isFromSubmitReview = false;
