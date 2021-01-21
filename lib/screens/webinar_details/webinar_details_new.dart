import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/TopBar.dart';
import 'package:cpe_flutter/constant.dart';
import 'package:cpe_flutter/screens/webinar_details/ExpandedCard.dart';
import 'package:cpe_flutter/screens/webinar_details/WebinarSpeakerName_OnDemand.dart';
import 'package:cpe_flutter/screens/webinar_details/WebinarTitleOnDemand.dart';
import 'package:cpe_flutter/screens/webinar_details/childCardDetails.dart';
import 'package:cpe_flutter/screens/webinar_details/childCardOthers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  _WebinarDetailsNewState createState() =>
      _WebinarDetailsNewState(strWebinarTypeIntent, webinarId);
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
      overviewOfTopic = '',
      camelCaseStatus = '';

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
  bool isSingleStatusRow = false;

  @override
  void initState() {
    super.initState();
    checkForSP();
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
    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
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
            } else if (status.toLowerCase() == 'watch now' ||
                status.toLowerCase() == 'resume watching' ||
                status.toLowerCase() == 'resume now') {
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

        print(
            'Webinar details response : Webinar thumbnail is : $webinarThumb');
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
          content:
              Text("Please check your internet connectivity and try again"),
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
              child:
                  childWebinarStatus(status, isSingleStatusRow, webDetailsObj),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              bottom: 60.0,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TopBar(
                      Colors.white,
                      'Webinar Details',
                    ),
                    // Here the stack is used for controlling three view for the
                    // selfstudy thumb, selfstudy video player and live webinars..
                    Stack(
                      children: <Widget>[
                        // Container SelfStudy Thumb..
                        Visibility(
                          visible: (strWebinarTypeIntent == 'ON-DEMAND'
                              ? (!isPlaying ? true : false)
                              : false),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 200.0,
                                    width: double.infinity,
                                    color: Colors.blue,
                                    child: FadeInImage(
                                      placeholder: AssetImage(
                                          'assets/webinar_placeholder.jpg'),
                                      image: NetworkImage(webinarThumb),
                                      fit: BoxFit.fill,
                                    ),
                                    /*child: (webinar_thumb?.isEmpty
                                        ? Image.asset(
                                            'assets/webinar_placeholder.jpg',
                                            fit: BoxFit.fill,
                                          )
                                        : Image.network(
                                            webinar_thumb,
                                            fit: BoxFit.fill,
                                          )),*/
                                  ),
                                  Positioned(
                                    top: 0.0,
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: GestureDetector(
                                      onTap: () {
                                        print('Click event on play button..');
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.playCircle,
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
                        // Container SelfStudy Video
                        Visibility(
                          visible: (strWebinarTypeIntent == 'ON-DEMAND'
                              ? (isPlaying ? true : false)
                              : false),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 200.0,
                                width: double.infinity,
                                color: Colors.red,
                              ),
                              // WebinarTitle_OnDemand(webinar_title),
                              WebinarTitle_OnDemand('strTestTitle'),
                              // WebinarSpeakerName_OnDemand(presenter_name),
                              WebinarSpeakerName_OnDemand(
                                  'strTestPresenterName'),
                            ],
                          ),
                        ),
                        // Container Live Webinar
                        Visibility(
                          visible:
                              (strWebinarTypeIntent == 'live' ? true : false),
                          child: Container(
                            height: 200.0,
                            width: double.infinity,
                            color: Colors.black,
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
                                cardChild: childCardDescription(
                                    programDescription, learningObjective),
                                flagExpand: isDescriptionExpanded),
                            Visibility(
                              visible: isOverViewOfTopicsVisible ? true : false,
                              child: ExpandedCard(
                                  onPress: () {
                                    checkOverviewExpand();
                                  },
                                  strTitle: 'Overview of Topics',
                                  cardChild: childCardOverviewofTopics(
                                      overviewOfTopic),
                                  flagExpand: isOverviewOfTopicsExpanded),
                            ),
                            Visibility(
                              visible: isWhySholdAttendVisible ? true : false,
                              child: ExpandedCard(
                                  onPress: () {
                                    checkWhyShouldAttendExpand();
                                  },
                                  strTitle: 'Why should attend',
                                  cardChild:
                                      childCardWhyShouldAttend(whyShouldAttend),
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
                                cardChild: childCardTestimonials(
                                    'Description Data Testimonials',
                                    respTestimonials),
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
}

class childWebinarStatus extends StatelessWidget {
  childWebinarStatus(this.status, this.isSingleStatusRow, this.webDetailsObj);

  final String status;
  final bool isSingleStatusRow;
  final webDetailsObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Visibility(
            visible: isSingleStatusRow ? true : false,
            child: Container(
              height: 40.0,
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
          Visibility(
            visible: isSingleStatusRow ? false : true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40.0,
                    margin: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 10.0, right: 5.0),
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
                Expanded(
                  child: Container(
                    height: 40.0,
                    margin: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 10.0, left: 5.0),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
