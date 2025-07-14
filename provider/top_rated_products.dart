import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/product_model.dart';

class TopRatedProducts extends StateNotifier<List<ProductModel>>{
  TopRatedProducts() : super([]); //Initialize with an empty list.

  void setProducts(List<ProductModel> products){
    state = products;
  }
}


final topRatedProductProvider = StateNotifierProvider<TopRatedProducts, List<ProductModel>>((ref)=>TopRatedProducts());