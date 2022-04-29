import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quanly/View/customer/customer_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Model/customer.dart';
import '../../Widgets/search_widget.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              title: SearchWidget(txtTimKiem: txtTimKiem, onChanged: (value) {}, hintText: "Tìm kiếm khách hàng"),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                  height: 75,
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
                                                prefixIcon: Icon(Icons.person_add),
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
                                                prefixIcon: Icon(Icons.phone),
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
                        Get.put(CustomerController()).insertCustomer(Customer(customerName: result![0], customerMobile: result[1]));
                      },
                      child: const Text(
                        "Thêm mới khách hàng",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          //side: const BorderSide(color: Colors.pink)
                        )),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.yellow),
                        backgroundColor: MaterialStateProperty.all(Colors.pink.shade300),
                      ))),
              FutureBuilder<List<Customer>>(
                  future: Get.put(CustomerController()).getData(txtTimKiem.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    if (snapshot.hasData) {
                      return (snapshot.data!.isEmpty)
                          ? SvgPicture.asset(
                              "assets/svgIcons/search_2.svg",
                              width: 200,
                              height: 200,
                            )
                          : ListView.separated(
                              shrinkWrap: true, //tranh' loi~ view SingleChildScrollView-column
                              //ngan chan ListView no' cuon xuong' duoc, xai` cho SingleChildScrollView-column
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              separatorBuilder: (context, index) => const Divider(height: 5),
                              itemBuilder: (context, index) => ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () => Get.back<Customer>(result: snapshot.data![index]),
                                  child: SizedBox(
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${snapshot.data![index].customerName}",
                                            style: const TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            "${snapshot.data![index].customerMobile}",
                                            style: const TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ))),
                            );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ])),
          ],
        ),
      ),
    ));
  }
}
