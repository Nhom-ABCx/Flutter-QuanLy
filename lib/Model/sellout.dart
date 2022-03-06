import 'sellout_detail.dart';
import 'shop.dart';

class SellOut {
  int? id;
  String? customerName;
  String? customerMobile;
  int? shopId;
  Shop? shop;
  int? billSeri;
  String? sellDate;
  int? amount;
  int? createDate;
  List<SellOutDetail>? sellOutDetail;

  SellOut(
      {this.id,
      this.customerName,
      this.customerMobile,
      this.shopId,
      this.shop,
      this.billSeri,
      this.sellDate,
      this.amount,
      this.createDate,
      this.sellOutDetail});

  SellOut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customerName'];
    customerMobile = json['customerMobile'];
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
    data['customerName'] = customerName;
    data['customerMobile'] = customerMobile;
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
