import 'dart:convert';

import 'package:cpe_flutter/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWebinarFrag extends StatefulWidget {
  @override
  _MyWebinarFragState createState() => _MyWebinarFragState();
}

class _MyWebinarFragState extends State<MyWebinarFrag> {
  List<int> tempInt = [1, 4, 5, 7];
  int arrCount = 0;
  var data;

  Future<String> getDataWebinarList(
      String authToken,
      String start,
      String limit,
      String topic_of_interest,
      String subject_area,
      String webinar_key_text,
      String webinar_type,
      String date_filter,
      String filter_price) async {
    // String urls = URLs.BASE_URL + 'webinar/list';
    String urls = 'https://my-cpe.com/api/v3/webinar/list';

    String updatedToken = '';
    if (authToken.length == 0) {
      // Considered as guest mode..
      updatedToken = '';
    } else {
      // Consider as auth user..
      updatedToken = 'Bearer $authToken';
    }
    final response = await http.post(
      urls,
      headers: {
        'Accept': 'Application/json',
        'Authorization': '$updatedToken',
      },
      body: {
        'start': start,
        'limit': limit,
        'topic_of_interest': topic_of_interest,
        'subject_area': subject_area,
        'webinar_key_text': webinar_key_text,
        'webinar_type': webinar_type,
        'date_filter': date_filter,
        'filter_price': filter_price,
      },
    );

    this.setState(() {
      // data = JSON.decode(response.body);
      data = jsonDecode(response.body);
    });

    // print(data[1]["title"]);
    print('API response is : $data');
    arrCount = data['payload']['webinar'].length;
    print('Size for array is : $arrCount');

    return "Success!";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getDataWebinarList('', '0', '10', '', '', '', 'self_study', '', '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 70.0,
              width: double.infinity,
              color: Color(0xFFF3F5F9),
              child: Center(
                child: Text(
                  'My Webinar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontFamily: 'Whitney Semi Bold',
                  ),
                ),
              ),
            ),
            Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.blueGrey,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: arrCount,
                itemBuilder: (context, index) {
                  return Container(
                    // margin: EdgeInsets.only(top: 10.0),
                    margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFC803),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    height: 270.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 15.0),
                                height: 35.0,
                                width: 110.0,
                                child: Card(
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      '${data['payload']['webinar'][index]['webinar_type']}',
                                      style: kWebinarButtonLabelTextStyleGreen,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 35.0,
                                width: 70.0,
                                child: Card(
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      '${data['payload']['webinar'][index]['cpa_credit']}',
                                      style: kWebinarButtonLabelTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15.0),
                                height: 35.0,
                                width: 70.0,
                                child: Card(
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      '${data['payload']['webinar'][index]['fee']}',
                                      style: kWebinarButtonLabelTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(18.0, 10.0, 30.0, 0),
                          child: Text(
                            '${data['payload']['webinar'][index]['webinar_title']}',
                            style: kWebinarTitleLabelTextStyle,
                            maxLines: 3,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(18.0, 5.0, 30.0, 0),
                          child: Row(
                            children: [
                              Text(
                                '${data['payload']['webinar'][index]['speaker_name']}',
                                style: kWebinarSpeakerNameLabelTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(18.0, 15.0, 0.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFC2900D),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            height: 40.0,
                            width: 170.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Register',
                                    style: kWebinarButtonLabelTextStyleWhite,
                                  ),
                                ),
                                /*Icon(IconData(
                                  icon
                                ),),*/
                                /*Icon(
                                  icon: FontAwesomeIcons.arrowRight,
                                  onPressed: () async {
                                    getUserData();
                                  },
                                ),*/
                              ],
                            ),
                          ),
                        ),
                        /*Image.asset(
                          'assets/avatar_bottom_right.png',
                          height: 130.0,
                          width: 130.0,
                        ),*/
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
