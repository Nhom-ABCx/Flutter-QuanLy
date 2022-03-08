import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_quanly/all_page.dart';
import 'package:flutter_svg/svg.dart';

class ChiTietDonHangPage extends StatefulWidget {
  const ChiTietDonHangPage({Key? key}) : super(key: key);
  @override
  State<ChiTietDonHangPage> createState() => _ChiTietDonHangPageState();
}

class _ChiTietDonHangPageState extends State<ChiTietDonHangPage> {
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
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "350.000đ",
                                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                              ),
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
                        child: ListTile(
                          title: Row(
                            children: const [
                              Text("Username - "),
                              Text(
                                "01923879",
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                          subtitle: const Text("C3/31 Trịnh như khuê, Bình chánh, TP.HCM"),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true, //tranh' loi~ view SingleChildScrollView-column
                  //ngan chan ListView no' cuon xuong' duoc, xai` cho SingleChildScrollView-column
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
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
                          child: Image.asset("assets/images/1.jpg"),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(text: TextSpan(style: const TextStyle(color: Colors.black), text: "snapshot.data![index].productName")),
                              const SizedBox(height: 20),
                              const Text(
                                "mô tả gì gì đó đó",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(formatNumber.format(10000) + " VNĐ", style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  Text("Số lượng: 99", style: const TextStyle(fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50)
              ])),
            ],
          ),
          bottomSheet: BottomSheet(
              onClosing: () {},
              builder: (context) => Container(
                    color: Colors.green[100],
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => const ChiTietDonHangPage(),
                                ),
                              );
                            },
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.85,
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
                  ))),
    ));
  }
}
