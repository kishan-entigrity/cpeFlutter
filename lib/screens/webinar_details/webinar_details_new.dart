import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/TopBar.dart';
import 'package:cpe_flutter/screens/webinar_details/ExpandedCard.dart';
import 'package:cpe_flutter/screens/webinar_details/WebinarSpeakerName_OnDemand.dart';
import 'package:cpe_flutter/screens/webinar_details/WebinarTitleOnDemand.dart';
import 'package:cpe_flutter/screens/webinar_details/childCardDetails.dart';
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
  var cost,
      credit = '',
      ceCredit = '',
      cpeCredit = '',
      cfpCredit = '',
      cpdCredit = '',
      duration = 0,
      irsCourseId = '',
      ctecCourseId = '',
      subjectArea = '',
      courseLevel = '',
      insructionalMethod = '',
      prerequisites = '',
      advancePreparation = '',
      recordDate = '',
      publishedDate = '',
      presentationHandsout = '',
      keyTerms = '',
      instructionalDocuments = '',
      whoShouldAttend = '';

  var videoUrl = '',
      webinarTitle = '',
      webinarType = '',
      webinarDate = '',
      webinarStatus = '',
      startDate = '',
      startTime = '',
      isCardSave = false,
      learningObjective = '',
      programDescription = '',
      whyShouldAttend = '',
      overviewOfTopic = '';

  var isPlaying = false;

  var presenterImage = '',
      presenterName = '',
      presenterQualification = '',
      presenterDesgnination = '',
      presenterDescription = '',
      presenterCompanyName = '',
      presenterCompanyLogo = '',
      presenterCompanyWebsite = '',
      presenterCompanyDesc = '';

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
          startDate = webDetailsObj['start_date'];
          startTime = webDetailsObj['start_time'];
          isCardSave = webDetailsObj['is_card_save'];
          whyShouldAttend = webDetailsObj['why_should_attend'];
          overviewOfTopic = webDetailsObj['overview_of_topic'];
          learningObjective = webDetailsObj['Learning_objective'];
          programDescription = webDetailsObj['program_description'];
          presenterObj = webDetailsObj['about_presententer'];
          print('Whole object for presenter is : $presenterObj');

          // Presenter and company data..
          presenterName = presenterObj['name'];
          presenterImage = presenterObj['presenter_image'];
          presenterQualification = presenterObj['qualification'];
          presenterDesgnination = presenterObj['desgnination'];
          presenterCompanyName = presenterObj['company_name'];
          presenterDescription = presenterObj['speaker_desc'];
          presenterCompanyLogo = presenterObj['company_logo'];
          presenterCompanyWebsite = presenterObj['company_website'];
          presenterCompanyDesc = presenterObj['company_desc'];

          // webinar details data..
          cost = webDetailsObj['cost'];
          credit = webDetailsObj['credit'];
          ceCredit = webDetailsObj['ce_credit'];
          cfpCredit = webDetailsObj['cfp_credit'];
          cpdCredit = webDetailsObj['cpd_credit'];
          irsCourseId = webDetailsObj['course_id'];
          ctecCourseId = webDetailsObj['ctec_course_id'];
          duration = webDetailsObj['duration'];
          subjectArea = webDetailsObj['subject_area'];
          courseLevel = webDetailsObj['course_level'];
          insructionalMethod = webDetailsObj['instructional_method'];
          prerequisites = webDetailsObj['prerequisite'];
          advancePreparation = webDetailsObj['advance_preparation'];
          recordDate = webDetailsObj['recorded_date'];
          publishedDate = webDetailsObj['published_date'];
          // presentationHandsout = webDetailsObj['presentationHandsout'];
          // keyTerms = webDetailsObj['key_terms'];
          // instructionalDocuments = webDetailsObj['instructional_docuement'];
          // whoShouldAttend = webDetailsObj['who_should_attend'];

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

          /*_controller = VideoPlayerController.network(
            // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            video_url,
            // 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
            // 'https://player.vimeo.com//play//1624977747?s=359330135_1609206521_7d8ca704163f13f5a50fddb50b769445&loc=external&context=Vimeo%5CController%5CApi%5CResources%5CVideoController.&download=1&filename=DOES%2BYOUR%2BCLIENT%2BOWN%2BSHARES%2BIN%2BFOREIGN%2BCORPORATION%253F%2BIMPACT%2BOF%2BTJCA174.mp4',
            // 'https://vimeo.com/76979871',

            // Take an API call for getting webinar details..
          );
          print('Video Player playback URL is : $video_url');

          _initializeVideoPlayerFuture = _controller.initialize();
          _controller.setLooping(true); */
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
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              bottom: 50.0,
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
                                    checkWhoShouldAttendExpand();
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
                                  presenterImage,
                                  presenterName,
                                  presenterQualification,
                                  presenterDesgnination,
                                  presenterCompanyName,
                                  presenterDescription,
                                ),
                                flagExpand: isPresenterExpanded),
                            ExpandedCard(
                                onPress: () {
                                  checkCompanyExpand();
                                },
                                strTitle: 'Company',
                                cardChild: childCardCompany(
                                  presenterCompanyLogo,
                                  presenterCompanyName,
                                  presenterCompanyWebsite,
                                  presenterCompanyDesc,
                                ),
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
                                cardChild:
                                    childCardDetail1('Description Data Others'),
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
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = true;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      }
    });
  }

  checkDescriptionExpand() {
    setState(() {
      print('Clicked on Description');
      if (isDescriptionExpanded) {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = true;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      }
    });
  }

  checkOverviewExpand() {
    setState(() {
      print('Clicked on Overview');
      if (isOverviewOfTopicsExpanded) {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = true;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      }
    });
  }

  checkWhoShouldAttendExpand() {
    setState(() {
      print('Clicked on Whoshould attend');
      if (isWhyShouldAttendExpanded) {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = true;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      }
    });
  }

  checkPresenterExpand() {
    setState(() {
      print('Clicked on Presenter');
      if (isPresenterExpanded) {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = true;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      }
    });
  }

  checkCompanyExpand() {
    setState(() {
      print('Clicked on Details');
      if (isPresenterExpanded) {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = true;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      }
    });
  }

  checkTestimonialsExpand() {
    setState(() {
      print('Clicked on Testimonials');
      if (isPresenterExpanded) {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = true;
        isOthersExpanded = false;
      }
    });
  }

  checkOthersExpand() {
    setState(() {
      print('Clicked on Others');
      if (isPresenterExpanded) {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhyShouldAttendExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = true;
      }
    });
  }
}

class childCardDetail1 extends StatelessWidget {
  childCardDetail1(this.strDetails);

  final String strDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 100.0,
      width: double.infinity,
      color: Colors.red,
      child: Text(
        strDetails,
      ),
    );
  }
}

class childCardPresenterTest extends StatefulWidget {
  childCardPresenterTest(this.strDetails, this.speakerObeject);

  final String strDetails;
  final Object speakerObeject;

  @override
  _childCardPresenterTestState createState() =>
      _childCardPresenterTestState(strDetails, speakerObeject);
}

class _childCardPresenterTestState extends State<childCardPresenterTest> {
  _childCardPresenterTestState(this.strDetails, this.speakerObject);

  final String strDetails;
  final Object speakerObject;

  var strSpeakerEmail = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // strSpeakerEmail = speakerObject['email_id'];
    print('Init State webinar details new is called');
    if (speakerObject is Object) {
      print('Data type for speakerObject is Object');
    } else if (speakerObject is int) {
      print('Data type for speakerObject is Int');
    } else if (speakerObject is String) {
      print('Data type for speakerObject is String');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 100.0,
      width: double.infinity,
      color: Colors.red,
      child: Text(
        // strDetails,
        speakerObject.toString(),
        // widget.speakerObeject['email_id'];
        // strSpeakerEmail,
      ),
    );
  }
}
