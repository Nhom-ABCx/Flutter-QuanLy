import 'donhang_controller.dart';
import 'package:get/get.dart';

class DonHangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DonHangController());
  }
}