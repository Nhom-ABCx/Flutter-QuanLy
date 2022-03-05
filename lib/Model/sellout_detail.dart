import 'product.dart';

class SellOutDetail {
  int? id;
  int? sellOutId;
  int? productId;
  String? serinumer;
  int? quantity;
  int? amount;
  Product? product;

  SellOutDetail({this.id, this.sellOutId, this.productId, this.serinumer, this.quantity, this.amount, this.product});

  SellOutDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellOutId = json['sellOutId'];
    productId = json['productId'];
    serinumer = json['serinumer'];
    quantity = json['quantity'];
    amount = json['amount'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sellOutId'] = sellOutId;
    data['productId'] = productId;
    data['serinumer'] = serinumer;
    data['quantity'] = quantity;
    data['amount'] = amount;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
