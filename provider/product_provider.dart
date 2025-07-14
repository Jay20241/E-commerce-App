import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/product_model.dart';

class ProductProvider extends StateNotifier<List<ProductModel>>{
  ProductProvider() : super([]); //Initialize with an empty list.

  void setProducts(List<ProductModel> products){
    state = products;
  }
}


final productProvider = StateNotifierProvider<ProductProvider, List<ProductModel>>((ref)=>ProductProvider());