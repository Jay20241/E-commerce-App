import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/subcategory_model.dart';

class SubcategoryProvider extends StateNotifier<List<SubcategoryModel>>{
  SubcategoryProvider() : super([]); //Initialize with an empty list.

  void setSubcategories(List<SubcategoryModel> subcategories){
    state = subcategories;
  }
}


final subcategoryProvider = StateNotifierProvider<SubcategoryProvider, List<SubcategoryModel>>((ref)=>SubcategoryProvider());