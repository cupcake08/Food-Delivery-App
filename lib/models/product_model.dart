class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  List<ProductModel>? _products;

  Product({
    required totalSize,
    required typeId,
    required offset,
    required products,
  }) {
    if (totalSize != null) {
      _totalSize = totalSize;
    }
    if (typeId != null) {
      _typeId = typeId;
    }
    if (offset != null) {
      _offset = offset;
    }
    if (products != null) {
      _products = products;
    }
  }
  List<ProductModel>? get products => _products;
  set products(List<ProductModel>? products) => _products = products;

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products!.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  int? _id;
  String? _name;
  String? _description;
  int? _price;
  int? _stars;
  String? _img;
  String? _location;
  String? _createdAt;
  String? _updatedAt;
  int? _typeId;

  ProductModel({
    int? id,
    String? name,
    String? description,
    int? price,
    int? stars,
    String? img,
    String? location,
    String? createdAt,
    String? updatedAt,
    int? typeId,
  }) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (description != null) {
      _description = description;
    }
    if (price != null) {
      _price = price;
    }
    if (stars != null) {
      _stars = stars;
    }
    if (img != null) {
      _img = img;
    }
    if (location != null) {
      _location = location;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (typeId != null) {
      _typeId = typeId;
    }
  }

  String get img => _img!;
  String get name => _name!;
  String get description => _description!;
  String get location => _location!;
  String get createdAt => _createdAt!;
  String get updatedAt => _updatedAt!;
  int get price => _price!;
  int get stars => _stars!;
  int get typeId => _typeId!;
  int get id => _id!;

  ProductModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _stars = json['stars'];
    _img = json['img'];
    _location = json['location'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _typeId = json['type_id'];
  }
}
