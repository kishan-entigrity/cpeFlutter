import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';
import 'final_quiz_model.dart';

class FinalQuizScreen extends StatefulWidget {
  FinalQuizScreen(this.webinarId);

  final int webinarId;

  @override
  _FinalQuizScreenState createState() => _FinalQuizScreenState(webinarId);
}

class _FinalQuizScreenState extends State<FinalQuizScreen> {
  _FinalQuizScreenState(this.webinarId);

  final int webinarId;
  bool isLoaderShowing = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // List<Review_questions> list;
  List<Final_quiz_questions> list;
  int arrCount = 0;
  var data_web;
  var data;

  var current_question = 0;
  var isAnswered = false;
  var isAnswerSubmitted = false;

  var isNextPressed = false;
  var isNextPressedColor = false;
  var lastState = '';
  var questionList = '';
  var answerList = '';

  var successFinalSubmit;
  var successFinalSubmitMessage;

  String _authToken = "";
  int answeredQuestions = 0;
  int correctAnsweredQuestions = 0;
  double correctAnsertPercentages = 0;

  Future<List<Final_quiz_questions>> getFinalQuizQuestions(String authToken, String webinar_id) async {
    // String urls = 'https://my-cpe.com/api/v3/webinar/final-quiz-questions';
    String urls = URLs.BASE_URL + 'webinar/final-quiz-questions';

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
      body: {
        'webinar_id': webinar_id,
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['final_quiz_questions'].length;
    data_web = data['payload']['final_quiz_questions'];
    print('Size for array is : $arrCount');

    if (list != null && list.isNotEmpty) {
      list.addAll(List.from(data_web).map<Final_quiz_questions>((item) => Final_quiz_questions.fromJson(item)).toList());
    } else {
      list = List.from(data_web).map<Final_quiz_questions>((item) => Final_quiz_questions.fromJson(item)).toList();
    }
    // return "Success!";
    return list;
  }

  Future<String> submitFinalQuizAnswers(String authToken, String questionList, String answerList) async {
    // String urls = 'https://my-cpe.com/api/v3/webinar/review-answer';
    String urls = URLs.BASE_URL + 'webinar/final-quiz-answer';

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
      body: {
        'webinar_id': webinarId.toString(),
        'question_id': questionList,
        'answers': answerList,
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    successFinalSubmit = data['success'];
    successFinalSubmitMessage = data['message'];
    print('response is : $data');
    print('Status for success is : $successFinalSubmit');

    if (successFinalSubmit) {
      // Pop back stack with flag..
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(successFinalSubmitMessage),
          duration: Duration(seconds: 3),
        ),
      );
      // isFromSubmitReview = true;
      Navigator.pop(context, true);
    } else {
      // Show error message there..
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(successFinalSubmitMessage),
          duration: Duration(seconds: 3),
        ),
      );
    }

    return "Success!";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkforSp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              color: testColor,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.angleLeft,
                        ),
                      ),
                      flex: 1,
                    ),
                    onTap: () {
                      print('Back button is pressed..');
                      Navigator.pop(context);
                    },
                  ),
                  Flexible(
                    child: Center(
                      child: Text(
                        'Final Quiz',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.5.sp,
                          fontFamily: 'Whitney Semi Bold',
                        ),
                      ),
                    ),
                    flex: 8,
                  ),
                  Flexible(
                    child: Text(''),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.black,
            ),
            isLoaderShowing
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: Container(
                      color: testColor,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10.0.sp, vertical: 10.0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Questions ${current_question + 1}/${arrCount}',
                            style: TextStyle(
                              fontFamily: 'Whitney Semi Bold',
                              fontSize: 14.0.sp,
                              color: Color(0xFF277DF1),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              margin: EdgeInsets.only(top: 10.0.sp),
                              padding: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 10.0.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0.sp),
                                color: Colors.white,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      // 'The ERC is what percentage of qualifying wages:',
                                      '${list[current_question].questionTitle}',
                                      style: TextStyle(
                                        fontFamily: 'Whitney Semi Bold',
                                        fontSize: 16.0.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.0.sp,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('Clicked on option A');
                                        setState(() {
                                          // list[current_question].isAnswered = true;
                                          list[current_question].answeredOption = 'a';
                                          list[current_question].isAnswered = true;
                                          if (list[current_question].answer == 'a') {
                                            list[current_question].isCorrectAnswered = true;
                                          } else {
                                            list[current_question].isCorrectAnswered = false;
                                          }
                                        });
                                      },
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(minHeight: 40.0.sp),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.fromLTRB(10.0.sp, 4.0.sp, 10.0.sp, 4.0.sp),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            // color: isA ? answerBlue : answerWhite,
                                            // color: answerWhite,
                                            // color: list[current_question].isCorrectAnswered ? answerGreen : answerRed,
                                            // color: list[current_question].answeredOption == 'a' ? answerBlue : answerWhite,
                                            color: list[current_question].answeredOption == 'a' ? answerBlue : answerWhite,
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                // 'Option A',
                                                '${list[current_question].a.optionTitle}',
                                                style: TextStyle(
                                                  fontSize: 13.0.sp,
                                                  // color: isA ? answerWhite : answerBlack,
                                                  color: list[current_question].answeredOption == 'a' ? answerWhite : answerBlack,
                                                  fontFamily: 'Whitney Semi Bold',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0.sp,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('Clicked on option B');
                                        setState(() {
                                          // list[current_question].isAnswered = true;
                                          list[current_question].answeredOption = 'b';
                                          list[current_question].isAnswered = true;
                                          if (list[current_question].answer == 'b') {
                                            list[current_question].isCorrectAnswered = true;
                                          } else {
                                            list[current_question].isCorrectAnswered = false;
                                          }
                                        });
                                      },
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(minHeight: 40.0.sp),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.fromLTRB(10.0.sp, 4.0.sp, 10.0.sp, 4.0.sp),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            // color: isB ? answerBlue : answerWhite,
                                            // color: answerWhite,
                                            color: list[current_question].answeredOption == 'b' ? answerBlue : answerWhite,
                                            border: Border.all(
                                              color: Colors.black, //                   <--- border color
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                // 'Option B',
                                                '${list[current_question].b.optionTitle}',
                                                style: TextStyle(
                                                  fontSize: 13.0.sp,
                                                  // color: isB ? answerWhite : answerBlack,
                                                  color: list[current_question].answeredOption == 'b' ? answerWhite : answerBlack,
                                                  fontFamily: 'Whitney Semi Bold',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0.sp,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('Clicked on option C');
                                        setState(() {
                                          // list[current_question].isAnswered = true;
                                          list[current_question].answeredOption = 'c';
                                          list[current_question].isAnswered = true;
                                          if (list[current_question].answer == 'c') {
                                            list[current_question].isCorrectAnswered = true;
                                          } else {
                                            list[current_question].isCorrectAnswered = false;
                                          }
                                        });
                                      },
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(minHeight: 40.0.sp),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.fromLTRB(10.0.sp, 4.0.sp, 10.0.sp, 4.0.sp),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            // color: isC ? answerBlue : answerWhite,
                                            // color: answerWhite,
                                            color: list[current_question].answeredOption == 'c' ? answerBlue : answerWhite,
                                            border: Border.all(
                                              color: Colors.black, //                   <--- border color
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                // 'Option C',
                                                '${list[current_question].c.optionTitle}',
                                                style: TextStyle(
                                                  fontSize: 13.0.sp,
                                                  // color: isC ? answerWhite : answerBlack,
                                                  color: list[current_question].answeredOption == 'c' ? answerWhite : answerBlack,
                                                  fontFamily: 'Whitney Semi Bold',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0.sp,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('Clicked on option D');
                                        setState(() {
                                          // list[current_question].isAnswered = true;
                                          list[current_question].answeredOption = 'd';
                                          list[current_question].isAnswered = true;
                                          if (list[current_question].answer == 'd') {
                                            list[current_question].isCorrectAnswered = true;
                                          } else {
                                            list[current_question].isCorrectAnswered = false;
                                          }
                                        });
                                      },
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(minHeight: 40.0.sp),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.fromLTRB(10.0.sp, 4.0.sp, 10.0.sp, 4.0.sp),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            // color: isD ? answerBlue : answerWhite,
                                            // color: answerWhite,
                                            color: list[current_question].answeredOption == 'd' ? answerBlue : answerWhite,
                                            border: Border.all(
                                              color: Colors.black, //                   <--- border color
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                // 'Option D',
                                                '${list[current_question].d.optionTitle}',
                                                style: TextStyle(
                                                  fontSize: 13.0.sp,
                                                  // color: isD ? answerWhite : answerBlack,
                                                  color: list[current_question].answeredOption == 'd' ? answerWhite : answerBlack,
                                                  fontFamily: 'Whitney Semi Bold',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.0.sp,
                                    ),
                                    Container(
                                      height: 13.0.w,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: GestureDetector(
                                              child: Container(
                                                height: 13.0.w,
                                                margin: EdgeInsets.only(right: 5.0.sp),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(7.0),
                                                  color: themeYellow,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Previous',
                                                    style: TextStyle(
                                                      fontSize: 15.0.sp,
                                                      color: Colors.white,
                                                      fontFamily: 'Whitney Semi Bold',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                print('Prev Current question is : $current_question');
                                                print('Prev ArrCount is : $arrCount');
                                                if (current_question == 0) {
                                                  // Do nothing..
                                                  print('Prev if part');
                                                } else {
                                                  print('Prev else part');
                                                  setState(() {
                                                    current_question = current_question - 1;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                print('Next Current question is : ${current_question + 1}');
                                                print('Next ArrCount is : $arrCount');
                                                if (arrCount.compareTo(current_question + 1) == 0) {
                                                  // Do nothing..
                                                  print('Next if part');
                                                  answeredQuestions = 0;
                                                  for (int i = 0; i < arrCount; i++) {
                                                    if (list[i].isAnswered) {
                                                      answeredQuestions++;
                                                    }
                                                  }

                                                  if (answeredQuestions.compareTo(arrCount) == 0) {
                                                    correctAnsweredQuestions = 0;
                                                    for (int i = 0; i < arrCount; i++) {
                                                      if (list[i].isCorrectAnswered) {
                                                        correctAnsweredQuestions++;
                                                      }
                                                    }
                                                    print('Total correct answered questions are : $correctAnsweredQuestions');

                                                    correctAnsertPercentages = (correctAnsweredQuestions * 100) / arrCount;
                                                    print('Answered percentages : $correctAnsertPercentages');

                                                    if (correctAnsertPercentages > 70) {
                                                      // Take API call for submitting answers for final quiz..
                                                      answerList = '';
                                                      questionList = '';
                                                      for (int i = 0; i < arrCount; i++) {
                                                        if (i == 0) {
                                                          answerList = list[i].answeredOption;
                                                          questionList = list[i].id.toString();
                                                        } else {
                                                          answerList = answerList + ',' + list[i].answeredOption;
                                                          questionList = questionList + ',' + list[i].id.toString();
                                                        }
                                                      }
                                                      print('Questions list : $questionList');
                                                      print('Answers list : $answerList');
                                                      submitFinalQuizQuestion(questionList, answerList);
                                                    } else {
                                                      // Show alert message that user can see popup message..
                                                      showError70();
                                                    }
                                                  }

                                                  print('Size for arr count = $arrCount');
                                                  print('Total answered questions are : $answeredQuestions');

                                                  setState(() {
                                                    // Click event for submit button..try
                                                  });
                                                } else {
                                                  print('Next else part');
                                                  setState(() {
                                                    current_question = current_question + 1;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                height: 13.0.w,
                                                margin: EdgeInsets.only(left: 5.0.sp),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(7.0),
                                                  color: themeBlueLight,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    // 'Next',
                                                    arrCount.compareTo(current_question + 1) == 0 ? 'Submit' : 'Next',
                                                    style: TextStyle(
                                                      fontSize: 15.0.sp,
                                                      color: Colors.white,
                                                      fontFamily: 'Whitney Semi Bold',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0.sp,
                                    ),
                                  ],
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
    );
  }

  void checkforSp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");
    if (checkValue != null) {
      setState(() {
        isLoaderShowing = true;
      });

      if (checkValue) {
        String token = preferences.getString("spToken");
        _authToken = 'Bearer $token';
        print('Auth Token from SP is : $_authToken');

        var connectivityResult = await (Connectivity().checkConnectivity());
        if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
          this.getFinalQuizQuestions('$_authToken', webinarId.toString());
        } else {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Please check your internet connectivity and try again"),
              duration: Duration(seconds: 5),
            ),
          );
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(sharedPrefsNot),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      setState(() {
        isLoaderShowing = false;
      });
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(sharedPrefsNot),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void showError70() {
    showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Oops', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
            content: new Text('You have not answered 70% of the questions correctly. Please retake the quiz.'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.pop(context), // this line dismisses the dialog
                child: new Text('Ok', style: new TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;
  }

  void submitFinalQuizQuestion(String questionList, String answerList) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      // this.getFinalQuizQuestions('$_authToken', webinarId.toString());
      isLoaderShowing = true;
      submitFinalQuizAnswers(_authToken, questionList, answerList);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
