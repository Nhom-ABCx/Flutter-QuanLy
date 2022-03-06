import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quanly/all_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ThemDonHangPage extends StatefulWidget {
  const ThemDonHangPage({Key? key}) : super(key: key);
  @override
  State<ThemDonHangPage> createState() => _ThemDonHangPageState();
}

class _ThemDonHangPageState extends State<ThemDonHangPage> {
  List<Product> lstProduct = [];
  int tongSoLuong = 0;
  int tongTien = 0;

  @override
  Widget build(BuildContext context) {
    Future<void> _chuyenDenTrangTimKiem() async {
      FocusScope.of(context).unfocus(); //unforcus lai de mat cai ban` phim'
      //tao 1 bien nhan gia tri tu trang tiep theo gui ve`
      final value = await Navigator.push(
        context,
        MaterialPageRoute<Product>(
          builder: (context) => const SanPhamPage(),
        ),
      );
      if (value == null) return;
      bool daCo = false;
      lstProduct.forEach((element) {
        if (value.id == element.id) {
          setState(() {
            element.stock = element.stock! + 1;
            tongSoLuong += 1;
            tongTien += element.price!;
          });
          daCo = true;
          return;
        }
      });
      if (!daCo) {
        value.stock = 1;
        setState(() {
          lstProduct.add(value);
          tongSoLuong += value.stock!;
          tongTien += value.price!;
        });
      }
      print("dsProduct ${lstProduct.length}");
    }

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
                  child: Center(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Tìm kiếm sản phẩm',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onTap: () => _chuyenDenTrangTimKiem(),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              (lstProduct.isEmpty)
                  ? GestureDetector(
                      onTap: () => _chuyenDenTrangTimKiem(),
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
                    )
                  : ListView.separated(
                      shrinkWrap: true, //tranh' loi~ view SingleChildScrollView-column
                      //ngan chan ListView no' cuon xuong' duoc, xai` cho SingleChildScrollView-column
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lstProduct.length,
                      separatorBuilder: (context, index) => const Divider(height: 5),
                      itemBuilder: (context, index) => Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: 130,
                              child: Image.asset("assets/images/${lstProduct[index].imagePath}"),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  RichText(text: TextSpan(style: const TextStyle(color: Colors.black), text: lstProduct[index].productName)),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "mô tả gì gì đó đó",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(formatNumber.format(lstProduct[index].price) + " VNĐ",
                                          style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const Spacer(),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 3,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  if (lstProduct[index].stock! == 1) {
                                                    setState(() {
                                                      tongSoLuong -= 1;
                                                      tongTien -= lstProduct[index].price!;
                                                      lstProduct.removeAt(index);
                                                    });
                                                  } else {
                                                    setState(() {
                                                      lstProduct[index].stock = lstProduct[index].stock! - 1;
                                                      tongSoLuong -= 1;
                                                      tongTien -= lstProduct[index].price!;
                                                    });
                                                  }
                                                },
                                                icon: const Icon(Icons.remove, color: Colors.red)),
                                            Text("${lstProduct[index].stock}"),
                                            IconButton(
                                                onPressed: () => setState(() {
                                                      lstProduct[index].stock = lstProduct[index].stock! + 1;
                                                      tongSoLuong += 1;
                                                      tongTien += lstProduct[index].price!;
                                                    }),
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
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  title: const Text("Tổng số lượng"),
                  trailing: Text("$tongSoLuong"),
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  title: const Text("Tổng tiền"),
                  trailing: Text(formatNumber.format(tongTien) + " VNĐ"),
                ),
              ),
              const Divider(),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Thêm khách hàng", style: TextStyle(color: Colors.blue)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Product>(
                        builder: (context) => const KhachHangPage(),
                      ),
                    );
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
