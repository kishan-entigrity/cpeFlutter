import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/components/TopBar.dart';
import 'package:cpe_flutter/screens/webinar_details/ExpandedCard.dart';
import 'package:cpe_flutter/screens/webinar_details/WebinarSpeakerName_OnDemand.dart';
import 'package:cpe_flutter/screens/webinar_details/WebinarTitleOnDemand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../rest_api.dart';
import 'childCardCompany.dart';
import 'childCardDescription.dart';
import 'childCardPresenter.dart';

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

  var respStatus;
  var respMessage;

  String webinar_thumb = '';
  var video_url = '',
      webinar_title = '',
      webinar_type = '',
      webinar_date = '',
      webinar_status = '',
      start_date = '',
      start_time = '',
      is_card_save = false,
      credit = '',
      ce_credit = '',
      cfp_credit = '',
      cpd_credit = '',
      duration = 0,
      presenter_name = '',
      learning_objective = '',
      program_description = '';

  var isPlaying = false;

  bool isDetailsExpanded = false;
  bool isDescriptionExpanded = false;
  bool isOverviewOfTopicsExpanded = false;
  bool isWhoShouldAttenExpanded = false;
  bool isPresenterExpanded = false;
  bool isCompanyExpanded = false;
  bool isTestimonialsExpanded = false;
  bool isOthersExpanded = false;

  var presenter_obj;

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
      var resp = await getWebinarDetails(userToken, strWebId);

      respStatus = resp['success'];
      respMessage = resp['message'];

      print('Response for webinar details is : $resp');

      if (respStatus) {
        setState(() {
          isLoaderShowing = false;
          webinar_thumb =
              resp['payload']['webinar_detail']['webinar_thumbnail'];
          video_url = resp['payload']['webinar_detail']['webinar_video_url'];
          webinar_title = resp['payload']['webinar_detail']['webinar_title'];
          webinar_type = resp['payload']['webinar_detail']['webinar_type'];
          webinar_date = resp['payload']['webinar_detail']['webinar_date'];
          webinar_status = resp['payload']['webinar_detail']['webinar_status'];
          start_date = resp['payload']['webinar_detail']['start_date'];
          start_time = resp['payload']['webinar_detail']['start_time'];
          is_card_save = resp['payload']['webinar_detail']['is_card_save'];
          credit = resp['payload']['webinar_detail']['credit'];
          ce_credit = resp['payload']['webinar_detail']['ce_credit'];
          cfp_credit = resp['payload']['webinar_detail']['cfp_credit'];
          cpd_credit = resp['payload']['webinar_detail']['cpd_credit'];
          duration = resp['payload']['webinar_detail']['duration'];
          learning_objective =
              resp['payload']['webinar_detail']['Learning_objective'];
          program_description =
              resp['payload']['webinar_detail']['program_description'];
          presenter_name =
              resp['payload']['webinar_detail']['about_presententer']['name'];
          presenter_obj =
              resp['payload']['webinar_detail']['about_presententer'];
          print('Whole object for presenter is : $presenter_obj');
          var strTempEmail = presenter_obj['email_id'];
          print('Email Data from Object is : $strTempEmail');

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
            'Webinar details response : Webinar thumbnail is : $webinar_thumb');
        print('Webinar details response : Webinar video url is : $video_url');
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
                color: Colors.yellow,
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
                                      image: NetworkImage(webinar_thumb),
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
                              WebinarTitle_OnDemand(webinar_title),
                              // WebinarTitle_OnDemand('Test Title'),
                              WebinarSpeakerName_OnDemand(presenter_name),
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
                                cardChild: childCardDetail1(
                                    'Description Data Details'),
                                flagExpand: isDetailsExpanded),
                            ExpandedCard(
                                onPress: () {
                                  checkDescriptionExpand();
                                },
                                strTitle: 'Description',
                                cardChild: childCardDescription(
                                    program_description, learning_objective),
                                flagExpand: isDescriptionExpanded),
                            ExpandedCard(
                                onPress: () {
                                  checkOverviewExpand();
                                },
                                strTitle: 'Overview of Topics',
                                cardChild: childCardDetail1(
                                    'Description Data Overview of Topics'),
                                flagExpand: isOverviewOfTopicsExpanded),
                            ExpandedCard(
                                onPress: () {
                                  checkWhoShouldAttendExpand();
                                },
                                strTitle: 'Who should attend',
                                cardChild: childCardDetail1(
                                    'Description Data Who should attend'),
                                flagExpand: isWhoShouldAttenExpanded),
                            ExpandedCard(
                                onPress: () {
                                  checkPresenterExpand();
                                },
                                strTitle: 'Presenter',
                                cardChild: childCardPresenter(
                                  presenter_obj['presenter_image'],
                                  presenter_obj['name'],
                                  presenter_obj['qualification'],
                                  presenter_obj['desgnination'],
                                  presenter_obj['company_name'],
                                  presenter_obj['speaker_desc'],
                                ),
                                flagExpand: isPresenterExpanded),
                            ExpandedCard(
                                onPress: () {
                                  checkCompanyExpand();
                                },
                                strTitle: 'Company',
                                cardChild: childCardCompany(
                                  presenter_obj['company_logo'],
                                  presenter_obj['company_name'],
                                  presenter_obj['company_website'],
                                  presenter_obj['company_desc'],
                                ),
                                flagExpand: isCompanyExpanded),
                            ExpandedCard(
                                onPress: () {
                                  checkTestimonialsExpand();
                                },
                                strTitle: 'Testimonials',
                                cardChild: childCardDetail1(
                                    'Description Data Testimonials'),
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
        isWhoShouldAttenExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = true;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhoShouldAttenExpanded = false;
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
        isWhoShouldAttenExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = true;
        isOverviewOfTopicsExpanded = false;
        isWhoShouldAttenExpanded = false;
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
        isWhoShouldAttenExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = true;
        isWhoShouldAttenExpanded = false;
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
      if (isWhoShouldAttenExpanded) {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhoShouldAttenExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhoShouldAttenExpanded = true;
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
        isWhoShouldAttenExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhoShouldAttenExpanded = false;
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
        isWhoShouldAttenExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhoShouldAttenExpanded = false;
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
        isWhoShouldAttenExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhoShouldAttenExpanded = false;
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
        isWhoShouldAttenExpanded = false;
        isPresenterExpanded = false;
        isCompanyExpanded = false;
        isTestimonialsExpanded = false;
        isOthersExpanded = false;
      } else {
        isDetailsExpanded = false;
        isDescriptionExpanded = false;
        isOverviewOfTopicsExpanded = false;
        isWhoShouldAttenExpanded = false;
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
