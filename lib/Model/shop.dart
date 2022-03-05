class Shop {
  int? id;
  String? shopName;

  Shop({this.id, this.shopName});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shopName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shopName'] = shopName;
    return data;
  }
}
