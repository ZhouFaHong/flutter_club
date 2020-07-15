import 'package:flutter/material.dart';

import 'cale_test_route.dart';

class EventPointerTest extends StatefulWidget {
  EventPointerTest({Key key}) : super(key: key);

  @override
  _EventPointerTestState createState() => _EventPointerTestState();
}

class _EventPointerTestState extends State<EventPointerTest> {
  //定义一个状态，保存当前指针位置
  PointerEvent _event;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          // Container(
          //   child: Listener(
          //     child: Container(
          //       alignment: Alignment.center,
          //       color: Colors.blue,
          //       width: 300.0,
          //       height: 150.0,
          //       child: Text(_event?.toString()??"",style: TextStyle(color: Colors.white)),
          //     ),
          //     onPointerDown: (PointerDownEvent event) => setState(()=>_event=event),
          //     onPointerMove: (PointerMoveEvent event) => setState(()=>_event=event),
          //     onPointerUp: (PointerUpEvent event) => setState(()=>_event=event,),
          //   ),
          // ),
          // Listener(
          //   child: ConstrainedBox(
          //     constraints: BoxConstraints.tight(Size(300.0, 200.0)),
          //     child: DecoratedBox(
          //         decoration: BoxDecoration(color: Colors.blue)),
          //   ),
          //   onPointerDown: (event) => print("down0"),
          // ),
          // Listener(
          //   child: ConstrainedBox(
          //     constraints: BoxConstraints.tight(Size(200.0, 100.0)),
          //     child: Center(child: Text("左上角200*100范围内非文本区域点击")),
          //   ),
          //   onPointerDown: (event) => print("down1"),
          //   //behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
          // ),
        //   Positioned(top: 0,right: 0,
        //     child: Listener(
        //     child: ConstrainedBox(
        //         constraints: BoxConstraints.tight(Size(300.0, 150.0)),
        //         child: Center(child: Text("Box A")),
        //     ),
        //     behavior: HitTestBehavior.opaque,
        //     onPointerDown: (event) => print("down A")
        // ),)
          GestureDetector(),
          _Drag(),
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(200.0, 100.0)),
              child: Center(child: Text("左上角200*100范围内非文本区域点击")),
            ),
            onPointerDown: (event) => print("down1"),
            behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
          ),
          // Listener(
          //   child: AbsorbPointer(
          //     child: Listener(
          //       child: Container(
          //         color: Colors.red,
          //         width: 200.0,
          //         height: 100.0,
          //       ),
          //       onPointerDown: (event)=>print("in"),
          //     ),
          //   ),
          //   onPointerDown: (event)=>print("up"),
          // )
        ],
      )
    );
  }
}



class _Drag extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}

class _DragState extends State<_Drag> with SingleTickerProviderStateMixin {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0;//距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(

            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
              Navigator.push(context, MaterialPageRoute(builder: (c)=>ScaleTestRoute()));
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e){
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        )
      ],
    );
  }
}