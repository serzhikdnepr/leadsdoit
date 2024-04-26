import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppUtils {
  static bool isFastDoubleClick() {
    var lastClickTime = 0;
    var _time = 800;
    var time = DateTime.now().millisecondsSinceEpoch;
    if (time - lastClickTime < _time) {
      return true;
    }
    lastClickTime = time;
    return false;
  }
}

void launchURL(String? url) async {
  if (url != null) {
    await launchUrlString(mode: LaunchMode.externalApplication,
      url,
    );
  }
}

void showToast(String? message) {
  Fluttertoast.showToast(
    msg: message != null && message.isNotEmpty ? message : "error",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 5,
  );
}
