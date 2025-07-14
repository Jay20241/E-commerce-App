import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteProvider, Map<String, FavoriteModel>>(
  (ref) {
    return FavoriteProvider();
  },
);

class FavoriteProvider extends StateNotifier<Map<String, FavoriteModel>> {
  FavoriteProvider() : super({}){
    _loadFavoriteLocally(); //calling _loadFavoriteLocally() at initial, whenever FavoriteProvider class is created.
  }

  Future<void> _loadFavoriteLocally() async{
    final prefs = await SharedPreferences.getInstance(); //await prevents the code to go to next line, before fully execution of this line.
    final favoriteString = prefs.getString('favorites');
    if (favoriteString!=null) {
      final Map<String, dynamic> favoriteMap = jsonDecode(favoriteString);
      final favoriteObject = favoriteMap.map((key, value)=>MapEntry(key, FavoriteModel.fromJson(value)));

      state = favoriteObject;
    }
  }


  //Private method to save current list to SharedPref.
  Future<void> _saveFavoriteLocally() async{
    final prefs = await SharedPreferences.getInstance(); //await prevents the code to go to next line, before fully execution of this line.
    //we cannot store map to prefs, so we need to convert to json string.
    final favoriteString = jsonEncode(state);
    await prefs.setString('favorites', favoriteString);
  }

  void addProuctToFavorite({
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
  }) {
    state[productId] = FavoriteModel(
      productName: productName, 
      productPrice: productPrice, 
      category: category, 
      image: image, 
      vendorId: vendorId, 
      productQuantity: productQuantity, 
      quantity: quantity, 
      productId: productId, 
      description: description, 
      fullname: fullname);

    //notify listeners that the state has changed
    state = {...state};
    _saveFavoriteLocally();
  }

  void removeAllItems() {
    state.clear();
    state = {...state};
    _saveFavoriteLocally();
  }

  void removeFavoriteItem(String productId) {
    state.remove(productId);
    state = {...state};
    _saveFavoriteLocally();
  }
  Map<String, FavoriteModel> get getFavoriteItem => state;
}