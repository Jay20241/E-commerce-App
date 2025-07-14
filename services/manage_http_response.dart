import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response, //http response from the request
  required BuildContext context, // to show snackbar.
  required VoidCallback onSuccess, //to execute on a success response
}){
  switch(response.statusCode){
    case 200:   //SUCCESSFUL
      onSuccess();
      break;
    case 400: //bad request
      showSnackbar(context, json.decode(response.body)['msg']);
      break;
    case 500: //server error
      showSnackbar(context, json.decode(response.body)['error']);
      break;
    case 201: //resource was created. (such a uploading product)
      onSuccess();
      break;
  }

}

void showSnackbar(BuildContext context, String title){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blueGrey,
      content: Text(title)));
}