import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/order_model.dart';

class OrderProvider extends StateNotifier<List<OrderModel>>{
  OrderProvider() : super([]); //Initialize with an empty list.

  void setOrders(List<OrderModel> orders){
    state = orders;
  }
}


final orderProvider = StateNotifierProvider<OrderProvider, List<OrderModel>>((ref)=>OrderProvider());