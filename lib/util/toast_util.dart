
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// Toast工具类
class ToastUtil {
  static void show(String? msg) {
    if (msg == null) {
      return;
    }

    SmartDialog.showToast(
      msg,
      displayTime: const Duration(seconds: 2),
    );
  }


  static void cancelToast() {
    SmartDialog.dismiss(status: SmartStatus.toast);
  }

  static void showLoading(String? msg) {
    if (msg == null) {
      return;
    }
    SmartDialog.showLoading(
        msg: msg
    );
  }

  static void cancelLoading() {
    SmartDialog.dismiss(status: SmartStatus.loading);
  }


}
