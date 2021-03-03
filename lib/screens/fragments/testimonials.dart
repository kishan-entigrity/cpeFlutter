import 'dart:convert';

import 'package:cpe_flutter/model/testimonials_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rating_bar/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class Testimonials extends StatefulWidget {
  @override
  _TestimonialsState createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  bool isLoaderShowing = false;
  String _authToken = "";

  int start = 0;
  var data;

  bool isLast = false;

  List<Webinar_testimonial> list;
  int arrCount = 0;
  var data_web;

  Future<List<Webinar_testimonial>> getMyTransactionList(String authToken, String start, String limit) async {
    // String urls = URLs.BASE_URL + 'webinar/list';
    String urls = 'https://my-cpe.com/api/v3//webinar/testimonial';

    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
      body: {
        'start': start,
        'limit': limit,
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      isLoaderShowing = false;
      if (data['payload']['is_last']) {
        isLast = true;
      } else {
        isLast = false;
      }
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['webinar_testimonial'].length;
    data_web = data['payload']['webinar_testimonial'];
    print('Size for array is : $arrCount');

    if (list != null && list.isNotEmpty) {
      list.addAll(List.from(data_web).map<Webinar_testimonial>((item) => Webinar_testimonial.fromJson(item)).toList());
    } else {
      list = List.from(data_web).map<Webinar_testimonial>((item) => Webinar_testimonial.fromJson(item)).toList();
    }

    // return "Success!";
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Enter into myTransaction screen');
    // Get API call for my transaction..
    checkForSP();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('Scroll Controller is called here status for isLast is : $isLast');
        if (!isLast) {
          start = start + 10;
          print('Val for Start is : $start || Status for isLast is : $isLast');
          this.getMyTransactionList('$_authToken', '$start', '10');
        } else {
          print('val for isLast : $isLast');
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                        'Testimonials',
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
            Expanded(
              child: Container(
                // color: Colors.teal,
                // child: Text('Hello World'),
                child: (list != null && list.isNotEmpty)
                    // child: !isLoaderShowing
                    ? RefreshIndicator(
                        onRefresh: () {
                          print('On refresh is called..');
                          start = 0;
                          list.clear();
                          this.getMyTransactionList('$_authToken', '$start', '10');
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          // itemCount: arrCount,
                          itemCount: list.length + 1,
                          // itemCount: strTitles.length,
                          itemBuilder: (context, index) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 50.0,
                              ),
                              child: (index == list.length)
                                  ? isLast
                                      ? Container(
                                          height: 20.0,
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(vertical: 20.0),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                  : GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    // userNameData,
                                                    '${list[index].firstName} ${list[index].lastName} ',
                                                    style: kUserDataTestimonials,
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    // testimonialDate,
                                                    '${list[index].date} ',
                                                    // style: kDateTestimonials,
                                                    style: TextStyle(
                                                      fontFamily: 'Whitney Medium',
                                                      fontSize: 12.5.sp,
                                                      color: black50,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5.0),
                                              width: 80.0.sp,
                                              child: RatingBar.readOnly(
                                                // initialRating: double.parse(rating),
                                                initialRating: double.parse('4'),
                                                size: 16.0.sp,
                                                filledColor: Color(0xFFFFC803),
                                                halfFilledColor: Color(0xFFFFC803),
                                                emptyColor: Color(0xFFFFC803),
                                                isHalfAllowed: true,
                                                halfFilledIcon: Icons.star_half,
                                                filledIcon: Icons.star,
                                                emptyIcon: Icons.star_border,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: 5.0),
                                              child: Text(
                                                '${list[index].review}',
                                                style: kKeyLableWebinarDetailExpand,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      /*child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          // color: Colors.blueGrey,
                                          color: Color(0xFFF3F5F9),
                                        ),
                                        margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                        // padding: EdgeInsets.all(10.0),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 10.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${list[index].title}',
                                              style: TextStyle(
                                                fontSize: 15.0.sp,
                                                fontFamily: 'Whitney Medium',
                                              ),
                                            ),
                                            Text(
                                              'Tr ID #: ${list[index].transactionId}',
                                              style: TextStyle(
                                                fontSize: 12.0.sp,
                                                fontFamily: 'Whitney Medium',
                                                color: Color(0x501F2227),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 0.0, right: 10.0),
                                                        padding: EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 18.0.sp),
                                                        decoration: BoxDecoration(
                                                          color: themeBlueLight,
                                                          borderRadius: BorderRadius.circular(4.0),
                                                        ),
                                                        child: Text(
                                                          '\$ ${list[index].amount}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Whitney Semibold',
                                                            fontSize: 12.0.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          '${list[index].paymentDate}',
                                                          style: TextStyle(
                                                            color: Color(0x501F2227),
                                                            fontFamily: 'Whitney Medium',
                                                            fontSize: 12.0.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 32.0.sp,
                                                    width: 32.0.sp,
                                                    padding: EdgeInsets.symmetric(vertical: 12.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(32.0.sp),
                                                      color: themeYellow,
                                                    ),
                                                    child: Image.asset(
                                                      'assets/download.png',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),*/
                                    ),
                            );
                          },
                        ),
                      )
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkForSP() async {
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

        // this.getDataWebinarList('$_authToken', '$start', '10');
        this.getMyTransactionList('$_authToken', '$start', '10');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
      } else {
        preferences.clear();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(sharedPrefsNot),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
