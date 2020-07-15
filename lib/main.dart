import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'home.dart';

void main() {
  debugPaintSizeEnabled = true;
  runZoned(()=>runApp(MyApp()),zoneSpecification: ZoneSpecification(
    print: (self, parent, zone, line) {
      parent.print(zone, '--自定义Log:  $line');
    },
  ),onError: (Object obj,StackTrace s){

  });
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Club',
      theme: ThemeData(
        
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Club Home Page'),
    );
  }
}


