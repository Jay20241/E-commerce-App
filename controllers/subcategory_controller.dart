import 'dart:convert';

import 'package:multistoreapp/models/subcategory_model.dart';
import 'package:http/http.dart' as http;
import 'package:multistoreapp/global_variables.dart';

class SubcategoryController {
  Future<List<SubcategoryModel>> getSubCategoriesByCategoryName(String categoryName) async{


    try {
      http.Response response = await http.get(Uri.parse("$uri/api/category/$categoryName/subcategories"),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          return data.map((subcategory) => SubcategoryModel.fromJson(subcategory)).toList();
        }
        return [];

      } else if(response.statusCode == 404){ 
        return [];
      }
      
      return [];


    } catch (e) {
      return [];
    }
  }
}

