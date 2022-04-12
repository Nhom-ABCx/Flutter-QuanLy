import 'dart:async';
import 'package:get/get.dart';
import '../../API/db.dart';
import '../../Model/customer.dart';

class CustomerController extends GetxController {
  List<Customer> customer = [];
  Future<void> insertCustomer(Customer account) async {
    var dbClient = await DB().database;
    final result = await dbClient.insert('Customer', account.toJson());
    // print("Insert thành công");
  }

  Future<List<Customer>> getData(String txtTimKiem) async {
    final dbclient = await DB().database;
    final result = await dbclient.query("Customer");
    customer = result.map((json) => Customer.fromJson(json)).where((element) {
      final nameLower = element.customerName!.toLowerCase(); //chuyen cai ten thanh chu thuong` het
      final queryLower = txtTimKiem.toLowerCase();
      return nameLower.contains(queryLower); //tra ve ton` tai
    }).toList();
    return customer;
  }
}
