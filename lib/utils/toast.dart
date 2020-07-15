import 'package:fluttertoast/fluttertoast_web.dart';

class Toast {
  final FluttertoastWebPlugin flutterToastWebPlugin = FluttertoastWebPlugin();
  static Toast _instance;

  Toast._internal();

  factory Toast() {
    if (_instance == null) {
      _instance = new Toast._internal();
    }
    return _instance;
  }

  void showToast(message) {
    flutterToastWebPlugin.showToast({'msg': message,'gravity':'bottom','webPosition':'center'});
  }
}
