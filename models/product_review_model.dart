import 'dart:convert';

class ProductReviewModel {
  final String id;
  final String buyerId;
  final String email;
  final String fullName;
  final String productId;
  final double rating;
  final String review;

  ProductReviewModel({required this.id, required this.buyerId, required this.email, required this.fullName, required this.productId, required this.rating, required this.review});

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id':id,
      'buyerId':buyerId,
      'email':email,
      'fullName':fullName,
      'productId':productId,
      'rating':rating,
      'review':review,
    };
  }

  factory ProductReviewModel.fromMap(Map<String, dynamic> map){
    return ProductReviewModel(
      id: map['_id'] as String, 
      buyerId: map['buyerId'] as String, 
      email: map['email'] as String, 
      fullName: map['fullName'] as String, 
      productId: map['productId'] as String, 
      rating: map['rating'] as double,
      review: map['review'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductReviewModel.fromJson(String source) => ProductReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}