import 'dart:convert';

class ProductModel {

    final String id;
    final String productName;
    final int productPrice;
    final int quantity;
    final String description;
    final String category;
    final String vendorId;
    final String fullname;
    final String subCategory;
    final List<String> images;
    final double averageRating;
    final int totalRatings;

   
  ProductModel({required this.id, required this.productName, required this.productPrice, required this.quantity, required this.description, required this.category, required this.vendorId, required this.fullname, required this.subCategory, required this.images, required this.averageRating, required this.totalRatings});


   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'description': description,
      'category': category,
      'vendorId': vendorId,
      'fullname': fullname,
      'subCategory': subCategory,
      'images': images,
      'averageRating': averageRating,
      'totalRatings': totalRatings,
    };
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] as String ? ??"",
      productName: map['productName'] as String ? ??"",
      productPrice: map['productPrice'] as int? ?? 0,
      quantity: map['quantity'] as int? ?? 0,
      description: map['description'] as String ? ??"",
      category: map['category'] as String ? ??"",
      vendorId: map['vendorId'] as String ? ??"",
      fullname: map['fullname'] as String ? ??"",
      subCategory: map['subCategory'] as String ? ??"",
      images: List<String>.from((map['images'] as List<dynamic>? ?? [])),
      averageRating: (map['averageRating'] is int? (map['averageRating'] as int).toDouble() : map['averageRating'] as double),
      totalRatings: map['totalRatings'] as int 
      );
  }

  //This line will not convert the data correctly
  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  
}