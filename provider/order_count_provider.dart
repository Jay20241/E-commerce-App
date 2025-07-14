import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/controllers/order_controller.dart';
import 'package:multistoreapp/services/manage_http_response.dart';

class OrderCountProvider extends StateNotifier<int>{
  OrderCountProvider() : super(0); //Initialize with an empty list.

  Future<void> fetchDeliveredOrderCount(String buyerId, context) async{
    try {
      OrderController orderController = OrderController();
      int count = await orderController.getCompletedOrderCount(buyerId: buyerId);
      state = count;
    } catch (e) {
      showSnackbar(context, 'Error fetching count');
    }
  }

  //The problem is: when a user signOut and then sign up with
//new account, the completed count will be shown as per previous.
//So we need to reset the completed count after SignOut.
void resetCount(){
  state = 0;
}

}


final orderCountProvider = StateNotifierProvider<OrderCountProvider, int>((ref)=>OrderCountProvider());