import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/custom_dialog.dart';
import 'package:cpe_flutter/components/custom_dialog_register.dart';
import 'package:cpe_flutter/components/custom_dialog_two.dart';
import 'package:cpe_flutter/const_signup.dart';
import 'package:cpe_flutter/screens/final_quiz/final_quiz_screen.dart';
import 'package:cpe_flutter/screens/intro_login_signup/login.dart';
import 'package:cpe_flutter/screens/profile/guest_cards_frag.dart';
import 'package:cpe_flutter/screens/profile/notification.dart';
import 'package:cpe_flutter/screens/review_questions/review_questions.dart';
import 'package:cpe_flutter/screens/webinar_details/ExpandedCard.dart';
import 'package:cpe_flutter/screens/webinar_details/WebinarSpeakerName_OnDemand.dart';
import 'package:cpe_flutter/screens/webinar_details/WebinarTitleOnDemand.dart';
import 'package:cpe_flutter/screens/webinar_details/childCardDetails.dart';
import 'package:cpe_flutter/screens/webinar_details/childCardOthers.dart';
import 'package:cpe_flutter/screens/webinar_details/pdf_preview_certificate.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../constant.dart';
import '../../rest_api.dart';
import 'childCardCompany.dart';
import 'childCardDescription.dart';
import 'childCardOverviewofTopics.dart';
import 'childCardPresenter.dart';
import 'childCardTestimonials.dart';
import 'childCardWhyShouldAttend.dart';
import 'evaluation_form.dart';

class WebinarDetailsNew extends StatefulWidget {
  WebinarDetailsNew(this.strWebinarTypeIntent, this.webinarId);

  // final String resultText;
  final String strWebinarTypeIntent;
  final int webinarId;

  @override
  _WebinarDetailsNewState createState() => _WebinarDetailsNewState(strWebinarTypeIntent, webinarId);
}

class _WebinarDetailsNewState extends State<WebinarDetailsNew> {
  _WebinarDetailsNewState(this.strWebinarTypeIntent, this.webinarId);

  // final String resultText;
  bool isUserLoggedIn = false;
  final String strWebinarTypeIntent;
  final int webinarId;

  String userToken = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var resp;
  var respStatus;
  var respMessage;
  var respSubMessage;
  var respTestimonials;

  String webinarThumb = '';

  var selectedCertificateType = '';

  var videoUrl = '',
      webinarTitle = '',
      webinarType = '',
      webinarDate = '',
      webinarStatus = '',
      status = '',
      startDate = '',
      startTime = '',
      strTimeZone = '',
      isCardSave = false,
      learningObjective = '',
      programDescription = '',
      whyShouldAttend = '',
      overviewOfTopic = '';

  var audience_title_lenght = 0;

  // var rating = 0.0;
  var rating = "0";
  var rating_count = 0;
  var respTestimonialsCount = 0;

  var play_time_duration;
  var scheduleID;
  var fee;

  var isPlaying = false;
  var reviewAnswered = false;

  var presenterName = '';

  bool isDetailsExpanded = false;
  bool isDescriptionExpanded = false;
  bool isOverviewOfTopicsExpanded = false;
  bool isWhyShouldAttendExpanded = false;
  bool isPresenterExpanded = false;
  bool isCompanyExpanded = false;
  bool isTestimonialsExpanded = false;
  bool isOthersExpanded = false;

  bool isOverViewOfTopicsVisible = false;
  bool isWhySholdAttendVisible = false;

  var presenterObj;
  var webDetailsObj;

  bool isLoaderShowing = false;
  bool isSingleStatusRow = true;

  FlickManager flickManager;
  Timer _timer;

  var watched = '';
  bool isOnCreate = true;

  bool isGuestMode = false;
  bool iswebinarFree = false;

  var isTextBasedWebinar = 0;

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics().setCurrentScreen(screenName: 'Webinar details screen');
    print('strWebinarTypeIntent : $strWebinarTypeIntent');
    checkForSP();
  }

  @override
  void dispose() {
    flickManager.dispose();
    _timer.cancel();
    stopBasicTimer();
    super.dispose();
  }

  void checkForSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool checkValue = sharedPreferences.getBool("check");

    isOnCreate = true;
    if (checkValue != null) {
      if (checkValue) {
        // Checkvalue == true..
        print('If State for check value : $checkValue');
        // get the value for the userToken from the sharedPrefs..
        userToken = sharedPreferences.getString("spToken");
        print('UserToken on checkForSP is : $userToken');

        // Take API call for webinar Details from here..
        setState(() {
          isGuestMode = false;
          isLoaderShowing = true;
        });
        webinarDetailsAPI();
      } else {
        // Chackvalue == false..
        print('Else State for check value : $checkValue');
        setState(() {
          isGuestMode = true;
          isLoaderShowing = true;
        });
        webinarDetailsAPI();
      }
    } else {
      print('checkValue is null handle here..');
      setState(() {
        isGuestMode = true;
        isLoaderShowing = true;
      });
      webinarDetailsAPI();
    }
  }

  void webinarDetailsAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      // Take API call from here..
      String strWebId = webinarId.toString();
      resp = await getWebinarDetails(userToken, strWebId);

      respStatus = resp['success'];
      respMessage = resp['message'];

      print('Response for webinar details is : $resp');

      if (respStatus) {
        setState(() {
          isLoaderShowing = false;
          webDetailsObj = resp['payload']['webinar_detail'];
          webinarThumb = webDetailsObj['webinar_thumbnail'];
          videoUrl = webDetailsObj['webinar_video_url'];
          webinarTitle = webDetailsObj['webinar_title'];
          webinarType = webDetailsObj['webinar_type'];
          webinarDate = webDetailsObj['webinar_date'];
          webinarStatus = webDetailsObj['webinar_status'];
          status = webDetailsObj['status'];
          startDate = webDetailsObj['start_date'];
          startTime = webDetailsObj['start_time'];
          strTimeZone = webDetailsObj['time_zone'];
          isCardSave = webDetailsObj['is_card_save'];
          whyShouldAttend = webDetailsObj['why_should_attend'];
          overviewOfTopic = webDetailsObj['overview_of_topic'];
          learningObjective = webDetailsObj['Learning_objective'];
          programDescription = webDetailsObj['program_description'];
          presenterObj = webDetailsObj['about_presententer'];
          play_time_duration = webDetailsObj['play_time_duration'];
          scheduleID = webDetailsObj['schedule_id'];
          fee = webDetailsObj['cost'].toString();
          audience_title_lenght = webDetailsObj['audiance_titles'].length;
          rating = webDetailsObj['rating'];
          rating_count = webDetailsObj['rating_user_count'];
          isTextBasedWebinar = webDetailsObj['is_text_based'];

          if (fee == '' || fee.toString().toLowerCase() == 'free') {
            iswebinarFree = true;
          } else {
            iswebinarFree = false;
          }
          print('Whole object for presenter is : $presenterObj');

          reviewAnswered = webDetailsObj['review_answered'];

          // Presenter and company data..
          presenterName = presenterObj['name'];

          respTestimonials = webDetailsObj['webinar_testimonial'];
          respTestimonialsCount = webDetailsObj['webinar_testimonial'].length;

          if (strWebinarTypeIntent == 'live') {
            isOverViewOfTopicsVisible = false;
            if (whyShouldAttend?.isEmpty) {
              isWhySholdAttendVisible = false;
            } else {
              isWhySholdAttendVisible = true;
            }
          }

          if (strWebinarTypeIntent == 'ON-DEMAND' || strWebinarTypeIntent.toLowerCase() == 'nano') {
            if (whyShouldAttend?.isEmpty) {
              isWhySholdAttendVisible = false;
            } else {
              isWhySholdAttendVisible = true;
            }

            if (overviewOfTopic?.isEmpty) {
              isOverViewOfTopicsVisible = false;
            } else {
              isOverViewOfTopicsVisible = true;
            }
          }

          // Logic for showing webinar Status on Single button or with multiple buttons..
          if (strWebinarTypeIntent == 'live') {
            // webinar type as LIVE Webinar..
          } else {
            // Webinar type as ON-DEMAND webinar..
            if (status.toLowerCase() == 'register') {
              isSingleStatusRow = true;
            } else if (status.toLowerCase() == 'watch now' ||
                status.toLowerCase() == 'resume watching' ||
                status.toLowerCase() == 'resume now' ||
                status.toLowerCase() == 'enrolled' ||
                status.toLowerCase() == 'quiz pending') {
              // Now here in this case we need to check for the isAnswered or not..
              // isAnswered = webDetailsObj['review_answered']
              print('Status for review answered is : $reviewAnswered');
              if (reviewAnswered) {
                isSingleStatusRow = true;
              } else {
                isSingleStatusRow = false;
              }
            }
          }
        });

        print('Webinar details response : Webinar thumbnail is : $webinarThumb');
        print('Webinar details response : Webinar video url is : $videoUrl');
      } else {
        Fluttertoast.showToast(
            msg: respMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(respMessage),
            duration: Duration(seconds: 3),
          ),
        );*/
        setState(() {
          isLoaderShowing = false;
        });
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );*/
      setState(() {
        isLoaderShowing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              // child: childWebinarStatus(status, isSingleStatusRow, webDetailsObj),
              child: Container(
                height: 16.0.w,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: isSingleStatusRow ? true : false,
                      child: GestureDetector(
                        onTap: () {
                          clickEventStatus();
                          print('Clicked on large button status');
                        },
                        child: Container(
                          height: 10.2.w,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: themeYellow,
                          ),
                          child: Center(
                            child: Text(
                              convertCamelCase(status),
                              style: kWebinarStatusBig,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSingleStatusRow ? false : true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print('Clicked on small button status');
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerFlickker(webDetailsObj),
                                  ),
                                );*/
                                if (status.toLowerCase() == 'resume watching' ||
                                    status.toLowerCase() == 'resume now' ||
                                    status.toLowerCase() == 'watch now') {
                                  funPlayVideo();
                                }
                              },
                              child: Container(
                                height: 10.2.w,
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: themeYellow,
                                ),
                                child: Center(
                                  child: Text(
                                    convertCamelCase(status),
                                    style: kWebinarStatusSmall,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print('Clicked on review question button');
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewQuestions(webDetailsObj['webinar_id']),
                                  ),
                                );*/
                                if (flickManager != null) {
                                  if (flickManager.flickVideoManager.isPlaying) {
                                    flickManager.flickControlManager.autoPause();
                                    // _timer.cancel();
                                    stopBasicTimer();
                                    isPlaying = false;
                                  }
                                }
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) => ReviewQuestions(webDetailsObj['webinar_id']),
                                  ),
                                )
                                    .then((_) {
                                  // Call setState() here or handle this appropriately
                                  checkForSP();
                                });
                              },
                              child: Container(
                                height: 10.2.w,
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: themeBlueLight,
                                ),
                                child: Center(
                                  child: Text(
                                    'Review Questions',
                                    style: kWebinarStatusSmall,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              bottom: 16.0.w,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*TopBar(
                      Colors.white,
                      'Webinar Details',
                    ),*/
                    Container(
                      height: 60.0,
                      width: double.infinity,
                      color: Color(0xFFF3F5F9),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0.0,
                            bottom: 0.0,
                            left: 0.0,
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  print('Clicked on the back icon..');
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 30.0.sp,
                                  height: double.infinity,
                                  color: Color(0xFFF3F5F9),
                                  child: Icon(
                                    FontAwesomeIcons.angleLeft,
                                    size: 12.0.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0.0,
                            bottom: 0.0,
                            right: 0.0,
                            left: 0.0,
                            child: Center(
                              child: Text(
                                'Webinar Details',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0.sp,
                                  fontFamily: 'Whitney Semi Bold',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0.0,
                            top: 0.0,
                            bottom: 0.0,
                            child: Container(
                              // color: Color(0xFFF3F5F9),
                              // width: 20.0.sp,
                              height: double.infinity,
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      print('Clicked on the share icon..');
                                      // Share.share('$strUrl');
                                      Share.share('${webDetailsObj['shareable_link']}');
                                    },
                                    child: Container(
                                      width: 30.0.sp,
                                      height: double.infinity,
                                      color: Color(0xFFF3F5F9),
                                      child: Icon(
                                        FontAwesomeIcons.shareAlt,
                                        size: 12.0.sp,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Notifications(),
                                        ),
                                      );
                                    },
                                    child: Visibility(
                                      visible: isGuestMode ? false : true,
                                      child: Container(
                                        width: 20.0.sp,
                                        height: double.infinity,
                                        color: Color(0xFFF3F5F9),
                                        child: Icon(
                                          FontAwesomeIcons.solidBell,
                                          size: 12.0.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Here the stack is used for controlling three view for the
                    // selfstudy thumb, selfstudy video player and live webinars..
                    Stack(
                      children: <Widget>[
                        // Container SelfStudy Thumb..
                        Visibility(
                          visible: ((strWebinarTypeIntent == 'ON-DEMAND' || strWebinarTypeIntent.toLowerCase() == 'nano') &&
                                  isTextBasedWebinar.compareTo(0) == 0
                              ? (!isPlaying ? true : false)
                              : false),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 51.0.w,
                                    width: double.infinity,
                                    color: Colors.blue,
                                    child: FadeInImage(
                                      placeholder: AssetImage('assets/webinar_placeholder.jpg'),
                                      image: NetworkImage(webinarThumb),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0.0,
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: GestureDetector(
                                      onTap: () {
                                        print('Click event on play button..: URL : $videoUrl');
                                        if (status.toLowerCase() == 'register') {
                                          showRegisterPopup();
                                        } else {
                                          funPlayVideo();
                                        }
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.solidPlayCircle,
                                        color: Colors.white,
                                        size: 80.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              /*WebinarTitle_OnDemand(webinarTitle),
                              // WebinarTitle_OnDemand('Test Title'),
                              WebinarSpeakerName_OnDemand(presenterName),*/
                              // WebinarSpeakerName_OnDemand('Test Presenter'),
                            ],
                          ),
                        ),
                        // Container SelfStudy Video player..
                        Visibility(
                          visible: ((strWebinarTypeIntent == 'ON-DEMAND' || strWebinarTypeIntent.toLowerCase() == 'nano') &&
                                  isTextBasedWebinar.compareTo(0) == 0
                              ? (isPlaying ? true : false)
                              : false),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 58.0.w,
                                width: double.infinity,
                                color: Colors.red,
                                child: FlickVideoPlayer(
                                  flickManager: flickManager,
                                ),
                              ),
                              // WebinarTitle_OnDemand(webinar_title),
                              /*WebinarTitle_OnDemand(webinarTitle),
                              // WebinarSpeakerName_OnDemand(presenter_name),
                              WebinarSpeakerName_OnDemand(presenterName),*/
                            ],
                          ),
                        ),
                        // Container Live Webinar
                        Visibility(
                          visible: (strWebinarTypeIntent == 'LIVE' || isTextBasedWebinar.compareTo(1) == 0 ? true : false),
                          child: Container(
                            // margin: EdgeInsets.only(top: 10.0),
                            // margin: EdgeInsets.fromLTRB(3.5.w, 0.0.h, 3.5.w, 2.0.h),
                            decoration: BoxDecoration(
                              // color: Color(0xFFFFC803),
                              // color: Color(0xFFFFC803),
                              color: setCardColor(ConstSignUp.detailsColorIndex),
                              /*borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),*/
                            ),
                            height: 60.0.w,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(18.0, 10.0, 30.0, 0),
                                        child: Text(
                                          // '${data['payload']['webinar'][index]['webinar_title']}',
                                          // '${list[index].webinarTitle}',
                                          // '${webDetailsObj['webinar_title']}',
                                          '$webinarTitle',
                                          style: TextStyle(
                                            fontFamily: 'Whitney Bold',
                                            fontSize: 16.0.sp,
                                            color: Colors.white,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(18.0, 10.0, 30.0, 0),
                                            child: Text(
                                              // '${data['payload']['webinar'][index]['speaker_name']}',
                                              // '${list[index].speakerName}',
                                              // '${webDetailsObj['about_presententer']['name']}',
                                              '$presenterName',
                                              style: TextStyle(
                                                fontFamily: 'Whitney Semi Bold',
                                                fontSize: 13.0.sp,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(18.0, 5.0, 30.0, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              // '${data['payload']['webinar'][index]['start_date']} - ${data['payload']['webinar'][index]['start_time']} - ${data['payload']['webinar'][index]['time_zone']}',
                                              // '$startDate - $startTime - $strTimeZone',
                                              // '${webDetailsObj['start_date']}',
                                              '${displayDateCondition()}',
                                              // '31 Dec, 02:30 PM EST',
                                              style: TextStyle(
                                                fontFamily: 'Whitney Semi Bold',
                                                fontSize: 13.0.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: rating == "0" || rating == "0.0" ? false : true,
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(left: 15.0, top: 7.0),
                                                width: 80.0.sp,
                                                child: RatingBar.readOnly(
                                                  initialRating: double.parse('$rating'),
                                                  size: 16.0.sp,
                                                  filledColor: themeBlueLight,
                                                  halfFilledColor: themeBlueLight,
                                                  emptyColor: Colors.white,
                                                  isHalfAllowed: true,
                                                  // halfFilledIcon: Icons.star_half,
                                                  halfFilledIcon: Icons.star,
                                                  filledIcon: Icons.star,
                                                  emptyIcon: Icons.star,
                                                  // emptyIcon: Icons.star_border,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6.0,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 5.0),
                                                child: Text(
                                                  '($rating_count)',
                                                  style: TextStyle(
                                                    fontFamily: 'Whitney Semi Bold',
                                                    fontSize: 13.0.sp,
                                                    // color: Color(0xFF1F2227),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 25.0.sp,
                                        width: 60.0.w,
                                        margin: EdgeInsets.only(left: 15.0, top: 10.0.sp),
                                        child: ListView.builder(
                                          // itemCount: webDetailsObj['audiance_titles'].lenght,
                                          itemCount: audience_title_lenght,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.only(right: 8.0),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  minWidth: 25.0.sp,
                                                ),
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp, top: 5.0.sp),
                                                  height: 25.0.sp,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    border: Border.all(
                                                      // color: Color(0xFFB4C2D3),
                                                      color: Colors.white,
                                                      width: 1.0,
                                                    ),
                                                    // color: Color(0xFFFFC803),
                                                    color: setCardColor(ConstSignUp.detailsColorIndex),
                                                  ),
                                                  child: Text(
                                                    '${webDetailsObj['audiance_titles'][index]}',
                                                    // 'Test Data',
                                                    style: TextStyle(
                                                      fontFamily: 'Whitney Medium',
                                                      fontSize: 11.0.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Image.asset(
                                    'assets/avatar_bottom_right.png',
                                    height: 36.0.w,
                                    width: 36.0.w,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Visibility(
                              visible: (strWebinarTypeIntent == 'ON-DEMAND' || strWebinarTypeIntent.toLowerCase() == 'nano') &&
                                      isTextBasedWebinar.compareTo(0) == 0
                                  ? true
                                  : false,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    WebinarTitle_OnDemand(webinarTitle),
                                    // WebinarTitle_OnDemand('Test Title'),
                                    WebinarSpeakerName_OnDemand(presenterName),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: (strWebinarTypeIntent == 'ON-DEMAND' || strWebinarTypeIntent.toLowerCase() == 'nano') &&
                                      isTextBasedWebinar.compareTo(0) == 0
                                  ? true
                                  : false,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Visibility(
                                      visible: rating == "0" || rating == "0.0" ? false : true,
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 10.0, top: 7.0),
                                              width: 80.0.sp,
                                              child: RatingBar.readOnly(
                                                initialRating: double.parse("$rating"),
                                                size: 16.0.sp,
                                                filledColor: themeYellow,
                                                halfFilledColor: themeBlue,
                                                emptyColor: themeBlue,
                                                isHalfAllowed: true,
                                                halfFilledIcon: Icons.star_half,
                                                // halfFilledIcon: Icons.star,
                                                filledIcon: Icons.star,
                                                // emptyIcon: Icons.star,
                                                emptyIcon: Icons.star_border,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6.0,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                '($rating_count)',
                                                style: TextStyle(
                                                  fontFamily: 'Whitney Semi Bold',
                                                  fontSize: 13.0.sp,
                                                  color: Color(0xFF1F2227),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25.0.sp,
                                      // width: 60.0.w,
                                      margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                                      child: ListView.builder(
                                        // itemCount: webDetailsObj['audiance_titles'].lenght,
                                        itemCount: audience_title_lenght,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(right: 8.0),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: 25.0.sp,
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.only(left: 8.0.sp, right: 8.0.sp, top: 5.0.sp),
                                                height: 25.0.sp,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30.0),
                                                  border: Border.all(
                                                    // color: Color(0xFFB4C2D3),
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                  // color: Color(0xFFFFC803),
                                                  color: Colors.white,
                                                ),
                                                child: Text(
                                                  '${webDetailsObj['audiance_titles'][index]}',
                                                  // 'Test Data',
                                                  style: TextStyle(
                                                    fontFamily: 'Whitney Medium',
                                                    fontSize: 11.0.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ExpandedCard(
                                // onPress: clickEvent(),
                                onPress: () {
                                  checkDetailsExpand();
                                },
                                strTitle: 'Details',
                                cardChild: childCardDetails(resp, isGuestMode, status),
                                flagExpand: isDetailsExpanded),
                            ExpandedCard(
                                onPress: () {
                                  checkDescriptionExpand();
                                },
                                strTitle: 'Description',
                                cardChild: childCardDescription(programDescription, learningObjective),
                                flagExpand: isDescriptionExpanded),
                            Visibility(
                              visible: isOverViewOfTopicsVisible ? true : false,
                              child: ExpandedCard(
                                  onPress: () {
                                    checkOverviewExpand();
                                  },
                                  strTitle: 'Overview of Topics',
                                  cardChild: childCardOverviewofTopics(overviewOfTopic),
                                  flagExpand: isOverviewOfTopicsExpanded),
                            ),
                            Visibility(
                              visible: isWhySholdAttendVisible ? true : false,
                              child: ExpandedCard(
                                  onPress: () {
                                    checkWhyShouldAttendExpand();
                                  },
                                  strTitle: 'Why should attend',
                                  cardChild: childCardWhyShouldAttend(whyShouldAttend),
                                  flagExpand: isWhyShouldAttendExpanded),
                            ),
                            ExpandedCard(
                                onPress: () {
                                  checkPresenterExpand();
                                },
                                strTitle: 'Presenter',
                                cardChild: childCardPresenter(
                                  presenterObj,
                                ),
                                flagExpand: isPresenterExpanded),
                            ExpandedCard(
                                onPress: () {
                                  checkCompanyExpand();
                                },
                                strTitle: 'Company',
                                cardChild: childCardCompany(presenterObj),
                                flagExpand: isCompanyExpanded),
                            Visibility(
                              visible: respTestimonialsCount.toString() == '0' ? false : true,
                              child: ExpandedCard(
                                  onPress: () {
                                    checkTestimonialsExpand();
                                  },
                                  strTitle: 'Testimonials',
                                  cardChild:
                                      // childCardTestimonials('Description Data Testimonials', respTestimonials, webDetailsObj['webinar_id'].toString()),
                                      childCardTestimonials('Description Data Testimonials', respTestimonials, webinarId.toString()),
                                  flagExpand: isTestimonialsExpanded),
                            ),
                            ExpandedCard(
                                onPress: () {
                                  checkOthersExpand();
                                },
                                strTitle: 'Others',
                                cardChild: childCardOthers(webDetailsObj),
                                flagExpand: isOthersExpanded),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              top: 100.0,
              child: Visibility(
                visible: isLoaderShowing ? true : false,
                child: SpinKitSample1(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkDetailsExpand() {
    setState(() {
      print('Clicked on Details');
      if (isDetailsExpanded) {
        setAllExpandedStateFalse();
      } else {
        setAllExpandedStateFalse();
        isDetailsExpanded = true;
      }
    });
  }

  checkDescriptionExpand() {
    setState(() {
      print('Clicked on Description');
      if (isDescriptionExpanded) {
        setAllExpandedStateFalse();
      } else {
        setAllExpandedStateFalse();
        isDescriptionExpanded = true;
      }
    });
  }

  checkOverviewExpand() {
    setState(() {
      print('Clicked on Overview');
      if (isOverviewOfTopicsExpanded) {
        setAllExpandedStateFalse();
      } else {
        setAllExpandedStateFalse();
        isOverviewOfTopicsExpanded = true;
      }
    });
  }

  checkWhyShouldAttendExpand() {
    setState(() {
      print('Clicked on Whoshould attend');
      if (isWhyShouldAttendExpanded) {
        setAllExpandedStateFalse();
      } else {
        setAllExpandedStateFalse();
        isWhyShouldAttendExpanded = true;
      }
    });
  }

  checkPresenterExpand() {
    setState(() {
      print('Clicked on Presenter');
      if (isPresenterExpanded) {
        setAllExpandedStateFalse();
      } else {
        setAllExpandedStateFalse();
        isPresenterExpanded = true;
      }
    });
  }

  checkCompanyExpand() {
    setState(() {
      print('Clicked on Details');
      if (isCompanyExpanded) {
        setAllExpandedStateFalse();
      } else {
        setAllExpandedStateFalse();
        isCompanyExpanded = true;
      }
    });
  }

  checkTestimonialsExpand() {
    setState(() {
      print('Clicked on Testimonials');
      if (isTestimonialsExpanded) {
        setAllExpandedStateFalse();
      } else {
        setAllExpandedStateFalse();
        isTestimonialsExpanded = true;
      }
    });
  }

  checkOthersExpand() {
    setState(() {
      print('Clicked on Others');
      if (isOthersExpanded) {
        setAllExpandedStateFalse();
      } else {
        setAllExpandedStateFalse();
        isOthersExpanded = true;
      }
    });
  }

  void setAllExpandedStateFalse() {
    setState(() {
      isDetailsExpanded = false;
      isDescriptionExpanded = false;
      isOverviewOfTopicsExpanded = false;
      isWhyShouldAttendExpanded = false;
      isPresenterExpanded = false;
      isCompanyExpanded = false;
      isTestimonialsExpanded = false;
      isOthersExpanded = false;
    });
  }

  void checkForVideoPlayerListener() {
    print('Method checkForVideoPlayerListener is called..');
    // flickManager.flickControlManager.seekTo(Duration(seconds: webDetailsObj['play_time_duration']));
    flickManager.flickControlManager.addListener(() {
      if (flickManager.flickVideoManager.isVideoInitialized) {
        print('Video is initialized..');
        // From here need to start the timer with condition that is video is playing or not??
        bool state = flickManager.flickVideoManager.isPlaying;
        if (flickManager.flickVideoManager.isPlaying) {
          print('Video player is playing $state');
          if (isOnCreate) {
            // flickManager.flickControlManager.seekTo(Duration(seconds: webDetailsObj['play_time_duration']));
            flickManager.flickControlManager.seekTo(Duration(seconds: play_time_duration));
            isOnCreate = false;
          }
          // stopBasicTimer();
          startBasicTimer();
        } else {
          print('Video player is on pause state $state');
          stopBasicTimer();
        }
      } else {
        print('Video is not initialized..');
        stopBasicTimer();
        // From here need to pause/stop the timer..
      }
    });
  }

  void startBasicTimer() {
    if (_timer != null) {
      // Do Nothing
      print('_timer != null');
    } else {
      print('_timer == null');
      _timer = Timer.periodic(Duration(seconds: 5), (timer) {
        var currentWatchTime = flickManager.flickVideoManager.videoPlayerValue.position.inSeconds.toString();

        var presentationDuration = webDetailsObj['duration'];
        // On Every time of tick take an API call for video-duration..
        videoDurationAPICall(
            webinarId.toString(),
            // finalCurrentDuration.toString(), presentationDuration.toString());
            currentWatchTime.toString(),
            presentationDuration.toString());
      });
    }
  }

  void stopBasicTimer() {
    _timer.cancel();
    _timer = null;
  }

  void videoDurationAPICall(String webinarId, String finalCurrentDuration, String presentationDuration) async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    print("webinar_id : $webinarId");
    print("Current Duration : $finalCurrentDuration");
    print("Presentation Duration : $presentationDuration");
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      var resp = await video_duration(userToken, webinarId, finalCurrentDuration, presentationDuration);

      print('Response for video Status api is : $resp');

      respStatus = resp['success'];
      respMessage = resp['message'];

      setState(() {
        ConstSignUp.isReloadWebinar = true;
      });

      if (respStatus) {
        if (resp['payload']['video_status']) {
          stopBasicTimer();
          // Here we need to take API call again as we need to update states for buttons..
          webinarDetailsAPI();
        } else {
          setState(() {
            watched = resp['payload']['watched'];
          });
        }
      } else {
        Fluttertoast.showToast(
            msg: respMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('$respMessage'),
            duration: Duration(seconds: 3),
          ),
        );*/
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );*/
    }
  }

  // displayDateCondition(index) {
  displayDateCondition() {
    // String strStartDate = list[index].startDate;
    String day = "";
    String month = "";
    String year = "";

    String updatedDate = "";
    if (startDate == "") {
      updatedDate = "";
    } else {
      var split = startDate.split('-');
      day = split[2];
      month = split[1];
      year = split[0];

      print('Day : $day');
      print('Month : $month');
      print('Year : $year');

      switch (month) {
        case "01":
          {
            month = "Jan";
          }
          break;

        case "02":
          {
            month = "Feb";
          }
          break;

        case "03":
          {
            month = "Mar";
          }
          break;

        case "04":
          {
            month = "Apr";
          }
          break;

        case "05":
          {
            month = "May";
          }
          break;

        case "06":
          {
            month = "June";
          }
          break;

        case "07":
          {
            month = "July";
          }
          break;

        case "08":
          {
            month = "Aug";
          }
          break;

        case "09":
          {
            month = "Sep";
          }
          break;

        case "10":
          {
            month = "Oct";
          }
          break;

        case "11":
          {
            month = "Nov";
          }
          break;

        case "12":
          {
            month = "Dec";
          }
          break;
      }
      updatedDate =
          // '$day $month $year - ${data['payload']['webinar'][index]['start_time']} - ${data['payload']['webinar'][index]['time_zone']}';
          // '$day $month $year - $startTime - $strTimeZone';
          '$month $day, $year | $startTime $strTimeZone';
    }

    return (updatedDate);
  }

  void launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  void clickEventStatus() {
    if (status.toLowerCase() == 'register webinar' || status.toLowerCase() == 'register') {
      if (isGuestMode) {
        // Need to show login popup to user in case if we found the guest mode..
        showLoginPopup();
      } else {
        funRegisterWebinar();
      }
    } else if (status.toLowerCase() == 'resume watching' || status.toLowerCase() == 'resume now' || status.toLowerCase() == 'watch now') {
      funPlayVideo();
    } else if (status.toLowerCase() == 'quiz pending') {
      funRedirectQuizPending();
    } else if (status.toLowerCase() == 'pending evaluation' || status.toLowerCase() == 'pending evalution') {
      funRedirectEvaluationForm();
    } else if (status.toLowerCase() == 'completed') {
      // Have to show alert popup for giving explanation regarding generating certificate..
      if (strWebinarTypeIntent.toLowerCase() == 'live') {
        // Do nothing for this case...
      } else {
        showCompletedPopUp();
      }
    } else if (status.toLowerCase() == 'my certificate') {
      // Check for the number of certificates here..
      // If we have single cerificate then redirect to certificate preview screen..
      // Else have to open the bottom sheet popup and make user will select for the certificate and based on that have to perform redirection..
      if (webDetailsObj['my_certificate_links'].length > 1) {
        print('There are multiple certificates..');
        showCertificateList();
      } else {
        print('There is only single certificate..');
        if (webDetailsObj['my_certificate_links'][0]['certificate_link'] == '') {
          Fluttertoast.showToast(
              msg: strCouldntFindCertificateLink,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: toastBackgroundColor,
              textColor: toastTextColor,
              fontSize: 16.0);
          /*_scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(strCouldntFindCertificateLink),
              duration: Duration(seconds: 3),
            ),
          );*/
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CertificatePdfPreview('${webDetailsObj['my_certificate_links'][0]['certificate_link']}',
                  '${webDetailsObj['webinar_title']}', '${webDetailsObj['webinar_type']}'),
            ),
          );
        }
      }
    } else if (status.toLowerCase() == 'join webinar' || status.toLowerCase() == 'in progress') {
      if (isGuestMode) {
        showLoginPopup();
      } else {
        if (webDetailsObj['zoom_link_status']) {
          setState(() {
            ConstSignUp.isReloadWebinar = true;
          });
          funRedirectJoinWebinar();
        } else {
          showDialogJoinWebinar();
        }
      }
    } else {
      print('Went to else part..');
    }
  }

  void funPlayVideo() {
    print('funPlayVideo is called');
    setState(() {
      isPlaying = true;
      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(videoUrl),
      );
      checkForVideoPlayerListener();
    });
  }

  void funRedirectQuizPending() {
    print('Status is QUIZ pending');
    /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FinalQuizScreen(webDetailsObj['webinar_id']),
                              ),
                            );*/
    if (flickManager != null) {
      if (flickManager.flickVideoManager.isPlaying) {
        flickManager.flickControlManager.autoPause();
        // _timer.cancel();
        stopBasicTimer();
        isPlaying = false;
      }
    }
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => FinalQuizScreen(webDetailsObj['webinar_id']),
      ),
    )
        .then((_) {
      // Call setState() here or handle this appropriately
      checkForSP();
    });
  }

  void funRedirectEvaluationForm() {
    // Now first we need to take and API call for the pending evaluation form link..
    // If we get the evaluation form link then have to redirect to the eavaluation form screen with inline data as form link
    APIEvaluationFormLink();
  }

  void funRedirectJoinWebinar() {
    // here we need to check for the zoom_link_status and if not then show the pop-up message..
    // If we have that status then redirect to that link from here..
    var url =
        "https://zoom.us/w/92056600703?tk=xzhOVl9nDeacxlQXdHHZ4OpFYYp3tD6YhJtS3HqU2ks.DQIAAAAVbwBAfxZjVjZiamV0VlRwaVJTUm95cnJqNFFnAAAAAAAAAAAAAAAAAAAAAAAAAAAA&uuid=WN_C16AFWZcR3SwGA5Gbd0XSQ";
    launchURL(url);
    // can't launch url, there is some error
    throw "Could not launch $url";
  }

  void funRegisterWebinar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    if (checkValue != null) {
      setState(() {
        isLoaderShowing = true;
      });

      if (checkValue) {
        setState(() {
          isUserLoggedIn = true;
        });
        registerWebinarCheckPrice();
        // Here we need to take user register webinar api..
      } else {
        // this.getDataWebinarList('$_authToken', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
        setState(() {
          isUserLoggedIn = false;
        });
        showLoginPopup();
      }
    } else {
      // this.getDataWebinarList('', '$start', '10', '', '', '$searchKey', '$strWebinarType', '', '$strFilterPrice');
      // print('Entered init else part for the checkforSP');
      setState(() {
        isUserLoggedIn = false;
      });
      showLoginPopup();
    }
  }

  void showLoginPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogTwo(
            "Login?",
            "For registering this webinar you must need to login first",
            "Login",
            "cancel",
            () {
              setState(() {
                ConstSignUp.isGuestRegisterWebinar = true;
                ConstSignUp.strWebinarId = webDetailsObj['webinar_id'].toString();
                ConstSignUp.strScheduleId = webDetailsObj['schedule_id'].toString();
                ConstSignUp.strWebinarType = strWebinarTypeIntent.toString();
                ConstSignUp.isFreeWebinar = iswebinarFree;
                ConstSignUp.strFee = fee.toString();
              });
              logoutUser();
            },
            () {
              Navigator.pop(context);
            },
          );
        });
    /*showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Login?', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text('For registering this webinar you must need to login first'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  // this line exits the app.
                  setState(() {
                    ConstSignUp.isGuestRegisterWebinar = true;
                    ConstSignUp.strWebinarId = webDetailsObj['webinar_id'].toString();
                    ConstSignUp.strScheduleId = webDetailsObj['schedule_id'].toString();
                    ConstSignUp.strWebinarType = strWebinarTypeIntent.toString();
                    ConstSignUp.isFreeWebinar = iswebinarFree;
                    ConstSignUp.strFee = fee.toString();
                  });
                  logoutUser();
                },
                child: new Text('Login', style: new TextStyle(fontSize: 18.0)),
              ),
              new FlatButton(
                onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                child: new Text('Cancel', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;*/
  }

  void showRegisterPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            "Register?",
            "For watching this webinar you need to register this webinar first.",
            "Ok",
            () {
              Navigator.pop(context);
            },
          );
        });
    /*showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Register?', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text('For watching this webinar you need to register this webinar first.'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                child: new Text('Ok', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;*/
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Login(false),
          // builder: (context) => IntroScreen(),
        ),
        (Route<dynamic> route) => false);
  }

  void registerWebinarCheckPrice() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      if (strWebinarTypeIntent.toLowerCase() == 'live') {
        // if (webDetailsObj.fee == 'FREE' || webDetailsObj.fee == '') {
        if (fee == 'FREE' || fee == '') {
          registerWebinarCall('Bearer $userToken', webinarId.toString(), scheduleID.toString());
        } else {
          setState(() {
            ConstSignUp.isRegisterWebinarFromDetails = true;
          });
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => GuestCardFrag(fee, webinarId, strWebinarTypeIntent, scheduleID.toString()),
            ),
          )
              .then((_) {
            checkForSP();
          });
        }
      } else if (strWebinarTypeIntent.toLowerCase() == 'self_study' ||
          strWebinarTypeIntent.toLowerCase() == 'on-demand' ||
          strWebinarTypeIntent.toLowerCase() == 'nano') {
        // if (webDetailsObj.fee == 'FREE' || webDetailsObj.fee == '') {
        if (fee == 'FREE' || fee == '') {
          print('User token while register is : $userToken');
          registerWebinarCall('Bearer $userToken', webinarId.toString(), scheduleID.toString());
        } else {
          setState(() {
            ConstSignUp.isRegisterWebinarFromDetails = true;
          });
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => GuestCardFrag(fee, webinarId, strWebinarTypeIntent, scheduleID.toString()),
            ),
          )
              .then((_) {
            checkForSP();
          });
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );*/
      setState(() {
        isLoaderShowing = false;
      });
    }
  }

  void registerWebinarCall(String userToken, String webinarId, String scheduleID) async {
    setState(() {
      isLoaderShowing = true;
    });

    var resp = await registerWebinarAPI(userToken, webinarId, scheduleID);
    print('Response is : $resp');

    respStatus = resp['success'];
    respMessage = resp['message'];
    respSubMessage = resp['payload']['sub_message'];
    setState(() {
      isLoaderShowing = false;
      ConstSignUp.isReloadWebinar = true;
    });

    if (respStatus) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogRegister(
              "$respMessage",
              "$respSubMessage",
              "CONTINUE",
              () {
                Navigator.pop(context);
                checkForSP();
              },
            );
          });
      /*Fluttertoast.showToast(
          msg: respMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      */ /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(respMessage),
          duration: Duration(seconds: 5),
        ),
      );*/ /*
      checkForSP();*/
    } else {
      Fluttertoast.showToast(
          msg: respMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(respMessage),
          duration: Duration(seconds: 5),
        ),
      );*/
    }
  }

  void showDialogJoinWebinar() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            "Join Webinar",
            "${webDetailsObj['zoom_link_verification_message']}",
            "Ok",
            () {
              Navigator.pop(context);
            },
          );
        });
    /*showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Join Webinar', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text('${webDetailsObj['zoom_link_verification_message']}'),
            actions: <Widget>[
              */ /*new FlatButton(
                onPressed: () {
                  // this line exits the app.
                  logoutUser();
                },
                child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
              ),*/ /*
              new FlatButton(
                onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                child: new Text('Ok', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;*/
  }

  void showCompletedPopUp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            "Completed",
            "You have successfully completed your webinar, your certificate will generate in few mins. Please come again and check your certificate"
                " for this webinar",
            "Ok",
            () {
              Navigator.pop(context);
            },
          );
        });
    /*showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Completed', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text('You have successfully completed your webinar, your certificate will generate in few mins. Please come again and check '
                'your certificate for this webinar'),
            actions: <Widget>[
              */ /*new FlatButton(
                onPressed: () {
                  // this line exits the app.
                  logoutUser();
                },
                child: new Text('Yes', style: new TextStyle(fontSize: 18.0)),
              ),*/ /*
              new FlatButton(
                onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                child: new Text('Ok', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;*/
  }

  void APIEvaluationFormLink() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoaderShowing = true;
      });

      var resp = await evaluationFormLink('Bearer $userToken', webinarId.toString());

      // var resp = await evaluationFormLink(userToken, webinarId.toString());
      print('Response is : $resp');

      respStatus = resp['success'];
      respMessage = resp['message'];

      setState(() {
        isLoaderShowing = false;
        ConstSignUp.isReloadWebinar = true;
      });

      var evaluationLink = resp['payload']['link'].toString();
      if (flickManager != null) {
        if (flickManager.flickVideoManager.isPlaying) {
          flickManager.flickControlManager.autoPause();
          // _timer.cancel();
          stopBasicTimer();
          isPlaying = false;
        }
      }
      Navigator.of(context)
          .push(
        MaterialPageRoute(
          builder: (context) => EvaluationForm(evaluationLink),
        ),
      )
          .then((_) {
        // Call setState() here or handle this appropriately
        checkForSP();
      });
    } else {
      Fluttertoast.showToast(
          msg: "Please check your internet connectivity and try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: toastBackgroundColor,
          textColor: toastTextColor,
          fontSize: 16.0);
      /*_scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );*/
      setState(() {
        isLoaderShowing = false;
      });
    }
  }

  void showCertificateList() {
    setState(() {
      selectedCertificateType = '';
    });

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return Container(
                height: 60.0.w,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 17.0.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 20.0.w,
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: kDateTestimonials,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50.0.w,
                            child: Center(
                              child: Text(
                                'Certificates List',
                                style: kOthersTitle,
                              ),
                            ),
                          ),
                          Container(
                            width: 20.0.w,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        // itemCount: orgSizeList.length,
                        itemCount: webDetailsObj['my_certificate_links'].length,
                        itemBuilder: (context, pos) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 15.0.w,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  clickEventCertificateType(pos);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                decoration: BoxDecoration(
                                  color: selectedCertificateType == webDetailsObj['my_certificate_links'][pos]['certificate_type']
                                      ? themeYellow
                                      : testColor,
                                  // color: themeYellow,
                                  borderRadius: BorderRadius.circular(7.0),
                                  // color: Colors.teal,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          // list[index].shortTitle,
                                          // orgSizeList[index],
                                          webDetailsObj['my_certificate_links'][pos]['certificate_type'],
                                          textAlign: TextAlign.start,
                                          style: kDataSingleSelectionBottomNav,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void clickEventCertificateType(int pos) {
    setState(() {
      selectedCertificateType = webDetailsObj['my_certificate_links'][pos]['certificate_type'].toString();
      Navigator.pop(context);

      if (webDetailsObj['my_certificate_links'][pos]['certificate_link'] == '') {
        Fluttertoast.showToast(
            msg: strCouldntFindCertificateLink,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: toastBackgroundColor,
            textColor: toastTextColor,
            fontSize: 16.0);
        /*_scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(strCouldntFindCertificateLink),
            duration: Duration(seconds: 3),
          ),
        );*/
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CertificatePdfPreview(
              '${webDetailsObj['my_certificate_links'][pos]['certificate_link']}',
              '${webDetailsObj['webinar_title']}',
              '${webDetailsObj['my_certificate_links'][pos]['certificate_type']}',
            ),
          ),
        );
      }
    });
  }

  setCardColor(int index) {
    if (index > 9) {
      if (index % 10 == 0) {
        return bgColor0;
      } else if (index % 10 == 1) {
        return bgColor1;
      } else if (index % 10 == 2) {
        return bgColor2;
      } else if (index % 10 == 3) {
        return bgColor3;
      } else if (index % 10 == 4) {
        return bgColor4;
      } else if (index % 10 == 5) {
        return bgColor5;
      } else if (index % 10 == 6) {
        return bgColor6;
      } else if (index % 10 == 7) {
        return bgColor7;
      } else if (index % 10 == 8) {
        return bgColor8;
      } else if (index % 10 == 9) {
        return bgColor9;
      }
    } else {
      if (index == 0) {
        return bgColor0;
      } else if (index == 1) {
        return bgColor1;
      } else if (index == 2) {
        return bgColor2;
      } else if (index == 3) {
        return bgColor3;
      } else if (index == 4) {
        return bgColor4;
      } else if (index == 5) {
        return bgColor5;
      } else if (index == 6) {
        return bgColor6;
      } else if (index == 7) {
        return bgColor7;
      } else if (index == 8) {
        return bgColor8;
      } else if (index == 9) {
        return bgColor9;
      }
    }
  }
}
