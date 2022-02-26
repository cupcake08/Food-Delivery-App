class CartModel {
  int? _id;
  String? _name;
  int? _price;
  String? _img;
  int? _quantity;
  bool? _isExist;
  String? _time;

  CartModel({
    int? id,
    String? name,
    int? price,
    String? img,
    int? quantity,
    bool isExist = false,
    String? time,
  }) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (price != null) {
      _price = price;
    }

    if (img != null) {
      _img = img;
    }
    _quantity = quantity;
    _isExist = isExist;
    _time = time;
  }

  String get img => _img!;
  String get name => _name!;
  int get price => _price!;
  int get id => _id!;
  int get quantity => _quantity!;
  String get time => _time!;
  bool get isExist => _isExist!;

  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _img = json['img'];
    _quantity = json['quantity'];
    _time = json['time'];
    _isExist = json['isExist'];
  }
}