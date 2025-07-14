import 'dart:convert';

import 'package:multistoreapp/global_variables.dart';
import 'package:multistoreapp/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:multistoreapp/services/manage_http_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController {
  
  uploadOrders({
  required String id,
  required String fullName,
  required String email,
  required String state,
  required String city,
  required String locality,
  required String productName,
  required int productPrice,
  required int quantity,
  required String category,
  required String image,
  required String buyerId,
  required String vendorId,
  required bool processing,
  required bool delivered,
  required context
  }) async{
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth_token');

      final OrderModel orderModel = OrderModel(id: id, fullName: fullName, email: email, state: state, city: city, locality: locality, productName: productName, productPrice: productPrice, quantity: quantity, category: category, image: image, buyerId: buyerId, vendorId: vendorId, processing: processing, delivered: delivered);
      http.Response response = await http.post(Uri.parse("$uri/api/orders"),
      body: orderModel.toJson(),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token! //this line is to use auth_middleware.js in the backend.
      });

      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackbar(context, 'Order placed successfully');
      });
    
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  //Method to get orders by buyer Id
  Future<List<OrderModel>> loadOrders({
    required String buyerId,
  }) async{
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth_token');

      http.Response response = await http.get(Uri.parse("$uri/api/orders/$buyerId"),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      });

      if (response.statusCode==200) {
        List<dynamic> data = jsonDecode(response.body);
        List<OrderModel> orders = data.map((order)=>OrderModel.fromJson(order)).toList();
        return orders;
      }else if(response.statusCode==404){
        return [];
      }else{
        throw Exception("Failded to load Orders");
      }

    } catch (e) {
      throw Exception("Error loading Orders");
    }
  }

  //delete order
  Future<void> deleteOrder({
    required String id,
    required context
  }) async{
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth_token');

      http.Response response = await http.delete(Uri.parse("$uri/api/orders/$id"),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      });

      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackbar(context, "Order deleted successfully");
      });

    } catch(e){
      showSnackbar(context, e.toString());
      //throw Exception("Error deleting Order");
    }
  }

  Future<int> getCompletedOrderCount({
    required String buyerId
  })async{

    try{
      List<OrderModel> orders = await loadOrders(buyerId: buyerId);
      int deliveredCount = orders.where((order)=>order.delivered).length;
      return deliveredCount;
    } catch(e){
      throw Exception("Error to get Order count");
    }

  }

}