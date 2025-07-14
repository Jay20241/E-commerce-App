import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/user.dart';

class UserProvider extends StateNotifier<User?>{
  //contructor intialize with default User Object
  //purpose: manage the state of the user object allowing updates
  UserProvider(): super(
    User(
      id: '', 
      fullname: '', 
      email: '', 
      state: '',  
      city: '', 
      locality: '', 
      password: '', 
      token: ''));

    //getter method to extract value from an object
    User? get user => state;

    //method to set user state from JSON
    //purpose: update the user state base on json string representation of user object
    void setUser(String userJson){
      state = User.fromJson(userJson);
    }

    //clear user state
    void signOut(){
      state = null;
    }

    //method to re-create the user state. Without this, the change in user is not updating on UI immediately.
    void recreateUserState({
      required String state,
      required String city,
      required String locality
    }){
      if (this.state!=null) { //this refers to UserProvider class
        this.state = User(
          id: this.state!.id, 
          fullname: this.state!.fullname, 
          email: this.state!.email, 
          state: state, 
          city: city, 
          locality: locality, 
          password: this.state!.password, 
          token: this.state!.token);
      }
    }
}

//make the data accessible within the app
final userProvider = StateNotifierProvider<UserProvider, User?>((ref)=>UserProvider());