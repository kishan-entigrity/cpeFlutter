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
import 'model_cards/user_cards_list.dart';

class CardFrag extends StatefulWidget {
  @override
  _CardFragState createState() => _CardFragState();
}

class _CardFragState extends State<CardFrag> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  bool isLoaderShowing = false;
  String _authToken = "";

  List<Saved_cards> listCards;

  var data;
  int arrCount = 0;
  var data_web;

  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expMonthController = TextEditingController();
  TextEditingController expYearController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  Future<List<Saved_cards>> getCardsList(String authToken) async {
    String urls = URLs.BASE_URL + 'user-payment/card-list';

    final response = await http.get(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$authToken',
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      isLoaderShowing = false;
      /*if (data['payload']['is_last']) {
        isLast = true;
      } else {
        isLast = false;
      }*/
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['saved_cards'].length;
    data_web = data['payload']['saved_cards'];
    print('Size for array is : $arrCount');

    if (listCards != null && listCards.isNotEmpty) {
      listCards.addAll(List.from(data_web).map<Saved_cards>((item) => Saved_cards.fromJson(item)).toList());
    } else {
      listCards = List.from(data_web).map<Saved_cards>((item) => Saved_cards.fromJson(item)).toList();
    }
    print('Cards List size is : ${listCards.length}');

    return listCards;
  }

  Future<String> makePrimaryCard(String authToken, String cardId) async {
    String urls = URLs.BASE_URL + 'user-payment/make-primary-card';

    final response = await http.post(urls, headers: {
      'Accept': 'Application/json',
      'Authorization': '$authToken',
    }, body: {
      'cardID': '$cardId',
    });

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      isLoaderShowing = false;
      /*if (data['payload']['is_last']) {
        isLast = true;
      } else {
        isLast = false;
      }*/
    });
    if (data['success']) {
      print('Status after updating primary card is : ${data['success']}');
      /*isLoaderShowing = true;
      listCards.clear();
      getCardsList(_authToken);*/
      for (int i = 0; i < listCards.length; i++) {
        setState(() {
          listCards[i].defaultCard = '0';
          print('Card ID from list : ${listCards[i].id} API ID : $cardId');
          if (listCards[i].id.toString() == cardId.toString()) {
            listCards[i].defaultCard = '1';
            print('Updated state for the default card is : ${listCards[i].defaultCard}');
          }
        });
      }
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('${data['message']}'),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('${data['message']}'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    // print(data[1]["title"]);
    print('API response is : $data');
    /*arrCount = data['payload']['saved_cards'].length;
    data_web = data['payload']['saved_cards'];
    print('Size for array is : $arrCount');

    if (listCards != null && listCards.isNotEmpty) {
      listCards.addAll(List.from(data_web).map<Saved_cards>((item) => Saved_cards.fromJson(item)).toList());
    } else {
      listCards = List.from(data_web).map<Saved_cards>((item) => Saved_cards.fromJson(item)).toList();
    }
    print('Cards List size is : ${listCards.length}');*/

    return 'Success';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForSP();
  }

  @override
  void dispose() {
    // _scrollController.dispose();
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
                        'Cards',
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
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10.0.sp, left: 10.0.sp),
                        child: Text(
                          'Add new Card',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.5.sp,
                            fontFamily: 'Whitney Semi Bold',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 5.0.w),
                        child: Text(
                          'Name on Card',
                          style: kLableSignUpHintLableStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0.sp),
                        child: TextField(
                          controller: nameController,
                          style: kLableSignUpTextStyle,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'John Smith',
                            hintStyle: kLableSignUpHintStyle,
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0.sp, 0, 10.0.sp, 0),
                        child: Divider(
                          height: 5.0,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 2.0.w),
                        child: Text(
                          'Credit card number',
                          style: kLableSignUpHintLableStyle,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 10.0.sp),
                        child: TextField(
                          controller: cardNumberController,
                          style: kLableSignUpTextStyle,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '5052 6525 5548 6246',
                            hintStyle: kLableSignUpHintStyle,
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0.sp, 0, 10.0.sp, 0),
                        child: Divider(
                          height: 5.0,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 2.0.w),
                                  child: Text(
                                    'Month',
                                    style: kLableSignUpHintLableStyle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 10.0.sp),
                                  child: TextField(
                                    controller: expMonthController,
                                    style: kLableSignUpTextStyle,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'MM',
                                      hintStyle: kLableSignUpHintStyle,
                                    ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.0.sp, 0, 10.0.sp, 0),
                                  child: Divider(
                                    height: 5.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 2.0.w),
                                  child: Text(
                                    'Year',
                                    style: kLableSignUpHintLableStyle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 10.0.sp),
                                  child: TextField(
                                    controller: expYearController,
                                    style: kLableSignUpTextStyle,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'YYYY',
                                      hintStyle: kLableSignUpHintStyle,
                                    ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.0.sp, 0, 10.0.sp, 0),
                                  child: Divider(
                                    height: 5.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 2.0.w),
                                  child: Text(
                                    'CVV',
                                    style: kLableSignUpHintLableStyle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 10.0.sp),
                                  child: TextField(
                                    controller: cardNumberController,
                                    style: kLableSignUpTextStyle,
                                    obscureText: true,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'CVV',
                                      hintStyle: kLableSignUpHintStyle,
                                    ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.0.sp, 0, 10.0.sp, 0),
                                  child: Divider(
                                    height: 5.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0.sp),
                        height: 40.0.sp,
                        decoration: BoxDecoration(
                          color: themeYellow,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            'Save Card',
                            style: kWebinarButtonLabelTextStyleWhite13,
                          ),
                        ),
                      ),
                      /*Container(
                        height: 50.0.sp,
                        width: double.infinity,
                        // color: Colors.teal,
                        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Save Card',
                              style: kButtonLabelTextStyle,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.arrowRight,
                              onPressed: () async {
                                // getUserData();
                              },
                            ),
                            */ /*FloatingActionButton(
                      onPressed: null,
                      backgroundColor: Color(0xFFFBB42C),
                    ),*/ /*
                          ],
                        ),
                      ),*/
                      Container(
                        margin: EdgeInsets.only(top: 30.0.sp, left: 10.0.sp),
                        child: Text(
                          'Saved Card',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.5.sp,
                            fontFamily: 'Whitney Semi Bold',
                          ),
                        ),
                      ),
                      Container(
                        height: 70.0.w,
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: listCards.length + 1,
                          // itemCount: listCards.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return index == listCards.length
                                ? SizedBox(
                                    width: 10.0.sp,
                                  )
                                : Column(
                                    children: <Widget>[
                                      Container(
                                        height: 50.0.w,
                                        width: 80.0.w,
                                        margin: EdgeInsets.only(top: 10.0.sp, left: 10.0.sp),
                                        decoration: BoxDecoration(
                                          // color: Colors.blueGrey,
                                          borderRadius: BorderRadius.circular(10.0.sp),
                                          gradient: new LinearGradient(
                                              colors: [
                                                // const Color(0xFF3366FF),
                                                // const Color(0xFF00EBC9),
                                                const Color(0xFFfdc559),
                                                // const Color(0xFF00CCFF),
                                                // const Color(0xFF00DBE8),
                                                const Color(0xFFfbb42c),
                                              ],
                                              begin: const FractionalOffset(0.0, 0.0),
                                              end: const FractionalOffset(1.0, 0.0),
                                              stops: [0.0, 1.0],
                                              tileMode: TileMode.clamp),
                                        ),
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(left: 15.0.sp, top: 15.0.sp),
                                                    child: Text(
                                                      'Card Number',
                                                      style: TextStyle(
                                                        fontSize: 10.0.sp,
                                                        color: Colors.white,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 15.0.sp, top: 2.0.sp),
                                                    child: Text(
                                                      // '\u00a9 XXXX XXXX XXXX ${listCards[index].cardLastNumber}',
                                                      '\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 ${listCards[index].cardLastNumber}',
                                                      style: TextStyle(
                                                        fontSize: 18.0.sp,
                                                        color: Colors.white,
                                                        fontFamily: 'Whitney Bold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0.0,
                                              left: 0.0,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(left: 15.0.sp),
                                                    child: Text(
                                                      'Name on Card',
                                                      style: TextStyle(
                                                        fontSize: 10.0.sp,
                                                        color: Colors.white,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 15.0.sp, top: 2.0.sp, bottom: 15.0.sp),
                                                    child: Text(
                                                      '${listCards[index].cardHolderName}',
                                                      style: TextStyle(
                                                        fontSize: 18.0.sp,
                                                        color: Colors.white,
                                                        fontFamily: 'Whitney Bold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0.0,
                                              right: 0.0,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(right: 15.0.sp),
                                                    child: Text(
                                                      'Validity',
                                                      style: TextStyle(
                                                        fontSize: 10.0.sp,
                                                        color: Colors.white,
                                                        fontFamily: 'Whitney Medium',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(right: 15.0.sp, top: 0.0, bottom: 15.0.sp),
                                                    child: Text(
                                                      '${listCards[index].expireMonth}/${listCards[index].expireYear}',
                                                      style: TextStyle(
                                                        fontSize: 15.0.sp,
                                                        color: Colors.white,
                                                        fontFamily: 'Whitney Bold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8.0.sp, left: 10.0.sp),
                                        // padding: EdgeInsets.only(right: 3.0.sp),
                                        height: 10.0.w,
                                        width: 80.0.w,
                                        // color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                print('Clicked on the mark as primary card ID : ${listCards[index].id}');
                                                primaryCardAPI(listCards[index].id);
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    listCards[index].defaultCard.compareTo('1') == 0
                                                        ? FontAwesomeIcons.checkCircle
                                                        : FontAwesomeIcons.circle,
                                                    size: 14.0.sp,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: 8.0.sp,
                                                  ),
                                                  Text(
                                                    'Make primary',
                                                    style: TextStyle(
                                                      fontSize: 14.0.sp,
                                                      color: Colors.black,
                                                      fontFamily: 'Whitney Medium',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                print('Clicked on the Delete card ID : ${listCards[index].id}');
                                                deleteCardAPI(listCards[index].id);
                                              },
                                              child: Container(
                                                height: 10.0.w,
                                                width: 10.0.w,
                                                decoration: BoxDecoration(
                                                  color: themeYellow,
                                                  borderRadius: BorderRadius.circular(10.0.w),
                                                ),
                                                child: Center(
                                                  /*child: Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                      fontSize: 12.0.sp,
                                                      color: Colors.white,
                                                      fontFamily: 'Whitney Medium',
                                                    ),
                                                  ),*/
                                                  child: Icon(
                                                    FontAwesomeIcons.trash,
                                                    size: 10.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0.sp,
                      ),
                    ],
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

        checkForInternet();
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

  void checkForInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      this.getCardsList('$_authToken');
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  void deleteCardAPI(int id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      this.getCardsList('$_authToken');
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  void primaryCardAPI(int id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      // this.getCardsList('$_authToken');
      this.makePrimaryCard('$_authToken', id.toString());
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
