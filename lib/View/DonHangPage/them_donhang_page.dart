import 'package:flutter/material.dart';
import 'package:flutter_quanly/all_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemDonHangPage extends StatefulWidget {
  const ThemDonHangPage({Key? key}) : super(key: key);
  @override
  State<ThemDonHangPage> createState() => _ThemDonHangPageState();
}

class _ThemDonHangPageState extends State<ThemDonHangPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      //huy keyboard khi bam ngoai man hinh
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //Hide
        //drawer: const NavigationDrawer(),
        body: CustomScrollView(
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
                  child: const Center(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm sản phẩm',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const TimKiemPage(),
                  ),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                        //constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                        child: const Text(
                          "Đơn hàng của bạn chưa có sản phẩm nào, nhấn để thêm sản phẩm !",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const ListTile(
                  title: Text("Tổng số lượng"),
                  trailing: Text("0"),
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: const ListTile(
                  title: Text("Tổng tiền"),
                  trailing: Text("0"),
                ),
              ),
              const Divider(),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(
                    "Thêm khách hàng",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    print("object");
                  },
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  leading: const Icon(Icons.money),
                  title: const Text("Giá bán lẻ"),
                  trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_right, size: 30)),
                ),
              ),
              const SizedBox(
                height: 110,
              )
            ])),
          ],
        ),
        bottomSheet: BottomSheet(
            onClosing: () {},
            builder: (context) => Container(
                  color: Colors.green[100],
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  child: Column(children: [
                    const ListTile(
                      title: Text("Tạm tính"),
                      trailing: Text("0"),
                    ),
                    ElevatedButton(
                        onPressed: () async {},
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width - 50,
                            child: const Text(
                              "Tạo đơn hàng",
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
