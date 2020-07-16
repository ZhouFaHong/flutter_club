import 'package:flutter/material.dart';

import 'both_direction_test.dart';
import 'cale_test_route.dart';
import 'event_poiter_test.dart';
import 'gesture_conflict_test_route.dart';
import 'gesture_recognizer_test_route.dart';
import 'notification_test.dart';


class GestureTest extends StatefulWidget {
  GestureTest({Key key}) : super(key: key);

  @override
  _GestureTestState createState() => _GestureTestState();
}

class _GestureTestState extends State<GestureTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Test'),
      ),
      body: Container(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            button(title: 'EventPointerTest',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => EventPointerTest()))),
            button(title: 'GestureRecognizerTestRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => GestureRecognizerTestRoute()))),
            button(title: 'BothDirectionTestRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => BothDirectionTestRoute()))),
            button(title: 'GestureConflictTestRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => GestureConflictTestRoute()))),
            button(title: 'NotificationTest',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => NotificationTest()))),
            
          ],
        ),
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (c)=>ScaleTestRoute()));
        },
        tooltip: 'ScaleTest',
        child: Icon(Icons.add),
      ), 
    );
  }

  Widget button({title,onTap}){
    return Center(child: FlatButton(
      onPressed: onTap,
      textColor: Colors.red,
      child: Text(title??'title'),
    ),);
  }
}