import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter/widgets.dart';
import 'package:multistoreapp/global_variables.dart';
import 'package:multistoreapp/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:multistoreapp/provider/order_count_provider.dart';
import 'package:multistoreapp/provider/user_provider.dart';
import 'package:multistoreapp/services/manage_http_response.dart';
import 'package:multistoreapp/views/main_screen.dart';
import 'package:multistoreapp/views/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Don't use providerContainer, because if the user signOut,
//and then SingUp with different account but same mobile phone,
//it will still shows the previous user name and all details.
//final providerContainer = ProviderContainer();

//So use {required WidgetRef ref} to solve this issue.

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullname,
    required String password,
  }) async{

    try {
    User user = User(
      id: '', 
      fullname: fullname, 
      email: email, 
      state: '', 
      city: '', 
      locality: '', 
      password: password,
      token: '');

      http.Response response = await http.post(Uri.parse('$uri/api/signup'), 
      body: user.toJson(), //convert user object to Json for request body.
      headers: <String,String>{ //set the headers for the request.
        "Content-Type": 'application/json; charset=UTF-8', //specify the content type as json
        } 
      );

      manageHttpResponse(response: response, context: context, onSuccess: (){

  
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
        showSnackbar(context, 'Account has been created for you');
      });


    } catch (e) {
      print("Error: $e");
    }

  }


  //signin user.:

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
    required WidgetRef ref
    }) async{

      try{

        http.Response response = await http.post(Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          'email': email, //include email in request body
          'password': password //include password in request body
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });

        //handle the response:
        manageHttpResponse(response: response, context: context, onSuccess: ()async{

          //access sharedPref for token and user data storage
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String token = jsonDecode(response.body)['token'];

          await preferences.setString('auth_token', token);

          //encode user data received from backend as json
          //final userJson = jsonEncode(jsonDecode(response.body)['user']);//This is user is loggedUser sent in response
          final userJson = jsonEncode(jsonDecode(response.body));

          //update the app state with the user data using riverpod
          //providerContainer.read(userProvider.notifier).setUser(userJson);
          ref.read(userProvider.notifier).setUser(response.body);

          //store full data in preferences 
          await preferences.setString('user', userJson);

          //Navigate to Home screen
          if (ref.read(userProvider)!.token.isNotEmpty) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainScreen()), (route)=>false);
            showSnackbar(context, 'Logged In successfully.');
          }
        });


      } catch(e){
        showSnackbar(context, e.toString());
      }
  }

  getUserData(context, WidgetRef ref) async{
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth_token');

      if (token == null) {
        preferences.setString('auth_token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      });

      var response = jsonDecode(tokenRes.body);

      if (response==true) {
        http.Response userResponse = await http.get(Uri.parse('$uri/'),
        headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      });

      ref.read(userProvider.notifier).setUser(userResponse.body);
      }

    } catch(e){
      showSnackbar(context, e.toString());
    }
  }




  Future<void> signOutUser({required context, required WidgetRef ref}) async{
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //clear the token & user
      await preferences.remove('auth_token');
      await preferences.remove('user');

      //clear user state
      /*providerContainer.read(userProvider.notifier).signOut();
      providerContainer.read(orderCountProvider.notifier).resetCount();*/

      ref.read(userProvider.notifier).signOut();
      ref.read(orderCountProvider.notifier).resetCount();

      //navigate back to login screen
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){ return LoginScreen();}), (route)=> false);

      showSnackbar(context, 'Sign out Successfully');
    } catch (e){
      showSnackbar(context, 'error signing out');
    }
  }

  //Update user state, city and locality from "" empty to some value

  Future<void> updateUserLocation({
    required context,
    required String id,
    required String state,
    required String city,
    required String locality,
    required WidgetRef ref
  }) async{
    try {
      final http.Response response = await http.put(Uri.parse('$uri/api/users/$id'), 
      body: jsonEncode({
        'state': state,
        'city': city,
        'locality': locality,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

      manageHttpResponse(response: response, context: context, onSuccess: () async{
        //decode 
        final updatedUser = jsonDecode(response.body);

        SharedPreferences preferences = await SharedPreferences.getInstance();
        //encode - this prepares the data for storage in sharedPref.
        final userJson = jsonEncode(updatedUser);

        //update app state with riverpod.
        //providerContainer.read(userProvider.notifier).setUser(userJson);

        ref.read(userProvider.notifier).setUser(userJson);

        //store updated data in sharedPref.
        await preferences.setString('user', userJson); //same key which is used while signIn.


      });

    } catch (e) {
      showSnackbar(context, 'Error updating location');
    }
  }

}