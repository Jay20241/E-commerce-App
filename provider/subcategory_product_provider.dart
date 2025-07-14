import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/product_model.dart';

class SubcategoryProductProvider extends StateNotifier<List<ProductModel>>{
  SubcategoryProductProvider() : super([]); //Initialize with an empty list.

  void setProducts(List<ProductModel> products){
    state = products;
  }
}


final subcategoryAllProductsProvider = StateNotifierProvider<SubcategoryProductProvider, List<ProductModel>>((ref)=>SubcategoryProductProvider());