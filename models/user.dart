import 'dart:convert';

class User{
  final String id;
  final String fullname;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User({required this.id, required this.fullname, required this.email, required this.state, required this.city, required this.locality, required this.password, required this.token});

  //convert User object to map -> it is called serialization.
  //Map is collection of KEY-VALUE pair.
  //then serialize -> format like JSON for store or transmit.

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      "id": id,
      'fullname': fullname,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token
    };
  }

  //Process of converting Map to JSON is called serialization.:-
  /*json,encode() function convert a dart object to (such as Map or List)
  into a json string representation, making it suitable for communication btw diff systems.
  */ 
  String toJson() => json.encode(toMap());

  //deserialization: convert Map to User Object
  //factory constructor takes a Map(usually obtained from a Json objects)
  //and convert it into a User object.
  //TO SHOW ON UI or STORE LOCALLY.
  /*
  * IF A FIELD IS NOT PRESENT IN IT, IT DEFAULTS TO AN EMPTY STRING.
  */

  //MAP TO USER-OBJECT:
  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id: map['_id'] as String? ??"", 
      fullname: map['fullname'] as String? ??"",
      email: map['email'] as String? ??"", 
      state: map['state'] as String? ??"",
      city: map['city'] as String? ??"",
      locality: map['locality'] as String? ??"", 
      password: map['password'] as String? ??"",
      token: map['token'] as String? ??""
      );
  }

  //JSON TO MAP<String,dynamic>:
  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);


}



//STEPS TO CONSUME API IN FLUTTER APP:
/**
 * 1. Make model class like this.
 */