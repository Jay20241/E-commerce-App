import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/category_model.dart';

class CategotyProvider extends StateNotifier<List<CategoryModel>>{
  CategotyProvider() : super([]); //Initialize with an empty list.

  void setCategories(List<CategoryModel> categories){
    state = categories;
  }
}


final categoryProvider = StateNotifierProvider<CategotyProvider, List<CategoryModel>>((ref)=>CategotyProvider());