import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quanly/all_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class KhachHangPage extends StatefulWidget {
  const KhachHangPage({Key? key}) : super(key: key);
  @override
  State<KhachHangPage> createState() => _KhachHangPageState();
}

class _KhachHangPageState extends State<KhachHangPage> {
  TextEditingController txtTimKiem = TextEditingController();
  final _formKey = GlobalKey<FormState>(); //tao 1 cai form de validate
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      //huy keyboard khi bam ngoai man hinh
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //Hide
        //drawer: const NavigationDrawer(),
        body: Consumer<ProductController>(
          builder: (context, productController, child) => CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                title: SearchWidget(txtTimKiem: txtTimKiem, onChanged: (value) {}, hintText: "Tìm kiếm khách hàng"),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: ElevatedButton(
                        onPressed: () async {
                          final txtTenController = TextEditingController();
                          final txtPhoneController = TextEditingController();
                          final result = await showDialog<List<String>>(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Thêm khách hàng"),
                                    content: Form(
                                        key: _formKey,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                autofocus: true,
                                                controller: txtTenController, //gan gia tri cua text vao bien'
                                                decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.search),
                                                  border: UnderlineInputBorder(),
                                                  labelText: "Tên khách hàng",
                                                  hintText: "Nguyễn Đạt",
                                                ),
                                                validator: (value) {
                                                  return value!.isEmpty ? "Không được trống" : null;
                                                },
                                              ),
                                              TextFormField(
                                                autofocus: true,
                                                controller: txtPhoneController, //gan gia tri cua text vao bien'
                                                decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.search),
                                                  border: UnderlineInputBorder(),
                                                  labelText: "Số điện thoại",
                                                  hintText: "0909999",
                                                ),
                                                inputFormatters: <TextInputFormatter>[
                                                  //only number
                                                  FilteringTextInputFormatter.digitsOnly
                                                ],
                                                keyboardType: TextInputType.phone,
                                                validator: (value) {
                                                  return value!.isEmpty ? "Không được trống" : null;
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                    actions: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            //neu' du lieu nhap dung'
                                            if (_formKey.currentState!.validate()) {
                                              Navigator.of(context).pop([txtTenController.text, txtPhoneController.text]);
                                            }
                                          },
                                          child: const Text("Thêm"),
                                        ),
                                      )
                                    ],
                                  ));
                          print(result![0]);
                        },
                        child: const Text(
                          "Thêm mới khách hàng",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            //side: const BorderSide(color: Colors.pink)
                          )),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.yellow),
                          backgroundColor: MaterialStateProperty.all(Colors.pink.shade300),
                        ))),
                const Divider(),
                // FutureBuilder<List<Product>>(
                //     future: productController.getData(txtTimKiem.text),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasError) {
                //         return Center(
                //           child: Text(snapshot.error.toString()),
                //         );
                //       }
                //       if (snapshot.hasData) {
                //         return (snapshot.data!.isEmpty)
                //             ? SvgPicture.asset(
                //                 "assets/svgIcons/search_2.svg",
                //                 width: 200,
                //                 height: 200,
                //               )
                //             : ListView.separated(
                //                 shrinkWrap: true, //tranh' loi~ view SingleChildScrollView-column
                //                 //ngan chan ListView no' cuon xuong' duoc, xai` cho SingleChildScrollView-column
                //                 physics: const NeverScrollableScrollPhysics(),
                //                 itemCount: snapshot.data!.length,
                //                 separatorBuilder: (context, index) => const Divider(height: 5),
                //                 itemBuilder: (context, index) => GestureDetector(
                //                     onTap: () => Navigator.of(context).pop(snapshot.data![index]),
                //                     child: Container(
                //                       decoration: const BoxDecoration(
                //                         color: Colors.white,
                //                         borderRadius: BorderRadius.all(Radius.circular(15.0)),
                //                       ),
                //                       constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                //                       child: Row(
                //                         children: [
                //                           Container(
                //                             padding: const EdgeInsets.all(10),
                //                             width: 130,
                //                             child: Image.asset("assets/images/${snapshot.data![index].imagePath}"),
                //                           ),
                //                           Expanded(
                //                               child: Padding(
                //                             padding: const EdgeInsets.all(10),
                //                             child: Column(
                //                               crossAxisAlignment: CrossAxisAlignment.start,
                //                               //mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                               children: [
                //                                 RichText(
                //                                     text: TextSpan(
                //                                         style: const TextStyle(color: Colors.black), text: snapshot.data![index].productName)),
                //                                 const SizedBox(height: 20),
                //                                 const Text(
                //                                   "mô tả gì gì đó đó",
                //                                   style: TextStyle(color: Colors.grey),
                //                                 ),
                //                                 const SizedBox(height: 20),
                //                                 Row(
                //                                   children: [
                //                                     Text(formatNumber.format(snapshot.data![index].price) + " VNĐ",
                //                                         style: const TextStyle(fontWeight: FontWeight.bold)),
                //                                     const Spacer(),
                //                                     Text("Số lượng tồn: ${snapshot.data![index].stock}",
                //                                         style: const TextStyle(fontWeight: FontWeight.bold))
                //                                   ],
                //                                 )
                //                               ],
                //                             ),
                //                           ))
                //                         ],
                //                       ),
                //                     )),
                //               );
                //       }
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }),
              ])),
            ],
          ),
        ),
      ),
    ));
  }
}
