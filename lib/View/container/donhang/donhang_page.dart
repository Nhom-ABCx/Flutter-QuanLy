import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../pages.dart';

class DonHangPage extends StatefulWidget {
  const DonHangPage({Key? key}) : super(key: key);
  @override
  State<DonHangPage> createState() => _DonHangPageState();
}

class _DonHangPageState extends State<DonHangPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          centerTitle: true,
          title: Text("Đơn hàng"),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            margin: const EdgeInsets.all(10),
            width: Get.width,
            height: 100,
            child: TextButton(
                onPressed: () => Get.toNamed(Routes.DONHANG + Routes.THEMDONHANG),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.add),
                    Text(
                      "Tạo hóa đơn",
                    )
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: const BorderSide(color: Colors.grey))),
                )),
          ),
          Container(
            color: Colors.white,
            width: Get.width,
            child: ListTile(
              leading: const Icon(Icons.business),
              title: const Text("Danh sách đơn hàng"),
              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.double_arrow_outlined)),
            ),
          ),
          Container(
            color: Colors.white,
            width: Get.width,
            child: ListTile(
              leading: const Icon(Icons.undo),
              title: const Text("Khách trả hàng"),
              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.double_arrow_outlined)),
            ),
          ),
        ])),
      ],
    );
  }
}
