import 'package:flutter/material.dart';

import 'fade_route.dart';
import 'hero_test.dart';
import 'scal_animation.dart';
import 'stagger_test.dart';

class AnimationTest extends StatefulWidget {
  AnimationTest({Key key}) : super(key: key);

  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Test'),
      ),
      body: Container(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            button(title: 'ScaleAnimationRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => ScaleAnimationRoute()))),
            button(title: 'ScaleAnimationRoute1',onTap: ()=> Navigator.push(context, PageRouteBuilder(transitionDuration: Duration(milliseconds: 500),pageBuilder: (c, Animation animation,
              Animation secondaryAnimation) => FadeTransition(
                //使用渐隐渐入过渡,
                opacity: animation,
                child: ScaleAnimationRoute1(), 
              )))),
            button(title: 'FadeRoute->PageB',onTap: ()=> Navigator.push(context, FadeRoute(builder: (context)=> PageB()))),
            // button(title: 'HeroAnimationRoute',onTap: ()=> Navigator.push(context, FadeRoute(builder: (context)=> HeroAnimationRoute()))),
            button(title: 'HeroTest',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => HeroTest()))),
            button(title: 'StaggerRoute',onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (c) => StaggerRoute()))),
          ],
        ),
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
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
}