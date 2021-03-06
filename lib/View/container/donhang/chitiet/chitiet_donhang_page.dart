import 'package:flutter/material.dart';
import 'package:flutter_quanly/View/cart/cart_controller.dart';
import 'package:flutter_quanly/Widgets/build_widgets.dart';
import 'package:flutter_quanly/Widgets/process_timeline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../donhang_controller.dart';

class ChiTietDonHangPage extends StatefulWidget {
  const ChiTietDonHangPage({Key? key}) : super(key: key);
  @override
  State<ChiTietDonHangPage> createState() => _ChiTietDonHangPageState();
}

class _ChiTietDonHangPageState extends State<ChiTietDonHangPage> {
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            //Hide
            //drawer: const NavigationDrawer(),
            body: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  centerTitle: true,
                  title: Text("Mã đơn hàng 01XBYS"),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  const ProcessTimelinePage(),
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: SvgPicture.asset(
                            "assets/svgIcons/banner.svg",
                            width: Get.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(
                                      formatNumber.format(cartController.tongTien.value) + " VNĐ",
                                      style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                                    )),
                                const Text(
                                  "Bán bởi abc",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const Text(
                                  "Chi nhánh đông dương",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const Text(
                                  "Nguồn: App",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.circle, size: 10, color: Colors.red),
                                    SizedBox(width: 10),
                                    Text(
                                      "Chưa thanh toán",
                                      style: TextStyle(fontSize: 15, color: Colors.red),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(minHeight: 70),
                    color: Colors.white,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 70,
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() => ListTile(
                                title: Row(
                                  children: [
                                    Text("${cartController.customer.value.customerName} - "),
                                    Text(
                                      "${cartController.customer.value.customerMobile}",
                                      style: const TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                                subtitle: const Text("C3/31 Trịnh như khuê, Bình chánh, TP.HCM"),
                              )),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 5),
                  Obx(() => ListView.builder(
                        shrinkWrap: true, //tranh' loi~ view SingleChildScrollView-column
                        //ngan chan ListView no' cuon xuong' duoc, xai` cho SingleChildScrollView-column
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartController.lstCartProduct.length,
                        itemBuilder: (context, index) => Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          constraints: BoxConstraints(maxWidth: Get.width),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                width: 130,
                                child: Image.asset("assets/images/${cartController.lstCartProduct[index].imagePath}"),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: const TextStyle(color: Colors.black),
                                            text: "${cartController.lstCartProduct[index].productName}")),
                                    const SizedBox(height: 20),
                                    const Text(
                                      "mô tả gì gì đó đó",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Text(formatNumber.format(cartController.lstCartProduct[index].price) + " VNĐ",
                                            style: const TextStyle(fontWeight: FontWeight.bold)),
                                        const Spacer(),
                                        Text("Số lượng: ${cartController.lstCartProduct[index].stock}",
                                            style: const TextStyle(fontWeight: FontWeight.bold))
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(height: 50)
                ])),
              ],
            ),
            bottomSheet: BottomSheet(
                onClosing: () {},
                builder: (context) => Container(
                      color: Colors.green[100],
                      width: Get.width,
                      height: 50,
                      child: Center(
                          child: ElevatedButton(
                              onPressed: () {
                                Get.put(DonHangController()).chuyenTiepTrangThai();
                              },
                              child: SizedBox(
                                  width: Get.width * 0.85,
                                  child: const Text(
                                    "Chuyển tiếp trạng thái",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                  )),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  //side: const BorderSide(color: Colors.pink)
                                )),
                                backgroundColor: MaterialStateProperty.all(Colors.pink.shade200),
                              ))),
                    ))));
  }
}
