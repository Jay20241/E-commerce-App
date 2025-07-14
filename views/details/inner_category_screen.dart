import 'package:flutter/material.dart';
import 'package:multistoreapp/models/category_model.dart';
import 'package:multistoreapp/views/nav_screens/account_sceen.dart';
import 'package:multistoreapp/views/nav_screens/cart_screen.dart';
import 'package:multistoreapp/views/nav_screens/category_screen.dart';
import 'package:multistoreapp/views/nav_screens/favorite_screen.dart';
import 'package:multistoreapp/views/nav_screens/stores_screen.dart';
import 'package:multistoreapp/views/nav_screens/widgets/inner_category_content.dart';

class InnerCategoryScreen extends StatefulWidget {

  final CategoryModel categoryModel;
  const InnerCategoryScreen({super.key, required this.categoryModel});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    
    final List<Widget> pages = [
    InnerCategoryContent(categoryModel: widget.categoryModel),
    FavoriteScreen(),
    CategoryScreen(),
    StoresScreen(),
    CartScreen(),
    AccountSceen()
  ];


    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        selectedFontSize: 20,
        unselectedItemColor: Colors.grey,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
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
      body: pages[pageIndex],
    );
  }
}