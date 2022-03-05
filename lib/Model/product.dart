import 'category.dart';

class Product {
  int? id;
  String? productName;
  int? stock;
  int? price;
  String? imagePath;
  int? categoryId;
  Category? category;

  Product({this.id, this.productName, this.stock, this.price, this.imagePath, this.categoryId, this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    stock = json['stock'];
    price = json['price'];
    imagePath = json['imagePath'];
    categoryId = json['categoryId'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productName'] = productName;
    data['stock'] = stock;
    data['price'] = price;
    data['imagePath'] = imagePath;
    data['categoryId'] = categoryId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

