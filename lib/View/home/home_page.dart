import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Model/sales.dart';
import 'home_controller.dart';
import 'package:get/get.dart';
import '../../Widgets/build_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScrollView(
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
                    subtitle: Text(
                        "${DateFormat('dd/MM/yyyy').format(controller.dateTimeRange.start)} - ${DateFormat('dd/MM/yyyy').format(controller.dateTimeRange.end)}"),
                    trailing: IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.date_range, color: Colors.blue),
                      onPressed: () async {
                        final result = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          initialDateRange: controller.dateTimeRange,
                        );
                        //set state
                        controller.dateTimeRange = result!;
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
                            formatNumber.format(controller.tongDoanhThu.value) + " VNĐ",
                            style: const TextStyle(color: Colors.green),
                          ),
                          trailing: const Icon(Icons.money),
                        )),
                    itemMenuWidget(
                        context: context,
                        child: ListTile(
                          title: const Text("Số đơn hàng"),
                          subtitle: Text(
                            "${controller.tongSoDonHang}",
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
                            style: TextStyle(color: Colors.green),
                          ),
                          trailing: Icon(Icons.dangerous_rounded),
                        )),
                    itemMenuWidget(
                        context: context,
                        child: ListTile(
                          title: const Text("Khách hàng"),
                          subtitle: Text(
                            "${controller.tongKhachHang}",
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
                    children: [
                      const Text("Thông tin kho"),
                      const ListTile(
                        title: Text("Sản phẩm dưới định mức"),
                        trailing: Text("0"),
                      ),
                      ListTile(
                        title: const Text("Số tồn kho"),
                        trailing: Text("${controller.tongTonKho.value}"),
                      ),
                      ListTile(
                        title: const Text("Giá trị tồn kho"),
                        trailing: Text(formatNumber.format(controller.giaTriTonKho.value) + " VNĐ"),
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
                      series: <ChartSeries<SalesData, String>>[
                        LineSeries<SalesData, String>(
                            dataSource: controller.data,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales,
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
        ));
  }
}
