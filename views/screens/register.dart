import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multistoreapp/controllers/auth_controller.dart';
import 'package:multistoreapp/views/screens/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  String email = ''; //late is used when you don't want to initialize the value.
  String fullname = '';
  String password = '';
  bool isLoading = false;

  signUpUser() async{
    setState(() {
      isLoading = true;
    });
    await _authController.signUpUsers(
      context: context, 
      email: email, 
      fullname: fullname,
      password: password).whenComplete((){
        _formKey.currentState!.reset();
        setState(() {
          isLoading = false;
        });
      });
  }

  //const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Your Account", 
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: const Color.fromARGB(255, 42, 103, 44), 
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      fontSize: 23
                    )),
                      
                    Text(
                    "Explore world on one click", 
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: const Color.fromARGB(255, 42, 103, 44), 
                      letterSpacing: 0.2,
                      fontSize: 14
                    )),
                      
                    Image.asset('assets/createacc.png', width: 200, height: 200),
              
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Text('Full Name', style: GoogleFonts.getFont('Nunito Sans', fontWeight: FontWeight.w600, letterSpacing: 0.2)),
                        ],
                      ),
                    ),
                      
                    TextFormField( 
                      onChanged: (value) {
                        fullname = value;
                      },
                      validator: (value){ //THIS WILL SHOW ERROR TO USER IF THERE.
                        if (value!.isEmpty) {
                          return 'Enter your fullname';
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter Full Name',
                        labelStyle: GoogleFonts.getFont('Nunito Sans', fontSize: 14, letterSpacing: 0.1),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/user.png', width: 15, height: 15),
                        )
                      ),
                    ),
                      
                    SizedBox(height: 20),
              
              
              
                      
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Text('Email', style: GoogleFonts.getFont('Nunito Sans', fontWeight: FontWeight.w600, letterSpacing: 0.2)),
                        ],
                      ),
                    ),
                      
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value){
                        if (value!.isEmpty) {
                          return 'Enter your email';
                        }
                        else if(!value.contains("@")){
                          return 'Enter valid email';
                        }
                        else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter Email',
                        labelStyle: GoogleFonts.getFont('Nunito Sans', fontSize: 14, letterSpacing: 0.1),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/email.png', width: 15, height: 15),
                        )
                      ),
                    ),
                      
                    SizedBox(height: 20),
                      
                      
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Text('Password', style: GoogleFonts.getFont('Nunito Sans', fontWeight: FontWeight.w600, letterSpacing: 0.2)),
                        ],
                      ),
                    ),
                      
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value){
                        if (value!.isEmpty) {
                          return 'Enter your password';
                        }
                        else if(value.length <= 5){
                          return 'Enter strong password';
                        }
                        else{
                          return null;
                        }
                      },
                      
                      obscureText: false,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter Password',
                        labelStyle: GoogleFonts.getFont('Nunito Sans', fontSize: 14, letterSpacing: 0.1),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/pass.png', width: 15, height: 15),
                        ),
                        suffixIcon: Icon(Icons.visibility)
                      ),
                    ),
              
                    SizedBox(height: 20),
              
                    InkWell(
                      onTap: () async{
                        if (_formKey.currentState!.validate()) {
                          signUpUser();
                        }else{
                          print('failed');
                        }
                      },
                      child: Container(
                        width: 319,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: isLoading? LinearGradient(colors: [const Color.fromARGB(255, 119, 120, 119), const Color.fromARGB(255, 104, 105, 105)]):LinearGradient(colors: [const Color.fromARGB(255, 37, 108, 39), const Color.fromARGB(255, 4, 68, 6)])
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 278,
                              top: 19,
                              child: Opacity(opacity: 0.5, child: Container(
                                width: 60,
                                height: 60,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(border: Border.all(width: 12, color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(30)),
                              ),)
                            ),
                                  
                              Positioned(
                                left: 260,
                                top: 29,
                                child: Opacity(opacity: 0.5, child: Container(
                                width: 10,
                                height: 10,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(border: Border.all(width: 12, color: Colors.purple),
                                borderRadius: BorderRadius.circular(5)),
                              ), )
                              ),
                                  
                              Center(child: isLoading? const CircularProgressIndicator(color: Colors.grey):Text('Sign Up', style: GoogleFonts.getFont('Lato', color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),))
                          ],
                        ),
                      ),
                    ),
              
                    SizedBox(height: 20,),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an Account?", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, letterSpacing: 1),),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return LoginScreen();
                            }));
                          },
                          child: Text("Sign in", style: GoogleFonts.roboto(color: Colors.deepPurple, fontWeight: FontWeight.bold, letterSpacing: 1)))
                      ],
                    )
                      
                      
                      
                      
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}