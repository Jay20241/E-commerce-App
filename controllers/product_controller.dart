import 'package:multistoreapp/models/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multistoreapp/global_variables.dart';

class ProductController {
  Future<List<ProductModel>> loadPopularProduct() async{
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/popular-products"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      if(response.statusCode==200){
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        List<ProductModel> products = data.map((product)=> ProductModel.fromMap(product as Map<String, dynamic>)).toList();
        return products;
      }else if(response.statusCode==404){
        return [];
      }
      
      else{
        throw Exception('Failed to load popular products');
      }

    } catch (e) {
      throw Exception('Error loading popular products: $e');
    }
  }


  Future<List<ProductModel>> loadProductByCategory(String category) async{
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/products-by-category/$category"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      if(response.statusCode==200){
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        List<ProductModel> products = data.map((product)=> ProductModel.fromMap(product as Map<String, dynamic>)).toList();
        return products;
      }else if(response.statusCode==404){
        return [];
      }
      
      else{
        throw Exception('Failed to load products');
      }

    } catch (e) {
      throw Exception('Error loading products: $e');
    }
  }

  Future<List<ProductModel>> loadRelatedProductBySubcategory(String productId) async{
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/related-product-by-subcategory/$productId"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      if(response.statusCode==200){
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        List<ProductModel> products = data.map((product)=> ProductModel.fromMap(product as Map<String, dynamic>)).toList();
        return products;
      }else if(response.statusCode==404){
        return [];
      }else{
        throw Exception('Failed to load products');
      }

    } catch (e) {
      throw Exception('Error loading products: $e');
    }
  }

  
  Future<List<ProductModel>> loadTopRatedProduct() async{
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/top-rated-products"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      if(response.statusCode==200){
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        List<ProductModel> products = data.map((product)=> ProductModel.fromMap(product as Map<String, dynamic>)).toList();
        return products;
      }else if(response.statusCode==404){
        return [];
      }else{
        throw Exception('Failed to load products');
      }

    } catch (e) {
      throw Exception('Error loading products: $e');
    }
  }

/// /api/products-by-subcategory/:subCategory

Future<List<ProductModel>> loadProductsBySubcategory(String subCategory) async{
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/products-by-subcategory/$subCategory"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      if(response.statusCode==200){
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        List<ProductModel> products = data.map((product)=> ProductModel.fromMap(product as Map<String, dynamic>)).toList();
        return products;
      }else if(response.statusCode==404){
        return [];
      }else{
        throw Exception('Failed to load products');
      }

    } catch (e) {
      throw Exception('Error loading products: $e');
    }
  }

  //searching product by name and description
  Future<List<ProductModel>> searchProducts(String query) async{
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/search-products?query=$query"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      if(response.statusCode==200){
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        List<ProductModel> products = data.map((product)=> ProductModel.fromMap(product as Map<String, dynamic>)).toList();
        return products;
      }else if(response.statusCode==404){
        return [];
      }else{
        throw Exception('Failed to load products');
      }

    } catch (e) {
      throw Exception('Error loading products: $e');
    }
  }

}