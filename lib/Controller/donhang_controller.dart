import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../all_page.dart';

class DonHangController extends ChangeNotifier {
  int processIndex = 1;
  void chuyenTiepTrangThai() {
    processIndex = (processIndex + 1) % 5;
    notifyListeners();
  }
}
