import 'package:cpe_flutter/constant.dart';
import 'package:cpe_flutter/screens/fragments/testimonials.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:sizer/sizer.dart';

class childCardTestimonials extends StatefulWidget {
  childCardTestimonials(this.strDetails, this.respTestimonials, this.webinarId);

  final String strDetails;
  final respTestimonials;
  final String webinarId;

  @override
  _childCardTestimonialsState createState() => _childCardTestimonialsState(respTestimonials, webinarId);
}

class _childCardTestimonialsState extends State<childCardTestimonials> {
  _childCardTestimonialsState(this.respTestimonials, this.webinarId);

  final respTestimonials;
  final String webinarId;

  @override
  Widget build(BuildContext context) {
    return Container(
      /*child: Text(
        strDetails,
      ),*/
      child: Column(
        children: <Widget>[
          TestimonialDataCell(respTestimonials[0]['first_name'] + ' ' + respTestimonials[0]['last_name'] + respTestimonials[0]['designation'],
              respTestimonials[0]['date'], respTestimonials[0]['rate'], respTestimonials[0]['review']),
          Container(
            width: double.infinity,
            height: 0.5,
            color: Colors.black,
          ),
          SizedBox(
            height: 10.0,
          ),
          TestimonialDataCell(respTestimonials[1]['first_name'] + ' ' + respTestimonials[1]['last_name'] + respTestimonials[1]['designation'],
              respTestimonials[1]['date'], respTestimonials[1]['rate'], respTestimonials[1]['review']),
          GestureDetector(
            // Have to put Navigator call for Testimonials screen from here..
            // Have to pass the data of webinar ID..
            onTap: () {
              print('Clicked on view more button');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Testimonials(webinarId),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'View More',
                style: kUserDataBlueTestimonials,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TestimonialDataCell extends StatelessWidget {
  TestimonialDataCell(this.userNameData, this.testimonialDate, this.rating, this.review);

  final String userNameData;
  final String testimonialDate;
  final String rating;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  userNameData,
                  // 'Hello World Hello World Hello World Hello World Hello World Hello World Hello World ',
                  style: kUserDataTestimonials,
                ),
              ),
              Container(
                child: Text(
                  testimonialDate,
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
              initialRating: double.parse(rating),
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
              review,
              style: kKeyLableWebinarDetailExpand,
            ),
          ),
        ],
      ),
    );
  }
}
