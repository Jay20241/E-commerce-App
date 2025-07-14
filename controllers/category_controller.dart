// cloudinary_public: ^0.23.1

//WE ARE USING MVC PATTERN
//NOTE: First we upload images on cloudinary and get the image url and then upload the image url to MongoDB


import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:multistoreapp/global_variables.dart';
import 'package:multistoreapp/models/category_model.dart';


class CategoryController {
  
  //load the uploaded categories
  Future<List<CategoryModel>> loadCategories() async{
    try {
      //send an http get request to fetch categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'), 
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

        print('Response: ${response.body}');

      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body);
        List<CategoryModel> categories = data.map((category) => CategoryModel.fromJson(category)).toList();
        return categories;
      }else if(response.statusCode==404){
        return [];
      }else{
        throw Exception('Failed to load categories');
        
      }
    } catch (e) {
      throw Exception('Error loading categories: $e');
    }
  }

}