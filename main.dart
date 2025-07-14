import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/controllers/auth_controller.dart';
import 'package:multistoreapp/provider/user_provider.dart';
import 'package:multistoreapp/views/main_screen.dart';
import 'package:multistoreapp/views/screens/login.dart';

void main() {
  //run the flutter app wrapped in a providerScope for managing state.
  runApp(ProviderScope(child: const MainApp()));
}

/*In bottom Nav bar, whenever we visit any tab, it rebuilds whole page because of FutureBuilder, which is not best for industry standards.
 *We can resolve this issue using RiverPod.
*/


//root widget of app, a consumerWidget to consume state change.
class MainApp extends ConsumerWidget { // StatelessWidget to ConsumerWidget
  const MainApp({super.key});

//method to check the token and user data.
  
  Future<void> _checkTokenAndSetUser(WidgetRef ref, context) async{
    //obtain an instance of sharedPref 

    //if we use sharedPref. for token, then if user is deleted in database, he/she can still use the app becoz the token is still available locally.
    //which is not a good practise.
    /*SharedPreferences preferences = await SharedPreferences.getInstance();  

    //retreive
    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');

    if (token != null && userJson !=null) {
      ref.read(userProvider.notifier).setUser(userJson);
    }else{
      ref.read(userProvider.notifier).signOut();
    } */

   await AuthController().getUserData(context, ref);
    ref.watch(userProvider);

  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //Write business logic to navigate the user to which screen.
      //home: LoginScreen()
      home: FutureBuilder(
        future: _checkTokenAndSetUser(ref, context), 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final user = ref.watch(userProvider);
          return user!.token.isNotEmpty ? MainScreen() : LoginScreen();
          //return MainScreen();
        })
    );
  }
}


//----- ref.watch() v/s ref.read()