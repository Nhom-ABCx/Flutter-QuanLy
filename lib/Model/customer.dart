class Customer {
  int? id;
  String? customerName;
  String? customerMobile;

  Customer({this.id, this.customerMobile, this.customerName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customerName'];
    customerMobile = json['customerMobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customerName'] = customerName;
    data['customerMobile'] = customerMobile;
    return data;
  }
}