import 'package:cpe_flutter/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/style.dart';
import 'package:sizer/sizer.dart';

class childCardOthers extends StatefulWidget {
  childCardOthers(this.webDetailsObj);

  final webDetailsObj;

  @override
  _childCardOthersState createState() => _childCardOthersState(webDetailsObj);
}

class _childCardOthersState extends State<childCardOthers> {
  _childCardOthersState(this.webDetailsObj);

  final webDetailsObj;

  bool isIrsVisible = false;
  bool isCtecVisible = false;
  bool isNasbaVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (webDetailsObj['webinar_type'] == 'CPE/CE') {
        isIrsVisible = true;
        isNasbaVisible = true;
      } else if (webDetailsObj['webinar_type'] == 'CPE') {
        isIrsVisible = false;
        isNasbaVisible = true;
      } else if (webDetailsObj['webinar_type'] == 'CE') {
        isIrsVisible = true;
        isNasbaVisible = false;
      }

      if (webDetailsObj['ctec_course_id'].toString().isEmpty) {
        isCtecVisible = false;
      } else {
        isCtecVisible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0.sp),
          FaqContainer(webDetailsObj),
          SizedBox(height: 15.0.sp),
          RefundCancelContainer(webDetailsObj),
          NasbaContainer(isNasbaVisible, webDetailsObj),
          IrsContainer(isIrsVisible, webDetailsObj),
          CtecContainer(isCtecVisible, webDetailsObj),
        ],
      ),
    );
  }
}

class CtecContainer extends StatelessWidget {
  CtecContainer(this.isCtecVisible, this.webDetailsObj);

  final bool isCtecVisible;
  final webDetailsObj;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isCtecVisible ? true : false,
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CTEC APPROVED',
              style: kOthersTitle,
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    webDetailsObj['ctec_approved']['address'].toString(),
                    // 'test Data',
                    style: kOthersAddress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: FadeInImage(
                    height: 60.0,
                    width: 60.0,
                    placeholder: AssetImage('assets/webinar_placeholder.jpg'),
                    image: NetworkImage(webDetailsObj['ctec_approved']['ctec_profile_icon']),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Html(
              data: webDetailsObj['ctec_approved']['ctec_desc'].toString(),
              /*style: {
                "body": Style(
                  fontFamily: 'Whitney Medium',
                  fontSize: FontSize(13.0.sp),
                  color: black50,
                ),
              },*/
              defaultTextStyle: kOthersDescription,
            ),
          ],
        ),
      ),
    );
  }
}

class IrsContainer extends StatelessWidget {
  IrsContainer(this.isIrsVisible, this.webDetailsObj);

  final bool isIrsVisible;
  final webDetailsObj;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isIrsVisible ? true : false,
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'IRS APPROVED',
              style: kOthersTitle,
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    webDetailsObj['irs_approved']['irs_address'].toString(),
                    // 'test Data',
                    style: kOthersAddress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: FadeInImage(
                    height: 60.0,
                    width: 60.0,
                    placeholder: AssetImage('assets/webinar_placeholder.jpg'),
                    image: NetworkImage(webDetailsObj['irs_approved']['irs_profile_icon']),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Html(
              data: webDetailsObj['irs_approved']['irs_desc'].toString(),
              /*style: {
                "body": Style(
                  fontFamily: 'Whitney Medium',
                  fontSize: FontSize(13.0.sp),
                  color: black50,
                ),
              },*/
              defaultTextStyle: kOthersDescription,
            ),
          ],
        ),
      ),
    );
  }
}

class NasbaContainer extends StatelessWidget {
  NasbaContainer(this.isNasbaVisible, this.webDetailsObj);

  final bool isNasbaVisible;
  final webDetailsObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Visibility(
        visible: isNasbaVisible ? true : false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'NASBA APPROVED',
              style: kOthersTitle,
            ),
            SizedBox(height: 10.0.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    webDetailsObj['nasba_approved']['address'],
                    style: kOthersAddress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: <Widget>[
                      FadeInImage(
                        height: 40.0,
                        width: 40.0,
                        placeholder: AssetImage('assets/webinar_placeholder.jpg'),
                        image: NetworkImage(webDetailsObj['nasba_approved']['nasba_profile_icon']),
                        fit: BoxFit.fitWidth,
                      ),
                      Visibility(
                        visible: (webDetailsObj['nasba_approved']['nasba_profile_icon_qas'].toString().isEmpty ? false : true),
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: FadeInImage(
                            height: 50.0,
                            width: 50.0,
                            placeholder: AssetImage('assets/webinar_placeholder.jpg'),
                            image: NetworkImage(webDetailsObj['nasba_approved']['nasba_profile_icon_qas']),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Html(
              data: webDetailsObj['nasba_approved']['nasba_desc'],
              /*style: {
                "body": Style(
                  fontFamily: 'Whitney Medium',
                  fontSize: FontSize(13.0.sp),
                  color: black50,
                ),
              },*/
              defaultTextStyle: kOthersDescription,
            ),
          ],
        ),
      ),
    );
  }
}

class RefundCancelContainer extends StatelessWidget {
  RefundCancelContainer(this.webDetailsObj);

  final webDetailsObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'REFUND/CANCELLATION POLICY',
            style: kOthersTitle,
          ),
          SizedBox(height: 10.0.sp),
          Html(
            data: webDetailsObj['refund_and_cancelation_policy'],
            /*style: {
              "body": Style(
                fontFamily: 'Whitney Medium',
                fontSize: FontSize(13.0.sp),
                color: black50,
              ),
            },*/
            defaultTextStyle: kOthersDescription,
          ),
        ],
      ),
    );
  }
}

class FaqContainer extends StatelessWidget {
  FaqContainer(this.webDetailsObj);

  final webDetailsObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'FAQ',
            style: kOthersTitle,
          ),
          SizedBox(height: 10.0.sp),
          Html(
            data: webDetailsObj['faq'],
            /*style: {
              "body": Style(
                fontFamily: 'Whitney Medium',
                fontSize: FontSize(13.0.sp),
                color: black50,
              ),
            },*/
            defaultTextStyle: kOthersDescription,
          ),
        ],
      ),
    );
  }
}
