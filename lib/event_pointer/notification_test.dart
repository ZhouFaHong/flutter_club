import 'package:flutter/material.dart';

class NotificationTest extends StatefulWidget {
  NotificationTest({Key key}) : super(key: key);

  @override
  _NotificationTestState createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  Widget button({title,onTap}){
    return Center(child: FlatButton(
      onPressed: onTap,
      textColor: Colors.red,
      child: Text(title??'title'),
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NotificationListener(
        onNotification: (notification){
          switch (notification.runtimeType){
            case ScrollStartNotification: print("开始滚动"); break;
            case ScrollUpdateNotification: print("正在滚动"); break;
            case ScrollEndNotification: print("滚动停止"); break;
            case OverscrollNotification: print("滚动到边界"); break;
          }
          return true;
        },
        child: 
        button(title: 'ProviderRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => NotificationTest1()))),
        // ListView.builder(
        //     itemCount: 100,
        //     itemBuilder: (context, index) {
        //       return ListTile(title: Text("$index"),);
        //     }
        // ),
      ),
    );
  }
}


class NotificationTest1 extends StatefulWidget {
  NotificationTest1({Key key}) : super(key: key);

  @override
  _NotificationTestState1 createState() => _NotificationTestState1();
}

class _NotificationTestState1 extends State<NotificationTest1> {
  Widget button({title,onTap}){
    return Center(child: FlatButton(
      onPressed: onTap,
      textColor: Colors.red,
      child: Text(title??'title'),
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: 
      // NotificationListener(
      //   onNotification: (notification){
      //     switch (notification.runtimeType){
      //       case ScrollStartNotification: print("开始滚动"); break;
      //       case ScrollUpdateNotification: print("正在滚动"); break;
      //       case ScrollEndNotification: print("滚动停止"); break;
      //       case OverscrollNotification: print("滚动到边界"); break;
      //     }
      //     return true;
      //   },
      // child:
        ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(title: Text("$index"),);
            }
        ),
      // ),
    );
  }
}


