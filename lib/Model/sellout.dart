import 'sellout_detail.dart';
import 'shop.dart';
import 'Customer.dart';

class SellOut {
  int? id;
  int? customerId;
  Customer? customer;
  int? shopId;
  Shop? shop;
  int? billSeri;
  String? sellDate;
  int? amount;
  int? createDate;
  List<SellOutDetail>? sellOutDetail;

  SellOut(
      {this.id,
      this.customerId,
      this.customer,
      this.shopId,
      this.shop,
      this.billSeri,
      this.sellDate,
      this.amount,
      this.createDate,
      this.sellOutDetail});

  SellOut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    shopId = json['shopId'];
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    billSeri = json['billSeri'];
    sellDate = json['sellDate'];
    amount = json['amount'];
    createDate = json['createDate'];
    if (json['sellOutDetail'] != null) {
      sellOutDetail = <SellOutDetail>[];
      json['sellOutDetail'].forEach((v) {
        sellOutDetail!.add(SellOutDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customerId'] = customerId;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['shopId'] = shopId;
    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    data['billSeri'] = billSeri;
    data['sellDate'] = sellDate;
    data['amount'] = amount;
    data['createDate'] = createDate;
    if (sellOutDetail != null) {
      data['sellOutDetail'] = sellOutDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
