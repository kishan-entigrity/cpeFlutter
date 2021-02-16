import 'package:cpe_flutter/screens/fragments/pagination/weblist.dart';
import 'package:cpe_flutter/screens/fragments/pagination_new/Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebListingPagination extends StatefulWidget {
  @override
  _WebListingPaginationState createState() => _WebListingPaginationState();
}

class _WebListingPaginationState extends State<WebListingPagination> {
  ScrollController _scrollController = new ScrollController();
  List<WebList> _list;
  List<Webinar> _webList;
  bool _loading;

  String _authToken = "";

  static const String webListUrl = "https://my-cpe.com/api/v3/webinar/list";

  @override
  void initState() {
    super.initState();
    _loading = true;
    checkForSP();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
            controller: _scrollController,
            // itemCount: arrCount,
            itemCount: null == _list ? 0 : _list.length,
            itemBuilder: (context, index) {
              WebList webList = _list[index];
              Webinar webListnew = _list[index].payload.webinar as Webinar;

              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 50.0,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  padding: EdgeInsets.all(10.0),
                  color: Colors.blueGrey,
                  child: Center(
                    child: Text(
                      // '${data['payload']['webinar'][index]['webinar_title']}',
                      // '${strTitles[index]}',
                      // '${webList.payload.webinar.}',
                      '',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void checkForSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool checkValue = preferences.getBool("check");

    if (checkValue != null) {
      /*setState(() {
        isLoaderShowing = true;
      });*/
      if (checkValue) {
        String token = preferences.getString("spToken");
        _authToken = 'Bearer $token';

        // Service.webListUrl('$_authToken', '0', '10', '', '', '', 'self_study', '', '0');
        Service.getWebList('$_authToken', '0', '10', '', '', '', 'self_study', '', '0').then((users) {
          setState(() {
            _list = users;
            _loading = false;
          });
        });

        /*print('Auth Token from SP is : $_authToken');

        // this.getDataWebinarList('$_authToken', '0', '10', '', '', '', '$strWebinarType', '', '$strFilterPrice');
        print('Request Parms : start : $start :: end : $end :: type : self_study :: price : 0');
        this.getDataWebinarList('$_authToken', '$start', '$end', '', '', '', 'self_study', '', '0');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');*/
      } else {
        // this.getDataWebinarList('$_authToken', '0', '10', '', '', '','$strWebinarType', '', '$strFilterPrice');
        /*this.getDataWebinarList('$_authToken', '$start', '$end', '', '', '', 'self_study', '', '0');
        // print('init State isLive : $isLive');
        // print('init State isSelfStudy : $isSelfStudy');
        print('Check value : $checkValue');
        preferences.clear();*/
      }
    }
  }
}
