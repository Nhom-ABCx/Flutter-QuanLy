import 'package:get/get.dart';

class DonHangController extends GetxController {
  int processIndex = 1;
  void chuyenTiepTrangThai() {
    processIndex = (processIndex + 1) % 5;
    //
    update();
  }
}
