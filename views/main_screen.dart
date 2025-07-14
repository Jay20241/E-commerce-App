import 'package:flutter/material.dart';
import 'package:multistoreapp/views/nav_screens/account_sceen.dart';
import 'package:multistoreapp/views/nav_screens/cart_screen.dart';
import 'package:multistoreapp/views/nav_screens/category_screen.dart';
import 'package:multistoreapp/views/nav_screens/favorite_screen.dart';
import 'package:multistoreapp/views/nav_screens/home_screen.dart';
import 'package:multistoreapp/views/nav_screens/stores_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //const MainScreen({super.key}); //This constructor is basically used to pass the data. Here we don't need as of now.
  int _pageIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    FavoriteScreen(),
    CategoryScreen(),
    StoresScreen(),
    CartScreen(),
    AccountSceen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        selectedFontSize: 20,
        unselectedItemColor: Colors.grey,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"), //can also use Image.asset("",width:25)
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
        BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label: "Categories"),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: "Stores"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_sharp), label: "Account")
      ]),
      body: _pages[_pageIndex],
    );
  }
}