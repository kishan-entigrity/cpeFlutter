import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:cpe_flutter/components/SpinKitSample1.dart';
import 'package:cpe_flutter/screens/intro_login_signup/login.dart';
import 'package:cpe_flutter/screens/webinar_details/webinar_details_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../const_signup.dart';
import '../../constant.dart';
import '../../rest_api.dart';
import 'model_cards/user_cards_list.dart';

class GuestCardFrag extends StatefulWidget {
  GuestCardFrag(this.webinarFee, this.webinarId, this.webinarTypeIntent, this.scheduleId);

  final String webinarFee;
  final int webinarId;
  final String webinarTypeIntent;
  final String scheduleId;

  @override
  _GuestCardFragState createState() => _GuestCardFragState(webinarFee, webinarId, webinarTypeIntent, scheduleId);
}

class _GuestCardFragState extends State<GuestCardFrag> {
  _GuestCardFragState(this.webinarFee, this.webinarId, this.webinarTypeIntent, this.scheduleId);

  final String webinarFee;
  final int webinarId;
  final String webinarTypeIntent;
  final String scheduleId;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  bool isLoaderShowing = false;
  bool isLoaderPayment = false;
  String _authToken = "";

  List<Saved_cards> listCards;

  var data;
  var dataAddCard;
  int arrCount = 0;
  var data_web;

  var strSelectedMonth = '';
  var strSelectedYear = '';

  var isTermsAccepted = false;

  var needToShowForm = false;

  var isPaySelectedByCards = false;

  List<String> monthList = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];
  List<String> yearList = [
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
    '2031',
    '2032',
    '2033',
    '2034',
    '2035',
    '2036',
    '2037',
    '2038',
    '2039',
    '2040',
    '2041',
    '2042',
    '2043',
    '2044',
    '2045',
    '2046',
    '2047',
    '2048',
    '2049',
    '2050'
  ];

  var selectedCardId = '';
  var resp;

  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
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
      if (response.statusCode == 401) {
        logoutUser();
      }

      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
      isLoaderShowing = false;
    });

    // print(data[1]["title"]);
    print('GetCards List API response is : $data');
    arrCount = data['payload']['saved_cards'].length;
    data_web = data['payload']['saved_cards'];
    print('Size for array is : $arrCount');

    if (listCards != null && listCards.isNotEmpty) {
      listCards.addAll(List.from(data_web).map<Saved_cards>((item) => Saved_cards.fromJson(item)).toList());
    } else {
      listCards = List.from(data_web).map<Saved_cards>((item) => Saved_cards.fromJson(item)).toList();
    }
    print('Cards List size is : ${listCards.length}');

    if (arrCount == 0) {
      setState(() {
        needToShowForm = true;
        isPaySelectedByCards = false;
      });
    } else {
      setState(() {
        needToShowForm = false;
        isPaySelectedByCards = true;
        for (int i = 0; i < listCards.length; i++) {
          print('Card ids in the loop is : ${listCards[i].id.toString()}');
          if (listCards[i].defaultCard.compareTo('1') == 0) {
            setState(() {
              isPaySelectedByCards = true;
              selectedCardId = listCards[i].id.toString();
            });
          }
        }
      });
    }

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
            isPaySelectedByCards = true;
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

    print('API response is : $data');

    return 'Success';
  }

  Future<String> deleteUserCard(String authToken, String cardId) async {
    String urls = URLs.BASE_URL + 'user-payment/delete-card';

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
    });
    if (data['success']) {
      print('Status after updating primary card is : ${data['success']}');
      isLoaderShowing = true;
      listCards.clear();
      getCardsList(_authToken);
      /*for (int i = 0; i < listCards.length; i++) {
        setState(() {
          listCards[i].defaultCard = '0';
          print('Card ID from list : ${listCards[i].id} API ID : $cardId');
          if (listCards[i].id.toString() == cardId.toString()) {
            listCards[i].defaultCard = '1';
            print('Updated state for the default card is : ${listCards[i].defaultCard}');
          }
        });
      }*/
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

    print('API response is : $data');

    return 'Success';
  }

  Future<String> addUserCardAPI(String authToken) async {
    String urls = URLs.BASE_URL + 'user-payment/add-card';

    final response = await http.post(urls, headers: {
      'Accept': 'Application/json',
      'Authorization': '$authToken',
    }, body: {
      'card_number': '${cardNumberController.text.toString()}',
      'cardholdername': '${nameController.text.toString()}',
      'exp_month': strSelectedMonth.toString(),
      'exp_year': strSelectedYear.toString(),
      'cvv': '${cvvController.text.toString()}',
    });

    this.setState(() {
      // data = JSON.decode(response.body);
      dataAddCard = jsonDecode(response.body);
      isLoaderShowing = false;
    });
    print('Response for API is : $dataAddCard');

    if (dataAddCard['success']) {
      print('Status after updating primary card is : ${dataAddCard['success']}');
      setState(() {
        isLoaderShowing = true;
        listCards.clear();
        nameController.text = '';
        cardNumberController.text = '';
        strSelectedMonth = '';
        strSelectedYear = '';
        cvvController.text = '';
      });
      getCardsList(_authToken);
      /*for (int i = 0; i < listCards.length; i++) {
        setState(() {
          listCards[i].defaultCard = '0';
          print('Card ID from list : ${listCards[i].id} API ID : $cardId');
          if (listCards[i].id.toString() == cardId.toString()) {
            listCards[i].defaultCard = '1';
            print('Updated state for the default card is : ${listCards[i].defaultCard}');
          }
        });
      }*/
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('${dataAddCard['message']}'),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('${dataAddCard['message']}'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    print('API response is : $data');

    return 'Success';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConstSignUp.clearGuestRedirectionFlow();
    checkForSP();
  }

  @override
  void dispose() {
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
                        'Registration Payment',
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
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Visibility(
                              visible: arrCount == 0 ? false : true,
                              child: Container(
                                margin: EdgeInsets.only(top: 30.0.sp, left: 10.0.sp),
                                child: Text(
                                  'Pay Using',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.5.sp,
                                    fontFamily: 'Whitney Semi Bold',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // height: 70.0.w,
                              child: isLoaderShowing
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : (listCards != null && listCards.isNotEmpty)
                                      ? ListView.builder(
                                          controller: _scrollController,
                                          shrinkWrap: true,
                                          itemCount: listCards.length + 1,
                                          // itemCount: listCards.length,
                                          // scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return index == listCards.length
                                                ? SizedBox(
                                                    height: 20.0.sp,
                                                    width: 10.0.sp,
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      print('Clicked on the cards : ${listCards[index].cardLastNumber}');
                                                      for (int i = 0; i < listCards.length; i++) {
                                                        setState(() {
                                                          listCards[i].defaultCard = '0';
                                                          // print('Card ID from list : ${listCards[i].id} API ID : $cardId');
                                                          // if (listCards[i].id.toString() == cardId.toString()) {
                                                          if (i == index) {
                                                            listCards[i].defaultCard = '1';
                                                            selectedCardId = listCards[i].id.toString();
                                                            isPaySelectedByCards = true;
                                                            needToShowForm = false;
                                                            print('Updated state for the default card is : ${listCards[i].defaultCard}');
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 20.0.w,
                                                          width: 100.0.w,
                                                          margin: EdgeInsets.only(top: 10.0.sp, left: 10.0.sp, right: 10.0.sp),
                                                          decoration: BoxDecoration(
                                                            // color: Colors.blueGrey,
                                                            borderRadius: BorderRadius.circular(10.0.sp),
                                                            gradient: new LinearGradient(
                                                                colors: [
                                                                  const Color(0xFFfdc559),
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
                                                                top: 10.0.sp,
                                                                right: 10.0.sp,
                                                                bottom: 10.0.sp,
                                                                child: Icon(
                                                                  listCards[index].defaultCard.compareTo('1') == 0
                                                                      ? FontAwesomeIcons.solidCheckCircle
                                                                      : FontAwesomeIcons.circle,
                                                                  size: 16.0.sp,
                                                                  // color: listCards[index].defaultCard.compareTo('1') == 0 ? Colors.lightGreen : Colors.white,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                              /*Positioned(
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
                                                        ),*/
                                                              /*Positioned(
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
                                                        ),*/
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                          },
                                        )
                                      : SizedBox(
                                          height: 10.0.sp,
                                        ),
                              /*Center(
                                    child: Text(
                                      'Oops no cards found for this user..',
                                      style: kValueLableWebinarDetailExpand,
                                    ),
                                  ),*/
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  unCheckAllCard();
                                  needToShowForm = true;
                                  isPaySelectedByCards = false;
                                });
                              },
                              child: Visibility(
                                visible: arrCount == 0 ? false : true,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0.sp),
                                  child: Text(
                                    'Pay with other card',
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontFamily: 'Whitney Semi Bold',
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: needToShowForm ? true : false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 10.0.w),
                                    child: Text(
                                      'Name on card',
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
                                      maxLength: 16,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        counter: SizedBox.shrink(),
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
                                        child: GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (builder) {
                                                  return StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                                      return Container(
                                                        height: 150.0.w,
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
                                                                        'Month',
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
                                                                itemCount: monthList.length,
                                                                itemBuilder: (context, index) {
                                                                  return ConstrainedBox(
                                                                    constraints: BoxConstraints(
                                                                      minHeight: 15.0.w,
                                                                    ),
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          clickEventMonth(index);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                                        decoration: BoxDecoration(
                                                                          color: strSelectedMonth == monthList[index] ? themeYellow : testColor,
                                                                          borderRadius: BorderRadius.circular(7.0),
                                                                          // color: Colors.teal,
                                                                        ),
                                                                        child: Padding(
                                                                          padding: EdgeInsets.symmetric(vertical: 3.5.w, horizontal: 3.5.w),
                                                                          child: Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Text(
                                                                                  monthList[index],
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
                                          },
                                          child: Container(
                                            color: Colors.white,
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
                                                  margin: EdgeInsets.only(right: 14.0.sp),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.symmetric(vertical: 4.0.w, horizontal: 10.0.sp),
                                                        child: Text(
                                                          strSelectedMonth == '' ? 'MM' : strSelectedMonth,
                                                          style: kLableSignUpTextStyle,
                                                        ),
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons.caretDown,
                                                        size: 14.0.sp,
                                                      ),
                                                    ],
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
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (builder) {
                                                  return StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                                      return Container(
                                                        height: 150.0.w,
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
                                                                        'Year',
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
                                                                itemCount: yearList.length,
                                                                itemBuilder: (context, index) {
                                                                  return ConstrainedBox(
                                                                    constraints: BoxConstraints(
                                                                      minHeight: 15.0.w,
                                                                    ),
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          clickEventYear(index);
                                                                        });
                                                                      },
                                                                      child: Container(
                                                                        margin: EdgeInsets.fromLTRB(3.0.w, 3.0.w, 3.0.w, 0.0),
                                                                        decoration: BoxDecoration(
                                                                          color: strSelectedYear == yearList[index] ? themeYellow : testColor,
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
                                                                                  yearList[index],
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
                                          },
                                          child: Container(
                                            color: Colors.white,
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
                                                  margin: EdgeInsets.only(right: 14.0.sp),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.symmetric(vertical: 4.0.w, horizontal: 10.0.sp),
                                                        child: Text(
                                                          strSelectedYear == '' ? 'YYYY' : strSelectedYear,
                                                          style: kLableSignUpTextStyle,
                                                        ),
                                                      ),
                                                      Icon(
                                                        FontAwesomeIcons.caretDown,
                                                        size: 14.0.sp,
                                                      ),
                                                    ],
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
                                                controller: cvvController,
                                                style: kLableSignUpTextStyle,
                                                obscureText: true,
                                                maxLength: 3,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  counter: SizedBox.shrink(),
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
                                    padding: EdgeInsets.only(left: 10.0.sp, right: 10.0.sp, top: 10.0.w),
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isTermsAccepted) {
                                                isTermsAccepted = false;
                                              } else {
                                                isTermsAccepted = true;
                                              }
                                            });
                                          },
                                          child: Icon(
                                            isTermsAccepted ? FontAwesomeIcons.checkSquare : FontAwesomeIcons.square,
                                            // FontAwesomeIcons.square,
                                            size: 14.0.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.0.sp,
                                        ),
                                        Text(
                                          'Save this card for future payment',
                                          style: TextStyle(
                                            fontSize: 12.0.sp,
                                            fontFamily: 'Whitney Medium',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /*Container(
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
                        child: isLoaderShowing
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : (listCards != null && listCards.isNotEmpty)
                                ? ListView.builder(
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
                                  )
                                : Center(
                                    child: Text(
                                      'Oops no cards found for this user..',
                                      style: kValueLableWebinarDetailExpand,
                                    ),
                                  ),
                      ),*/
                            GestureDetector(
                              onTap: () {
                                checkForValidation();
                                /*Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    // builder: (context) => WebinarDetailsNew(strWebinarTypeIntent, webinarId),
                                    builder: (context) => WebinarDetailsNew(webinarTypeIntent, webinarId),
                                  ),
                                );*/
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 30.0.sp, horizontal: 10.0.sp),
                                height: 40.0.sp,
                                decoration: BoxDecoration(
                                  color: themeYellow,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.lock,
                                        size: 12.0.sp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 8.0.sp,
                                      ),
                                      Text(
                                        'Pay Now \$$webinarFee',
                                        style: kWebinarButtonLabelTextStyleWhite13,
                                      ),
                                    ],
                                  ),
                                ),
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
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    left: 0.0,
                    child: Visibility(
                      visible: isLoaderPayment ? true : false,
                      child: SpinKitSample1(),
                    ),
                  ),
                ],
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
      // this.getCardsList('$_authToken');
      setState(() {
        isLoaderShowing = true;
      });
      this.deleteUserCard('$_authToken', id.toString());
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

  void checkForValidation() async {
    print('State for isPaySelectded is : $isPaySelectedByCards');
    print('Request params are : auth_token : $_authToken');
    print('Request params are : webinar_id : $webinarId');
    print('Request params are : scheduleID : $scheduleId');
    print('Request params are : selectedCardID : $selectedCardId');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      if (isPaySelectedByCards) {
        print('Selected Card ID is : $selectedCardId');
        // Take register webinar API call from the using saved card ID..
        setState(() {
          isLoaderPayment = true;
        });
        resp = await registerPaidWebinarAPI(_authToken, webinarId.toString(), scheduleId.toString(), selectedCardId, '1', '', '', '', '', '', '');
        print(resp);
        setState(() {
          isLoaderPayment = false;
        });

        if (resp['success']) {
          // Then show message and redirect to webinar details screen using push replacement class..
          var respMsg = resp['message'].toString();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(respMsg),
              duration: Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(seconds: 2), () {
            if (ConstSignUp.isRegisterWebinarFromDetails) {
              setState(() {
                ConstSignUp.isRegisterWebinarFromDetails = false;
              });
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => WebinarDetailsNew(webinarTypeIntent, webinarId),
                ),
              );
            }
          });
        } else {
          var respMsg = resp['message'].toString();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(respMsg),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        if (nameController.text == '' || nameController.text.length == 0) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(strCardNameEmpty),
              duration: Duration(seconds: 3),
            ),
          );
        } else if (cardNumberController.text == '' || cardNumberController.text.length == 0) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(strCardNumberEmpty),
              duration: Duration(seconds: 3),
            ),
          );
        } else if (cardNumberController.text.length < 16) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(strCardNumberValid),
              duration: Duration(seconds: 3),
            ),
          );
        } else if (strSelectedMonth == '') {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(strExpMonthSelect),
              duration: Duration(seconds: 3),
            ),
          );
        } else if (strSelectedYear == '') {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(strExpYearSelect),
              duration: Duration(seconds: 3),
            ),
          );
        } else if (cvvController.text == '' || cvvController.text.length == 0) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(strCVVEmpty),
              duration: Duration(seconds: 3),
            ),
          );
        } else if (cvvController.text.length > 3) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(strCVVValid),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          // All validations passed..
          print('All validation passed for add card');
          // Take register webinar API call using call card data..
          // addCardAPI();
          setState(() {
            isLoaderPayment = true;
          });
          // resp = await registerPaidWebinarAPI(_authToken, webinarId.toString(), scheduleId, '', '1', '', '', '', '', '', '');
          var isCard = 0;
          setState(() {
            if (isTermsAccepted) {
              isCard = 1;
            } else {
              isCard = 0;
            }
          });
          resp = await registerPaidWebinarAPI(
              _authToken,
              webinarId.toString(),
              scheduleId.toString(),
              '',
              '$isCard',
              cardNumberController.text.toString(),
              strSelectedMonth,
              strSelectedYear,
              cvvController.text.toString(),
              'yes',
              nameController.text.toString());
          print(resp);
          setState(() {
            isLoaderPayment = false;
          });

          if (resp['success']) {
            // Then show message and redirect to webinar details screen using push replacement class..
            var respMsg = resp['message'].toString();
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(respMsg),
                duration: Duration(seconds: 3),
              ),
            );
            Future.delayed(const Duration(seconds: 3), () {
              if (ConstSignUp.isRegisterWebinarFromDetails) {
                setState(() {
                  ConstSignUp.isRegisterWebinarFromDetails = false;
                });
                Navigator.pop(context);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebinarDetailsNew(webinarTypeIntent, webinarId),
                  ),
                );
              }
            });
          } else {
            var respMsg = resp['message'].toString();
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(respMsg),
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );
      setState(() {
        isLoaderPayment = false;
      });
    }
  }

  void clickEventMonth(int index) {
    setState(() {
      strSelectedMonth = monthList[index].toString();
      FocusManager.instance.primaryFocus.unfocus();
      Navigator.pop(context);
    });
  }

  void clickEventYear(int index) {
    setState(() {
      strSelectedYear = yearList[index].toString();
      FocusManager.instance.primaryFocus.unfocus();
      Navigator.pop(context);
    });
  }

  void addCardAPI() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      setState(() {
        isLoaderShowing = true;
      });
      this.addUserCardAPI('$_authToken');
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please check your internet connectivity and try again"),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Login(false),
        ),
        (Route<dynamic> route) => false);
  }

  void unCheckAllCard() {
    for (int i = 0; i < listCards.length; i++) {
      setState(() {
        listCards[i].defaultCard = '0';
      });
    }
  }
}
