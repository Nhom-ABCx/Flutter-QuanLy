import 'package:flutter/material.dart';
import 'package:flutter_quanly/all_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SanPhamPage extends StatefulWidget {
  const SanPhamPage({Key? key}) : super(key: key);
  @override
  State<SanPhamPage> createState() => _SanPhamPageState();
}

class _SanPhamPageState extends State<SanPhamPage> {
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
                title: SearchWidget(txtTimKiem: txtTimKiem, onChanged: (value) {}, hintText: "Tìm kiếm sản phẩm"),
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
                    future: productController.getData(txtTimKiem.text, _selectedItem),
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
                                itemBuilder: (context, index) => GestureDetector(
                                    onTap: () => Navigator.of(context).pop(snapshot.data![index]),
                                    child: Container(
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
                                                    text: TextSpan(
                                                        style: const TextStyle(color: Colors.black), text: snapshot.data![index].productName)),
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
                                    )),
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
      ),
    ));
  }
}
