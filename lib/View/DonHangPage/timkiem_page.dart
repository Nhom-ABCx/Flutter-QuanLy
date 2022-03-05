import 'package:flutter/material.dart';
import 'package:flutter_quanly/all_page.dart';
import 'package:provider/provider.dart';

class TimKiemPage extends StatefulWidget {
  const TimKiemPage({Key? key}) : super(key: key);
  @override
  State<TimKiemPage> createState() => _TimKiemPageState();
}

class _TimKiemPageState extends State<TimKiemPage> {
  TextEditingController txtTimKiem = TextEditingController();
  String _selectedItem = "Tất cả";
  bool _isMultiSelected = false;

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
                title: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white54,
                  ),
                  width: double.infinity,
                  height: 40,
                  child: Center(
                    child: TextField(
                      controller: txtTimKiem,
                      decoration: const InputDecoration(
                        hintText: 'Tìm kiếm sản phẩm',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                ListTile(
                  leading: DropdownButton(
                      iconSize: 30,
                      value: _selectedItem,
                      items: <String>['Tất cả', 'Tivi', 'Tủ lạnh']
                          .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() => _selectedItem = value!);
                      }),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Chọn nhiều"),
                      Switch(
                          value: _isMultiSelected,
                          onChanged: (value) {
                            setState(() => _isMultiSelected = value);
                          })
                    ],
                  ),
                ),
                FutureBuilder<List<Product>>(
                    future: productController.getData(txtTimKiem.text),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      return snapshot.hasData
                          ? ListView.separated(
                              shrinkWrap: true, //tranh' loi~ view SingleChildScrollView-column
                              //ngan chan ListView no' cuon xuong' duoc, xai` cho SingleChildScrollView-column
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
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
                                      child: Image.asset("assets/images/${snapshot.data![index].imagePath}"),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          RichText(
                                              text: TextSpan(style: const TextStyle(color: Colors.black), text: snapshot.data![index].productName)),
                                          const SizedBox(height: 20),
                                          const Text(
                                            "mô tả gì gì đó đó",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Text(formatNumber.format(snapshot.data![index].price) + " VNĐ",
                                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                                              const Spacer(),
                                              Text("Số lượng tồn: ${snapshot.data![index].stock}",
                                                  style: const TextStyle(fontWeight: FontWeight.bold))
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    }),
              ])),
            ],
          ),
        ),
      ),
    ));
  }
}
