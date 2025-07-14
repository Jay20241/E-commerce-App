import 'package:flutter/material.dart';
import 'package:multistoreapp/controllers/product_controller.dart';
import 'package:multistoreapp/models/product_model.dart';
import 'package:multistoreapp/services/manage_http_response.dart';
import 'package:multistoreapp/views/nav_screens/widgets/product_item_widget.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {

  final ProductController _productController = ProductController();
  final TextEditingController _searchController = TextEditingController();

  List<ProductModel> _searchedProducts = [];
  bool isLoading = false;

  void _searchProducts() async{
    setState(() {
      isLoading = true;
    });
    try {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        final products = await _productController.searchProducts(query);
        setState(() {
          _searchedProducts = products;
        });
      }
    } catch (e) {
      showSnackbar(context, 'Something Went Wrong!');
    }finally{
      setState(() {
      isLoading = false;
    });
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    final crossAxisCount = screenWidth<600 ? 2:4;
    final childAspectRatio = screenWidth<600 ? 3/4 : 4/5;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
          labelText: 'Search Products....',
          suffixIcon: IconButton(onPressed: _searchProducts
          , icon: Icon(Icons.search))
        ),
      )
    ),

    body: Column(
      children: [
        SizedBox(height: 16),
        if(isLoading)
          Center(child: CircularProgressIndicator())

        else if(_searchedProducts.isEmpty)
          Center(child: Text('No Products Found'))

        else
          Expanded(child: 
          GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _searchedProducts.length,
          itemBuilder: (context, index){
          final product = _searchedProducts[index];
            return ProductItemWidget(productModel: product);
          }
        ))
      ],
    ),

    );
  }
}