import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/product_model.dart';

class RelatedProductProvider extends StateNotifier<List<ProductModel>>{
  RelatedProductProvider() : super([]); //Initialize with an empty list.

  void setProducts(List<ProductModel> products){
    state = products;
  }
}


final relatedProductProvider = StateNotifierProvider<RelatedProductProvider, List<ProductModel>>((ref)=>RelatedProductProvider());