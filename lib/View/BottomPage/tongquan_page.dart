import 'package:flutter/material.dart';
import 'package:flutter_quanly/all_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TongQuanPage extends StatefulWidget {
  const TongQuanPage({Key? key}) : super(key: key);
  @override
  State<TongQuanPage> createState() => _TongQuanPageState();
}

class _TongQuanPageState extends State<TongQuanPage> {
  DateTimeRange dateTimeRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 7)),
    end: DateTime.now(),
  );
  //du lieu ao? chua xu ly'
  List<_SalesData> data = [
    _SalesData((DateTime.now().year - 4).toString(), 40),
    _SalesData((DateTime.now().year - 3).toString(), 32),
    _SalesData((DateTime.now().year - 2).toString(), 34),
    _SalesData((DateTime.now().year - 1).toString(), 28),
    _SalesData(DateTime.now().year.toString(), 35),
  ];
  int tongSoDonHang = 0;
  int tongDoanhThu = 0;
  int tongKhachHang = 0;
  void init() {
    Provider.of<HomeController>(context, listen: false).getData().then((value) {
      List<int> listKhachHang = [];
      value.forEach((element) {
        tongDoanhThu += element.amount!;
        listKhachHang.add(element.customerId!); //den' xem so' khach' hang`
      });
      setState(() {
        tongSoDonHang = value.length;
        tongDoanhThu = tongDoanhThu; //gan' lai de no setState lai thoi
        tongKhachHang = listKhachHang.toSet().length; //neu' trung` nhau thi` loai bo?, xong tra ve` do dai`
      });
      return value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          centerTitle: true,
          title: Text("Tổng quan"),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverList(
              delegate: SliverChildListDelegate([
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: customContainerDeco(),
              child: ListTile(
                title: const Text("Thời gian"),
                subtitle: Text("${DateFormat('dd/MM/yyyy').format(dateTimeRange.start)} - ${DateFormat('dd/MM/yyyy').format(dateTimeRange.end)}"),
                trailing: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.date_range, color: Colors.blue),
                  onPressed: () async {
                    final result = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                      initialDateRange: dateTimeRange,
                    );
                    setState(() => dateTimeRange = result!);
                  },
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              children: [
                itemMenuWidget(
                    context: context,
                    child: ListTile(
                      title: const Text("Doanh thu"),
                      subtitle: Text(
                        formatNumber.format(tongDoanhThu) + " VNĐ",
                        style: const TextStyle(color: Colors.green),
                      ),
                      trailing: const Icon(Icons.money),
                    )),
                itemMenuWidget(
                    context: context,
                    child: ListTile(
                      title: const Text("Số đơn hàng"),
                      subtitle: Text(
                        "$tongSoDonHang",
                        style: const TextStyle(color: Colors.green),
                      ),
                      trailing: const Icon(Icons.shopping_cart),
                    )),
                itemMenuWidget(
                    context: context,
                    child: const ListTile(
                      title: Text("Đã hủy"),
                      subtitle: Text(
                        "0",
                        style: const TextStyle(color: Colors.green),
                      ),
                      trailing: Icon(Icons.dangerous_rounded),
                    )),
                itemMenuWidget(
                    context: context,
                    child: ListTile(
                      title: const Text("Khách hàng"),
                      subtitle: Text(
                        "$tongKhachHang",
                        style: const TextStyle(color: Colors.green),
                      ),
                      trailing: const Icon(Icons.people),
                    )),
              ],
            ),
            //phan` nay` la` tham khao tu` giao dien, build theo de danh` phat trien? do` an'
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              decoration: customContainerDeco(),
              child: Column(
                children: const [
                  Text("Thông tin kho"),
                  ListTile(
                    title: Text("Sản phẩm dưới định mức"),
                    trailing: Text("0"),
                  ),
                  ListTile(
                    title: Text("Số tồn kho"),
                    trailing: Text("0"),
                  ),
                  ListTile(
                    title: Text("Giá trị tồn kho"),
                    trailing: Text("0"),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              decoration: customContainerDeco(),
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Doanh thu'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales',
                        // Enable data label
                        dataLabelSettings: const DataLabelSettings(isVisible: true))
                  ]),
            ),
          ])),
        ),
        //giuu lai de xem
        // SliverToBoxAdapter(
        //   child: Container(
        //     height: 100.0,
        //     child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: 10,
        //       itemBuilder: (context, index) {
        //         return Container(
        //           width: 150.0,
        //           child: Card(
        //             color: Colors.green[100],
        //             shadowColor: Colors.blueGrey, //mau` do bong'
        //             elevation: 10, //do noi?
        //             child: Text('data'),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
