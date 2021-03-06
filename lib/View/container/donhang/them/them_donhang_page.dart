import 'package:flutter/material.dart';
import 'package:flutter_quanly/Model/customer.dart';
import 'package:flutter_quanly/View/cart/cart_controller.dart';
import 'package:flutter_quanly/Widgets/build_widgets.dart';
import 'package:flutter_quanly/pages.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ThemDonHangPage extends StatefulWidget {
  const ThemDonHangPage({Key? key}) : super(key: key);
  @override
  State<ThemDonHangPage> createState() => _ThemDonHangPageState();
}

class _ThemDonHangPageState extends State<ThemDonHangPage> {
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      //huy keyboard khi bam ngoai man hinh
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        //Hide
        //drawer: const NavigationDrawer(),
        body: Obx(() => CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: const Text("Thêm đơn hàng"),
                  bottom: AppBar(
                    title: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.white54,
                      ),
                      width: double.infinity,
                      height: 40,
                      child: Center(
                        child: TextField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            hintText: 'Tìm kiếm sản phẩm',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onTap: () => cartController.chuyenDenTrangProduct(context),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  (cartController.lstCartProduct.isEmpty)
                      ? GestureDetector(
                          onTap: () => cartController.chuyenDenTrangProduct(context),
                          child: SizedBox(
                            width: Get.width,
                            child: Column(
                              children: [
                                Opacity(
                                  opacity: 0.5,
                                  child: SvgPicture.asset(
                                    "assets/svgIcons/humanCart.svg",
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  //constraints: BoxConstraints(maxWidth: Get.width),
                                  child: const Text(
                                    "Đơn hàng của bạn chưa có sản phẩm nào, nhấn để thêm sản phẩm !",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true, //tranh' loi~ view SingleChildScrollView-column
                          //ngan chan ListView no' cuon xuong' duoc, xai` cho SingleChildScrollView-column
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartController.lstCartProduct.length,
                          separatorBuilder: (context, index) => const Divider(height: 5),
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
                                              style: const TextStyle(color: Colors.black), text: cartController.lstCartProduct[index].productName)),
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
                                          SizedBox(
                                            width: Get.width / 3,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      cartController.giamSoLuong(index);
                                                    },
                                                    icon: const Icon(Icons.remove, color: Colors.red)),
                                                Text("${cartController.lstCartProduct[index].stock}"),
                                                IconButton(
                                                    onPressed: () {
                                                      cartController.tangSoLuong(index);
                                                    },
                                                    icon: const Icon(Icons.add, color: Colors.green)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                  Container(
                    color: Colors.white,
                    width: Get.width,
                    child: ListTile(
                      title: const Text("Tổng số lượng"),
                      trailing: Text(cartController.tongSoLuong.value.toString()),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: Get.width,
                    child: ListTile(
                      title: const Text("Tổng tiền"),
                      trailing: Text(formatNumber.format(cartController.tongTien.value) + " VNĐ"),
                    ),
                  ),
                  const Divider(),
                  Container(
                    color: Colors.white,
                    width: Get.width,
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                          cartController.customer.value.customerName!.isEmpty
                              ? "Thêm khách hàng"
                              : cartController.customer.value.customerName! + " - " + cartController.customer.value.customerMobile!,
                          style: const TextStyle(color: Colors.blue)),
                      onTap: () async {
                        final result = await Get.toNamed<Customer>(Routes.CUSTOMER);
                        if (result == null) return;
                        cartController.customer.value = result;
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    width: Get.width,
                    child: ListTile(
                      leading: const Icon(Icons.money),
                      title: const Text("Giá bán lẻ"),
                      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_right, size: 30)),
                    ),
                  ),
                  const Divider(),
                  Container(
                    color: Colors.white,
                    width: Get.width,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text("Ghi chú", style: TextStyle(color: Colors.blue)),
                        onTap: () async {
                          final txtTenController = TextEditingController();
                          final result = await showDialog<String>(
                              //barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Thêm khách hàng"),
                                    content: TextFormField(
                                      autofocus: true,
                                      controller: txtTenController, //gan gia tri cua text vao bien'
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.edit),
                                        border: UnderlineInputBorder(),
                                        labelText: "Thêm ghi chú",
                                      ),
                                    ),
                                    actions: [
                                      SizedBox(
                                        width: Get.width,
                                        child: ElevatedButton(
                                          onPressed: () => Navigator.of(context).pop(txtTenController.text),
                                          child: const Text("Thêm"),
                                        ),
                                      )
                                    ],
                                  ));
                          cartController.ghiChu = result!;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: RichText(text: TextSpan(style: const TextStyle(color: Colors.black), text: cartController.ghiChu)),
                      ),
                    ]),
                  ),
                  //gan' cai' height nay` trung` voi' height bottom sheet de no' ko bi mat' widget
                  const SizedBox(height: 110)
                ])),
              ],
            )),
        bottomSheet: BottomSheet(
            onClosing: () {},
            builder: (context) => Container(
                  color: Colors.green[100],
                  width: Get.width,
                  height: 110,
                  child: Column(children: [
                    Obx(() => ListTile(
                          title: const Text("Tạm tính"),
                          trailing: Text(formatNumber.format(cartController.tongTien.value) + " VNĐ"),
                        )),
                    ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.DONHANG + Routes.CHITIETDONHANG),
                        child: SizedBox(
                            width: Get.width * 0.85,
                            child: const Text(
                              "Lập hóa đơn",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            )),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            //side: const BorderSide(color: Colors.pink)
                          )),
                          backgroundColor: MaterialStateProperty.all(Colors.amber),
                        ))
                  ]),
                )),
      ),
    ));
  }
}
