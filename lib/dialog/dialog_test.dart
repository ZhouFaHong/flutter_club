import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialog_checkbox.dart';

class DialogTest extends StatefulWidget {
  DialogTest({Key key}) : super(key: key);

  @override
  _DialogTestState createState() => _DialogTestState();
}

class _DialogTestState extends State<DialogTest> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DialogTest'),),
      body: Container(
       child: //点击该按钮后弹出对话框
          Column(
            children: [
              RaisedButton(
                child: Text("对话框1"),
                onPressed: () async {
                  //弹出对话框并等待其关闭
                  bool delete = await showDeleteConfirmDialog1();
                  if (delete == null) {
                    print("取消删除");
                  } else {
                    print("已确认删除");
                    //... 删除文件
                  }
                },
              ),
              RaisedButton(
                child: Text("对话框列表"),
                onPressed: () async {
                  //弹出对话框并等待其关闭
                  await showListDialog();
                },
              ),
              RaisedButton(
                child: Text("话框3（复选框可点击）-- 单独抽离出StatefulWidget"),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  bool deleteTree = await showDeleteConfirmDialog3();
                  if (deleteTree == null) {
                    print("取消删除");
                  } else {
                    print("同时删除子目录: $deleteTree");
                  }
                },
              ),
              RaisedButton(
                child: Text("话框4（复选框可点击）-- StatefulBuilder"),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  bool deleteTree = await showDeleteConfirmDialog4();
                  if (deleteTree == null) {
                    print("取消删除");
                  } else {
                    print("同时删除子目录: $deleteTree");
                  }
                },
              ),
              RaisedButton(
                child: Text("话框5（复选框可点击）-- (context as Element).markNeedsBuild()"),
                onPressed: () async {
                  //弹出删除确认对话框，等待用户确认
                  bool deleteTree = await showDeleteConfirmDialog5();
                  if (deleteTree == null) {
                    print("取消删除");
                  } else {
                    print("同时删除子目录: $deleteTree");
                  }
                },
              ),
              RaisedButton(
                child: Text("show loading"),
                onPressed: () async {
                  await showLoadingDialog();
                },
              ),
              RaisedButton(
                child: Text("展示日历"),
                onPressed: () async {
                  await _showDatePicker1();
                },
              ),
              RaisedButton(
                child: Text("展示iOS风格日历"),
                onPressed: () async {
                  await _showDatePicker2();
                },
              ),
            ],
          ),
      ),
    );
  }
  // 弹出对话框
  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> showListDialog() async {
    int index = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        var child = Column(
          children: <Widget>[
            ListTile(title: Text("请选择")),
            Expanded(
                child: ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                  onTap: () => Navigator.of(context).pop(index),
                );
              },
            )),
          ],
        );
        //使用AlertDialog会报错
        //return AlertDialog(content: child);
        return Dialog(child: child);
      },
    );
    if (index != null) {
      print("点击了：$index");
    }
  }



  Future<bool> showDeleteConfirmDialog3() {
    bool _withTree = false; //记录复选框是否选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  DialogCheckbox(
                    value: _withTree, //默认不选中
                    onChanged: (bool value) {
                      //更新选中状态
                      _withTree = !_withTree;
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showDeleteConfirmDialog4() {
    bool _withTree = false; //记录复选框是否选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  // 使用StatefulBuilder来构建StatefulWidget上下文
                  StatefulBuilder(builder: (c,state){
                    return Checkbox(
                      value: _withTree, //默认不选中
                      onChanged: (bool value) {
                        //state方法实际就是该StatefulWidget的setState方法，
                        //调用后builder方法会重新被调用
                        state(() {
                          //更新选中状态
                          _withTree = !_withTree;
                        });
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> showDeleteConfirmDialog5() {
    bool _withTree = false; //记录复选框是否选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  // 通过Builder来获得构建Checkbox的`context`，
                  // 这是一种常用的缩小`context`范围的方式
                  Builder(builder: (con){
                    return Checkbox(
                      value: _withTree, //默认不选中
                      onChanged: (bool value) {
                        // 此时context为对话框UI的根Element，我们 
                        // 直接将对话框UI对应的Element标记为dirty
                        (con as Element).markNeedsBuild();
                        _withTree = !_withTree;
                      },
                    );  
                  }),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, 
      builder: (context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 270,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: Text("正在加载，请稍后..."),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<DateTime> _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add( //未来30天可选
        Duration(days: 30),
      ),
    );
  }
  Future<DateTime> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              print(value);
            },
          ),
        );
      },
    );
  }

}