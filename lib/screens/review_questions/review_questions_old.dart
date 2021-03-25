import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';
import '../../rest_api.dart';
import 'model/review_question_model.dart';

class ReviewQuestionsOld extends StatefulWidget {
  ReviewQuestionsOld(this.webinarId);

  final int webinarId;

  @override
  _ReviewQuestionsOldState createState() => _ReviewQuestionsOldState(webinarId);
}

class _ReviewQuestionsOldState extends State<ReviewQuestionsOld> {
  _ReviewQuestionsOldState(this.webinarId);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final int webinarId;
  bool isLoaderShowing = false;

  String _authToken = "";

  List<Review_questions> list;
  int arrCount = 0;
  var data_web;
  var data;

  var current_question = 0;
  var isAnswered = false;
  var isAnswerSubmitted = false;

  Future<List<Review_questions>> getReviewQuestionList(String authToken) async {
    // String urls = URLs.BASE_URL + 'webinar/list';
    // String urls = 'https://my-cpe.com/api/v3/webinar/review-questions';
    String urls = URLs.BASE_URL + 'webinar/review-questions';

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
      body: {
        'webinar_id': webinarId.toString(),
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['review_questions'].length;
    data_web = data['payload']['review_questions'];
    print('Size for array is : $arrCount');

    if (list != null && list.isNotEmpty) {
      list.addAll(List.from(data_web).map<Review_questions>((item) => Review_questions.fromJson(item)).toList());
    } else {
      list = List.from(data_web).map<Review_questions>((item) => Review_questions.fromJson(item)).toList();
    }

    // return "Success!";
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Webinar ID on review question : $webinarId');
    // getReviewQuestion();
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
                        'Review Questions',
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
                                          if (isAnswerSubmitted) {
                                            if (!list[current_question].isCorrectAnswered) {
                                              list[current_question].answeredOption = 'a';
                                              if (list[current_question].answer == 'a') {
                                                list[current_question].isCorrectAnswered = true;
                                              } else {
                                                list[current_question].isCorrectAnswered = false;
                                              }
                                            } else {
                                              print('Do nothing with A..');
                                            }
                                          } else {
                                            list[current_question].isAnswered = true;
                                            list[current_question].answeredOption = 'a';
                                            if (list[current_question].answer == 'a') {
                                              list[current_question].isCorrectAnswered = true;
                                            } else {
                                              list[current_question].isCorrectAnswered = false;
                                            }
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
                                            color: isAnswerSubmitted
                                                ? list[current_question].answeredOption == 'a'
                                                    ? list[current_question].answer == 'a'
                                                        ? answerGreen
                                                        : answerRed
                                                    : answerWhite
                                                : list[current_question].isAnswered
                                                    ? list[current_question].answeredOption == 'a'
                                                        ? answerBlue
                                                        : answerWhite
                                                    : answerWhite,
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
                                                // 'Option A',
                                                '${list[current_question].a.optionTitle}',
                                                style: TextStyle(
                                                  fontSize: 13.0.sp,
                                                  // color: isA ? answerWhite : answerBlack,
                                                  color: list[current_question].isAnswered
                                                      ? list[current_question].answeredOption == 'a'
                                                          ? answerWhite
                                                          : answerBlack
                                                      : answerBlack,
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
                                          if (isAnswerSubmitted) {
                                            if (!list[current_question].isCorrectAnswered) {
                                              list[current_question].isAnswered = true;
                                              list[current_question].answeredOption = 'b';
                                              if (list[current_question].answer == 'b') {
                                                list[current_question].isCorrectAnswered = true;
                                              } else {
                                                list[current_question].isCorrectAnswered = false;
                                              }
                                            } else {
                                              print('Do nothing with B..');
                                            }
                                          } else {
                                            list[current_question].isAnswered = true;
                                            list[current_question].answeredOption = 'b';
                                            if (list[current_question].answer == 'b') {
                                              list[current_question].isCorrectAnswered = true;
                                            } else {
                                              list[current_question].isCorrectAnswered = false;
                                            }
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
                                            color: isAnswerSubmitted
                                                ? list[current_question].answeredOption == 'b'
                                                    ? list[current_question].answer == 'b'
                                                        ? answerGreen
                                                        : answerRed
                                                    : answerWhite
                                                : list[current_question].isAnswered
                                                    ? list[current_question].answeredOption == 'b'
                                                        ? answerBlue
                                                        : answerWhite
                                                    : answerWhite,
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
                                                  color: list[current_question].isAnswered
                                                      ? list[current_question].answeredOption == 'b'
                                                          ? answerWhite
                                                          : answerBlack
                                                      : answerBlack,
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
                                          if (isAnswerSubmitted) {
                                            if (!list[current_question].isCorrectAnswered) {
                                              list[current_question].isAnswered = true;
                                              list[current_question].answeredOption = 'c';
                                              if (list[current_question].answer == 'c') {
                                                list[current_question].isCorrectAnswered = true;
                                              } else {
                                                list[current_question].isCorrectAnswered = false;
                                              }
                                            } else {
                                              print('Do nothing with C..');
                                            }
                                          } else {
                                            list[current_question].isAnswered = true;
                                            list[current_question].answeredOption = 'c';
                                            if (list[current_question].answer == 'c') {
                                              list[current_question].isCorrectAnswered = true;
                                            } else {
                                              list[current_question].isCorrectAnswered = false;
                                            }
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
                                            color: isAnswerSubmitted
                                                ? list[current_question].answeredOption == 'c'
                                                    ? list[current_question].answer == 'c'
                                                        ? answerGreen
                                                        : answerRed
                                                    : answerWhite
                                                : list[current_question].isAnswered
                                                    ? list[current_question].answeredOption == 'c'
                                                        ? answerBlue
                                                        : answerWhite
                                                    : answerWhite,
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
                                                  color: list[current_question].isAnswered
                                                      ? list[current_question].answeredOption == 'c'
                                                          ? answerWhite
                                                          : answerBlack
                                                      : answerBlack,
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
                                          if (isAnswerSubmitted) {
                                            if (!list[current_question].isCorrectAnswered) {
                                              list[current_question].isAnswered = true;
                                              list[current_question].answeredOption = 'd';
                                              if (list[current_question].answer == 'd') {
                                                list[current_question].isCorrectAnswered = true;
                                              } else {
                                                list[current_question].isCorrectAnswered = false;
                                              }
                                            } else {
                                              print('Do nothing with D..');
                                            }
                                          } else {
                                            list[current_question].isAnswered = true;
                                            list[current_question].answeredOption = 'd';
                                            if (list[current_question].answer == 'd') {
                                              list[current_question].isCorrectAnswered = true;
                                            } else {
                                              list[current_question].isCorrectAnswered = false;
                                            }
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
                                            color: isAnswerSubmitted
                                                ? list[current_question].answeredOption == 'd'
                                                    ? list[current_question].answer == 'd'
                                                        ? answerGreen
                                                        : answerRed
                                                    : answerWhite
                                                : list[current_question].isAnswered
                                                    ? list[current_question].answeredOption == 'd'
                                                        ? answerBlue
                                                        : answerWhite
                                                    : answerWhite,
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
                                                  color: list[current_question].isAnswered
                                                      ? list[current_question].answeredOption == 'd'
                                                          ? answerWhite
                                                          : answerBlack
                                                      : answerBlack,
                                                  fontFamily: 'Whitney Semi Bold',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isAnswered ? true : false,
                                      child: SizedBox(
                                        height: 10.0.sp,
                                      ),
                                    ),
                                    Visibility(
                                      visible: isAnswered ? true : false,
                                      child: Text(
                                        'Why it\'s correct?',
                                        style: TextStyle(
                                          fontSize: 13.0.sp,
                                          color: Colors.black,
                                          fontFamily: 'Whitney Semi Bold',
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isAnswered ? true : false,
                                      child: SizedBox(
                                        height: 5.0.sp,
                                      ),
                                    ),
                                    Visibility(
                                      visible: isAnswered ? true : false,
                                      child: Text(
                                        'Deffered Social security tax, the deffered taxes are due in 12/31/2021 and 12/31/2022 by 50%',
                                        style: TextStyle(
                                          fontSize: 12.0.sp,
                                          color: Colors.black45,
                                          fontFamily: 'Whitney Medium',
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
                                                  // Implement submit click from here..
                                                  // 1.First we need to check for all questions are answered or not!!??
                                                  // 2.If all questions are answered then we need to check for correct answers..
                                                  // 3.If all questions are answered correctly then we need to show popup for the all questions
                                                  // answered correctly..
                                                  setState(() {
                                                    current_question = 0;
                                                    isAnswerSubmitted = true;
                                                  });
                                                } else {
                                                  print('Next else part');
                                                  setState(() {
                                                    current_question = current_question + 1;
                                                    // list[current_question].d.optionTitle = 'Test Option';
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

  void getReviewQuestion() async {}

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

        this.getReviewQuestionList('$_authToken');
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
}
