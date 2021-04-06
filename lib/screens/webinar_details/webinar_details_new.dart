import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/screens/final_quiz/final_quiz_screen.dart';
import 'package:cpe_flutter/screens/profile/notification.dart';
import 'package:cpe_flutter/screens/review_questions/review_questions.dart';
import 'package:cpe_flutter/screens/video_player/videoPlayer.dart';
import 'package:cpe_flutter/screens/webinar_details/ExpandedCard.dart';
import 'package:cpe_flutter/screens/webinar_details/WebinarSpeakerName_OnDemand.dart';
import 'package:cpe_flutter/screens/webinar_details/WebinarTitleOnDemand.dart';
import 'package:cpe_flutter/screens/webinar_details/childCardDetails.dart';
import 'package:cpe_flutter/screens/webinar_details/childCardOthers.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../constant.dart';
import '../../rest_api.dart';
import 'childCardCompany.dart';
import 'childCardDescription.dart';
import 'childCardOverviewofTopics.dart';
import 'childCardPresenter.dart';
import 'childCardTestimonials.dart';
import 'childCardWhyShouldAttend.dart';

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
  final String strWebinarTypeIntent;
  final int webinarId;

  String userToken;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var resp;
  var respStatus;
  var respMessage;
  var respTestimonials;

  String webinarThumb = '';

  var videoUrl = '',
      webinarTitle = '',
      webinarType = '',
      webinarDate = '',
      webinarStatus = '',
      status = '',
      startDate = '',
      startTime = '',
      isCardSave = false,
      learningObjective = '',
      programDescription = '',
      whyShouldAttend = '',
      overviewOfTopic = '';

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

  @override
  void initState() {
    super.initState();
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

    if (checkValue) {
      // Checkvalue == true..
      print('If State for check value : $checkValue');
      // get the value for the userToken from the sharedPrefs..
      userToken = sharedPreferences.getString("spToken");
      print('UserToken on checkForSP is : $userToken');

      // Take API call for webinar Details from here..
      setState(() {
        isLoaderShowing = true;
      });
      webinarDetailsAPI();
    } else {
      // Chackvalue == false..
      print('Else State for check value : $checkValue');
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
          isCardSave = webDetailsObj['is_card_save'];
          whyShouldAttend = webDetailsObj['why_should_attend'];
          overviewOfTopic = webDetailsObj['overview_of_topic'];
          learningObjective = webDetailsObj['Learning_objective'];
          programDescription = webDetailsObj['program_description'];
          presenterObj = webDetailsObj['about_presententer'];
          print('Whole object for presenter is : $presenterObj');

          reviewAnswered = webDetailsObj['review_answered'];

          // Presenter and company data..
          presenterName = presenterObj['name'];

          respTestimonials = webDetailsObj['webinar_testimonial'];

          if (strWebinarTypeIntent == 'live') {
            isOverViewOfTopicsVisible = false;
            if (whyShouldAttend?.isEmpty) {
              isWhySholdAttendVisible = false;
            } else {
              isWhySholdAttendVisible = true;
            }
          }

          if (strWebinarTypeIntent == 'ON-DEMAND') {
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
            } else if (status.toLowerCase() == 'watch now' || status.toLowerCase() == 'resume watching' || status.toLowerCase() == 'resume now') {
              // Now here in this case we need to check for the isAnswered or not..
              // isAnswered = webDetailsObj['review_answered']
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
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(respMessage),
            duration: Duration(seconds: 3),
          ),
        );
        setState(() {
          isLoaderShowing = false;
        });
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );
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
                          print('Clicked on large button status');
                          if (status.toLowerCase() == 'quiz pending') {
                            print('Status is QUIZ pending');
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FinalQuizScreen(webDetailsObj['webinar_id']),
                              ),
                            );*/
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
                          } else if (status.toLowerCase() == 'Register Webinar') {
                            print('Status is register webinar');
                          } else {
                            print('Went to else part..');
                          }

                          /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerFlickker(webDetailsObj),
                    ),
                  );*/
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerFlickker(webDetailsObj),
                                  ),
                                );
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
                                    'Review Question',
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
                          visible: (strWebinarTypeIntent == 'ON-DEMAND' ? (!isPlaying ? true : false) : false),
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
                                        setState(() {
                                          isPlaying = true;
                                          flickManager = FlickManager(
                                            videoPlayerController: VideoPlayerController.network(videoUrl),
                                          );
                                          checkForVideoPlayerListener();
                                        });
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
                              WebinarTitle_OnDemand(webinarTitle),
                              // WebinarTitle_OnDemand('Test Title'),
                              WebinarSpeakerName_OnDemand(presenterName),
                              // WebinarSpeakerName_OnDemand('Test Presenter'),
                            ],
                          ),
                        ),
                        // Container SelfStudy Video player..
                        Visibility(
                          visible: (strWebinarTypeIntent == 'ON-DEMAND' ? (isPlaying ? true : false) : false),
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
                              WebinarTitle_OnDemand(webinarTitle),
                              // WebinarSpeakerName_OnDemand(presenter_name),
                              WebinarSpeakerName_OnDemand(presenterName),
                            ],
                          ),
                        ),
                        // Container Live Webinar
                        Visibility(
                          visible: (strWebinarTypeIntent == 'LIVE' ? true : false),
                          child: Container(
                            // margin: EdgeInsets.only(top: 10.0),
                            // margin: EdgeInsets.fromLTRB(3.5.w, 0.0.h, 3.5.w, 2.0.h),
                            decoration: BoxDecoration(
                              // color: Color(0xFFFFC803),
                              color: Color(0xFFFFC803),
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
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(18.0, 10.0, 30.0, 0),
                                        child: Flexible(
                                          child: Text(
                                            // '${data['payload']['webinar'][index]['webinar_title']}',
                                            // '${list[index].webinarTitle}',
                                            // '${webDetailsObj['webinar_title']}',
                                            '$webinarTitle',
                                            style: TextStyle(
                                              fontFamily: 'Whitney Bold',
                                              fontSize: 16.0.sp,
                                              color: Colors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(18.0, 10.0, 30.0, 0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                // '${data['payload']['webinar'][index]['speaker_name']}',
                                                // '${list[index].speakerName}',
                                                // '${webDetailsObj['about_presententer']['name']}',
                                                '$presenterName',
                                                style: TextStyle(
                                                  fontFamily: 'Whitney Semi Bold',
                                                  fontSize: 13.0.sp,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(18.0, 5.0, 30.0, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              // '${data['payload']['webinar'][index]['start_date']} - ${data['payload']['webinar'][index]['start_time']} - ${data['payload']['webinar'][index]['time_zone']}',
                                              // '${webDetailsObj['start_date']}',
                                              // '${displayDateCondition(index)}',
                                              '31 Dec, 02:30 PM EST',
                                              style: TextStyle(
                                                fontFamily: 'Whitney Semi Bold',
                                                fontSize: 13.0.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
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
                          children: <Widget>[
                            ExpandedCard(
                                // onPress: clickEvent(),
                                onPress: () {
                                  checkDetailsExpand();
                                },
                                strTitle: 'Details',
                                cardChild: childCardDetails(resp),
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
                            ExpandedCard(
                                onPress: () {
                                  checkTestimonialsExpand();
                                },
                                strTitle: 'Testimonials',
                                cardChild:
                                    // childCardTestimonials('Description Data Testimonials', respTestimonials, webDetailsObj['webinar_id'].toString()),
                                    childCardTestimonials('Description Data Testimonials', respTestimonials, webinarId.toString()),
                                flagExpand: isTestimonialsExpanded),
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
            flickManager.flickControlManager.seekTo(Duration(seconds: webDetailsObj['play_time_duration']));
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

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      var resp = await video_duration(userToken, webinarId, finalCurrentDuration, presentationDuration);

      print('Response for video Status api is : $resp');

      respStatus = resp['success'];
      respMessage = resp['message'];

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
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('$respMessage'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
