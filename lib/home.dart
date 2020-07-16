import 'package:flutter/material.dart';
import 'package:flutter_club/event_pointer/event_poiter_test.dart';
import 'package:flutter_club/inherited/inherited_test_route.dart';

import 'animation/animation_test.dart';
import 'context_route.dart';
import 'dialog/dialog_test.dart';
import 'event_pointer/both_direction_test.dart';
import 'event_pointer/gesture_conflict_test_route.dart';
import 'event_pointer/gesture_recognizer_test_route.dart';
import 'event_pointer/gesture_test.dart';
import 'event_pointer/notification_test.dart';
import 'futurebuilder_and_streambuilder.dart';
import 'http_test.dart';
import 'navi.dart';
import 'notis_scrollview.dart';
import 'provider/provider_test_route.dart';
import 'theme_text_route.dart';
import 'websocket/websocket_demo.dart';
import 'will_pop_cope_test_route.dart';
import 'zidingyizujian/custom_paint_route.dart';
import 'zidingyizujian/gradient_circular_progress_indicator_demo.dart';
import 'zidingyizujian/turn_box_demo.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _incrementCounter() async {
    var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
    var savePath = "/Volumes/Love_Noah/flutter/flutter_club/example/HBuilder.9.0.2.macosx_64.dmg";
    print(savePath);
    await downloadWithChunks(url, savePath, onReceiveProgress: (received, total) {
      if (total != -1) {
        print("${(received / total * 100).floor()}%");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                //背景为蓝色，则title自动为白色
                NavBar(color: Colors.blue, title: "标题"), 
                //背景为白色，则title自动为黑色
                NavBar(color: Colors.white, title: "标题"),
              ]
            ),//
            button(title: 'Context',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => ContextRoute()))),
            button(title: 'ShowSnackBar',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => ContextSnackBar()))),
            button(title: 'ScrollNotificationTestRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => ScrollNotificationTestRoute()))),
            button(title: 'WillPopScopeTestRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => WillPopScopeTestRoute()))),
            button(title: 'InheritedWidgetTestRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => InheritedWidgetTestRoute()))),
            button(title: 'ProviderRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => ProviderRoute()))),
            button(title: 'ThemeTestRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => ThemeTestRoute()))),
            button(title: 'FutureBuilderAndStreamBuilderTest',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => FutureBuilderAndStreamBuilderTest()))),
            button(title: 'DialogTest',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => DialogTest()))),
            button(title: 'GestureTest',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => GestureTest()))),
            button(title: 'AnimationTest',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => AnimationTest()))),
            button(title: 'TurnBoxRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => TurnBoxRoute()))),
            button(title: 'CustomPaintRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => CustomPaintRoute()))),
            button(title: 'GradientCircularProgressRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => GradientCircularProgressRoute()))),
            button(title: 'HttpTestRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => HttpTestRoute()))),
            button(title: 'WebSocketRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => WebSocketRoute()))),
          ],
        ),
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
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
  @override
  void initState() { 
    super.initState();
    streamTest();
    futureTest();
  }
  streamTest(){
    Stream.fromFutures([
      // 1秒后返回结果
      Future.delayed(new Duration(seconds: 1), () {
        return "hello 1";
      }),
      // 抛出一个异常
      Future.delayed(new Duration(seconds: 2),(){
        throw AssertionError("Error");
      }),
      // 3秒后返回结果
      Future.delayed(new Duration(seconds: 3), () {
        return "hello 3";
      })
    ]).listen((data){
      print(data);
    }, onError: (e){
      print(e.message);
    },onDone: (){

    });
  }

  futureTest() async {
    Future.wait([

      Future.delayed(new Duration(seconds: 2), () {
        return "Hello ";
      }),
      Future.delayed(new Duration(seconds: 4), () {
        return "world!";
      })
    ]).then((value) {

      /// 
      print(value[0] + value[1]);

    });
  }


}