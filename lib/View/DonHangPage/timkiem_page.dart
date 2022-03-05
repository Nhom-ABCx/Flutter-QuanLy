import 'package:flutter/material.dart';
import 'package:flutter_quanly/all_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        body: CustomScrollView(
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
              ListView.separated(
                shrinkWrap: true, //tranh' loi~ view SingleChildScrollView-column
                //ngan chan ListView no' cuon xuong' duoc, xai` cho SingleChildScrollView-column
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
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
                        child: const CircularProgressIndicator(),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RichText(
                                text: const TextSpan(
                                    style: TextStyle(color: Colors.black), text: "tenSanaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaPham")),
                            const SizedBox(height: 20),
                            const Text(
                              "widget.moTa",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: const [
                                Text("99999" + " VNĐ", style: TextStyle(fontWeight: FontWeight.bold)),
                                Spacer(),
                                Text("Quantily: 10", style: TextStyle(fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ])),
          ],
        ),
      ),
    ));
  }
}
