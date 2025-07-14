import 'package:flutter/material.dart';
import 'package:multistoreapp/views/nav_screens/widgets/banner_widget.dart';
import 'package:multistoreapp/views/nav_screens/widgets/category_item_widget.dart';
import 'package:multistoreapp/views/nav_screens/widgets/header_widget.dart';
import 'package:multistoreapp/views/nav_screens/widgets/popular_product_widget.dart';
import 'package:multistoreapp/views/nav_screens/widgets/reusable_text_widget.dart';
import 'package:multistoreapp/views/nav_screens/widgets/top_rated_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
        child: HeaderWidget()),
      body: 
       SingleChildScrollView(
         child: Column(
            children: [
              BannerWidget(),
              CategoryWidget(),
              ReusableTextWidget(title: "Popular Products", subtitle: "View all"),
              PopularProductWidget(),
              ReusableTextWidget(title: "Top Products", subtitle: ""),
              TopRatedWidget()
            ],
          ),
       ),
      
    );
  }
}