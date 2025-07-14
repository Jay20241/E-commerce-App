// a notifier class to manage the cart state, extending stateNotifier
//with an initial state of an empty map.


import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


//define a stateNotifierProvider to expose an instance of the CartNotifier
//Making it accessible within our app
final cartProvider = StateNotifierProvider<CartNotifier, Map<String, CartModel>>(
  (ref) {return CartNotifier();}
);


class CartNotifier extends StateNotifier<Map<String, CartModel>>{
  CartNotifier() : super({}){
    _loadCartLocally();
  }

  Future<void> _loadCartLocally() async{
    final prefs = await SharedPreferences.getInstance(); //await prevents the code to go to next line, before fully execution of this line.
    final cartString = prefs.getString('carts');
    if (cartString!=null) {
      final Map<String, dynamic> cartMap = jsonDecode(cartString);
      final cartObject = cartMap.map((key, value)=>MapEntry(key, CartModel.fromJson(value)));

      state = cartObject;
    }
  }


  //Private method to save current list to SharedPref.
  Future<void> _saveCartLocally() async{
    final prefs = await SharedPreferences.getInstance(); //await prevents the code to go to next line, before fully execution of this line.
    //we cannot store map to prefs, so we need to convert to json string.
    final cartString = jsonEncode(state);
    await prefs.setString('carts', cartString);
  }


  //Method to add product to the cart
  void addProductToCart({
    required String productName,
  required int productPrice,
  required String category,
  required List<String> image,
  required String vendorId,
  required int productQuantity,
  required int quantity,
  required String productId,
  required String description,
  required String fullname
  }){

    //check if product is already in the cart ?
    if (state.containsKey(productId)) {
      //if the product is already in the cart, update the quantity and may be other details
      state = {
        ...state,
        productId : CartModel(
          productName: state[productId]!.productName, 
          productPrice: state[productId]!.productPrice, 
          category: state[productId]!.category, 
          image: state[productId]!.image, 
          vendorId: state[productId]!.vendorId, 
          productQuantity: state[productId]!.productQuantity,
          quantity: state[productId]!.quantity + 1, 
          productId: state[productId]!.productId, 
          description: state[productId]!.description, 
          fullname: state[productId]!.fullname) 
      };
      _saveCartLocally();
    }
    else{
      state = {
        ...state,
        productId: CartModel(
          productName: productName, 
          productPrice: productPrice, 
          category: category, 
          image: image, 
          vendorId: vendorId, 
          productQuantity: productQuantity, 
          quantity: quantity, 
          productId: productId, 
          description: description, 
          fullname: fullname)
      };
      _saveCartLocally();
    }
  }

  //increment and decrement the cart quantity 

  void incrementCartItem(String productId){
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;

      //Notify listeners:
      state = {...state};
      _saveCartLocally();
    }
  }
  void decrementCartItem(String productId){
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;

      //Notify listeners:
      state = {...state};
      _saveCartLocally();
    }
  }

  //remove item from cart
  void removeCartItem(String productId){
    state.remove(productId);
    //Notify listeners:
    state = {...state};
    _saveCartLocally();
  }

  //calculate total amount of items in the cart
  double calculateTotalAmount(){
    double totalAmount = 0.0;
    state.forEach((productId, cartItem){
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }

  void clearCart(){
    state = {};
    state = {...state};
    _saveCartLocally();
  }
  //Getter to extract all fields of order
   Map<String, CartModel> get getCartItems => state;
}