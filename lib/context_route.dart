import 'package:flutter/material.dart';


class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Context测试"),
      ),
      body: Container(
        child: Builder(builder: (context) {
          // 在Widget树中向上查找最近的父级`Scaffold` widget
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          // 直接返回 AppBar的title， 此处实际上是Text("Context测试")
          return (scaffold.appBar as AppBar).title;
        }),
      ),
    );
  }
}

class ContextSnackBar extends StatefulWidget {
  ContextSnackBar({Key key}) : super(key: key);

  @override
  _ContextSnackBarState createState() => _ContextSnackBarState();
}

class _ContextSnackBarState extends State<ContextSnackBar> {

  /// 注意：使用GlobalKey开销较大，如果有其他可选方案，应尽量避免使用它。另外同一个GlobalKey在整个widget树中必须是唯一的，不能重复。
  GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("子树中获取State对象"),
      ),
      body: Center(
        child: Builder(builder: (context) {
          return RaisedButton(
            onPressed: () {
              // 查找父级最近的Scaffold对应的ScaffoldState对象
              // ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
              // 直接通过of静态方法来获取ScaffoldState 
              ScaffoldState _state=Scaffold.of(context); 
              // ScaffoldState _s=_globalKey.currentState; 
              //调用ScaffoldState的showSnackBar来弹出SnackBar
              _state.showSnackBar(
                
                SnackBar(
                  content: Text("我是SnackBar"),
                ),
              );
              // _s.showBottomSheet((context) => Text("我是SnackBar"));
              // _s.openEndDrawer();
              // _s.openDrawer();
            },
            child: Text("显示SnackBar"),
          );
        }),
      ),
    );
  }
}