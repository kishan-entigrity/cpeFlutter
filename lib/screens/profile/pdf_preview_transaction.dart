import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constant.dart';

class TransactionPdfPreview extends StatefulWidget {
  TransactionPdfPreview(this.strUrl);

  final String strUrl;
  @override
  _TransactionPdfPreviewState createState() => _TransactionPdfPreviewState(strUrl);
}

class _TransactionPdfPreviewState extends State<TransactionPdfPreview> {
  _TransactionPdfPreviewState(this.strUrl);

  final String strUrl;

  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Url on get intent is : $strUrl');
    loadDocument();
  }

  loadDocument() async {
    // document = await PDFDocument.fromAsset('assets/sample.pdf');
    document = await PDFDocument.fromURL(
      "$strUrl",
      cacheManager: CacheManager(
        Config(
          "customCacheKey",
          stalePeriod: const Duration(days: 2),
          maxNrOfCacheObjects: 10,
        ),
      ),
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                          'Receipt',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.5.sp,
                            fontFamily: 'Whitney Semi Bold',
                          ),
                        ),
                      ),
                      flex: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Click event for share receipt');
                      },
                      child: Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            FontAwesomeIcons.shareAlt,
                          ),
                        ),
                        flex: 1,
                      ),
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
                      top: 0.0.sp,
                      bottom: 15.0.h,
                      right: 0.0.sp,
                      left: 0.0.sp,
                      child: Container(
                        child: Center(
                          child: _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : PDFViewer(
                                  document: document,
                                  zoomSteps: 1,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0.sp,
                      right: 0.0.sp,
                      left: 0.0.sp,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                        height: 15.0.h,
                        // color: Colors.teal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Download',
                              style: kButtonLabelTextStyle,
                            ),
                            Container(
                              height: 40.0.sp,
                              width: 40.0.sp,
                              padding: EdgeInsets.symmetric(vertical: 10.0.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0.sp),
                                color: themeYellow,
                              ),
                              child: Image.asset(
                                'assets/download.png',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
