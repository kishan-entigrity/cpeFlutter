import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class HashMapSample extends StatefulWidget {
  @override
  _HashMapSampleState createState() => _HashMapSampleState();
}

class _HashMapSampleState extends State<HashMapSample> {
  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  var result = '';

  // HashMap hashMap = new HashMap<String, String>();
  Map mapSample = new Map<String, String>();

  bool isAlreadyChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.teal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                child: Text(
                  'Hashmap Sample',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
              /*SizedBox(
                height: 30.0,
              ),*/
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: TextField(
                  controller: keyController,
                  style: kLableSignUpTextStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Key',
                    hintStyle: kLableSignUpHintStyle,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: TextField(
                  controller: valueController,
                  style: kLableSignUpTextStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Value',
                    hintStyle: kLableSignUpHintStyle,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // hashMap.update(keyController.text, (value) => valueController.text.toString());
                        // hashMap.addEntries(newEntries)
                        mapSample[keyController.text] = valueController.text;
                        setState(() {
                          // result = hashMap.toString();
                          result = mapSample.toString();
                        });
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Text('Add'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        mapSample.remove(keyController.text);
                        setState(() {
                          // result = hashMap.toString();
                          result = mapSample.toString();
                        });
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Text('Delete'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        var len = mapSample.length;
                        print('Size for map is : $len');
                        // mapSample.keys.forEach((k) => print(k));
                        mapSample.keys.forEach((k) => {
                              if (k == keyController.text)
                                {
                                  isAlreadyChecked = true,
                                  // So here if we have the key then delete this data..
                                  mapSample.remove(keyController.text),
                                  setState(() {
                                    // result = hashMap.toString();
                                    result = mapSample.toString();
                                  })
                                }
                              else
                                {
                                  // isAlready
                                  isAlreadyChecked = false,
                                  // If we don't have the data then add this data..
                                  mapSample[keyController.text] = valueController.text,
                                  setState(() {
                                    // result = hashMap.toString();
                                    result = mapSample.toString();
                                  })
                                }
                            });

                        print('State is data there? $isAlreadyChecked');
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Text('Check'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        mapSample[keyController.text] = valueController.text;
                        print('Data for give key : ${mapSample[keyController.text]}');
                        print('Data for give key New: ${mapSample['22']}');
                        setState(() {
                          // result = hashMap.toString();
                          result = mapSample.toString();
                        });
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Text('Test'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text('HashMap Data'),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(result == '' ? 'Result' : result),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
