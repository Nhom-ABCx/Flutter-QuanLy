import 'package:sqflite/sqflite.dart';
import 'dart:convert';

class DB {
  final String sanPham1 = '''
{
    "id": 1,
    "productName": "TV 32in GHKFKFFF",
    "stock": 22,
    "price": 10000000,
    "imagePath": "1.jpg",
    "categoryId": 1,
    "category": {
        "id": 1,
        "categoryName": "Tivi"
    }
}
''';
  final String sanPham2 = '''
{
    "id": 2,
    "productName": "TV 42in GHKFKFFF",
    "stock": 13,
    "price": 3000000,
    "imagePath": "2.jpg",
    "categoryId": 1,
    "category": {
        "id": 1,
        "categoryName": "Tivi"
    }
}
''';
  final String sanPham3 = '''
{
    "id": 3,
    "productName": "Tủ lạnh Samsung 250 lít",
    "stock": 32,
    "price": 2000000,
    "imagePath": "3.jpg",
    "categoryId": 2,
    "category": {
        "id": 2,
        "categoryName": "Tủ lạnh"
    }
}
''';
  final String sanPham4 = '''
{
    "id": 4,
    "productName": "Tủ lạnh Samsung 350 lít",
    "stock": 3,
    "price": 2000000,
    "imagePath": "4.jpg",
    "categoryId": 2,
    "category": {
        "id": 2,
        "categoryName": "Tủ lạnh"
    }
}
''';
  final String donHang1 = '''
{
    "id": 1,
    "customerId": 1,
    "customer": {
        "id": 1,
        "customerName": "Thắng",
        "customerMobile": "0908185626"
    },
    "shopId": 1,
    "shop": {
        "id": 1,
        "shopName": "Nguyễn Kim Quận 1"
    },
    "billSeri": 3232,
    "sellDate": "20210506",
    "amount": 10000000,
    "createDate": 20210506123012,
    "sellOutDetail":[
        {
            "id":1,
            "sellOutId":1,
            "productId":1,
            "serinumer":"4343434",
            "quantity":1,
            "amount":10000000,
            "product":{
                "id": 1,
                "productName": "TV 32in GHKFKFFF",
                "stock": 22,
                "price": 10000000,
                "imagePath": "1.jpg",
                "categoryId": 1,
                "category": {
                    "id": 1,
                    "categoryName": "Tivi"
                }
            }
        }
    ]
}
''';
  final String donHang2 = '''
{
    "id": 2,
    "customerId": 2,
    "customer": {
        "id": 2,
        "customerName": "Quốc",
        "customerMobile": "0905591500"
    },
    "shopId": 2,
    "shop": {
        "id": 2,
        "shopName": "Nguyễn Kim Trần Hưng đạo"
    },
    "billSeri": 4343,
    "sellDate": "20210506",
    "amount": 7000000,
    "createDate": 20210506123012,
    "sellOutDetail": [
        {
            "id": 2,
            "sellOutId": 2,
            "productId": 3,
            "serinumer": "4343y4nj",
            "quantity": 1,
            "amount": 3000000,
            "product": {
                "id": 3,
                "productName": "Tủ lạnh Samsung 250 lít",
                "stock": 32,
                "price": 2000000,
                "imagePath": "3.jpg",
                "categoryId": 2,
                "category": {
                    "id": 2,
                    "categoryName": "Tủ lạnh"
                }
            }
        },
        {
            "id": 3,
            "sellOutId": 2,
            "productId": 4,
            "serinumer": "544uyh5j454",
            "quantity": 1,
            "amount": 4000000,
            "product":{
                "id": 4,
                "productName": "Tủ lạnh Samsung 350 lít",
                "stock": 3,
                "price": 2000000,
                "imagePath": "4.jpg",
                "categoryId": 2,
                "category": {
                    "id": 2,
                    "categoryName": "Tủ lạnh"
                }
            }
        }
    ]
}
''';
  late final String allSanPham;
  late final String allDonHang;
  //phuong thuc khoi tao
  DB() {
    allSanPham = "[$sanPham1,$sanPham2,$sanPham3,$sanPham4]";
    allDonHang = "[$donHang1,$donHang2]";
  }

//local DB
  static final DB instance = DB._init();

  static Database? _db;
  DB._init();

  Future<Database> get database async {
    if (_db != null) {
      // getAccount();
      return _db!;
    }

    return _db = await initDatabase();
  }

  initDatabase() async {
    // io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentDirectory.path, 'cart.db');
    String path = "DB/local.db";
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    // await deleteDatabase(path);

    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    // await db.execute("DROP TABLE IF EXISTS cart");

    await db.execute(''' CREATE TABLE Customer(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      customerName TEXT, 
      customerMobile TEXT
      )
        ''');
    db.insert("Customer", {"id": 1, "customerName": "Thắng", "customerMobile": "0908185626"});
    db.insert("Customer", {"id": 2, "customerName": "Quốc", "customerMobile": "0905591500"});
  }
}

class Http {
  int secondGet = 1; //gia lap 1 giay de lay du lieu
  Future<Responsee> get(String url, {Map<String, String>? headers}) {
    //day la` gia? lap neu' la dia chi nao` thi return ve json do'
    switch (url) {
      case "/getProduct":
        return Future.delayed(Duration(seconds: secondGet), () => Responsee(200, DB().allSanPham));
      case "/getSellout":
        return Future.delayed(Duration(seconds: secondGet), () => Responsee(200, DB().allDonHang));
      default:
        return Future.delayed(Duration(seconds: secondGet), () => Responsee(500, ""));
    }
  }

  Future<Responsee> post(String url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return Future.delayed(Duration(seconds: secondGet), () => Responsee(500, ""));
  }
}

class Responsee {
  late int statusCode = 200;
  late String body;
  Responsee(this.statusCode, this.body);
}
