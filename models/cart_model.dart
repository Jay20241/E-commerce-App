import 'dart:convert';

class CartModel {
  final String productName;
  final int productPrice;
  final String category;
  final List<String> image;
  final String vendorId;
  final int productQuantity;
   int quantity; //not final, because we need to increment and decrement in CartProvider.
  final String productId;
  final String description;
  final String fullname;

  CartModel({required this.productName, required this.productPrice, required this.category, required this.image, required this.vendorId, required this.productQuantity, required this.quantity, required this.productId, required this.description, required this.fullname});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName':productName,
      'productPrice':productPrice,
      'category':category,
      'image':image,
      'vendorId':vendorId,
      'productQuantity':productQuantity,
      'quantity':quantity,
      'productId':productId,
      'description':description,
      'fullname':fullname
    };
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      category: map['category'] as String,
      //image: map['image'] as List<String>, //Not like this.
      image: List<String>.from((map['image'] as List<dynamic>? ?? [])),
      vendorId: map['vendorId'] as String,
      productQuantity: map['productQuantity'] as int,
      quantity: map['quantity'] as int,
      productId: map['productId'] as String,
      description: map['description'] as String,
      fullname: map['fullname'] as String,
    );
  }

  //This line will not convert the data correctly
  factory CartModel.fromJson(String source) => CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}