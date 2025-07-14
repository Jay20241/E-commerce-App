import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/controllers/product_controller.dart';
import 'package:multistoreapp/models/subcategory_model.dart';
import 'package:multistoreapp/provider/subcategory_product_provider.dart';
import 'package:multistoreapp/views/nav_screens/widgets/product_item_widget.dart';
import 'package:multistoreapp/views/nav_screens/widgets/shimmer_product_item.dart';

class SubcategoryProductScreen extends ConsumerStatefulWidget {
  final SubcategoryModel subcategoryModel;
  const SubcategoryProductScreen({super.key, required this.subcategoryModel});

  @override
  ConsumerState<SubcategoryProductScreen> createState() => _SubcategoryProductScreenState();
}

class _SubcategoryProductScreenState extends ConsumerState<SubcategoryProductScreen> {
    bool isLoading = true;

  @override
  void initState() {
    super.initState();

    final products = ref.read(subcategoryAllProductsProvider);
    if (products.isEmpty) {
      _fetchProducts();
    }else{
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchProducts() async{
      final ProductController _productController = ProductController();
      try {
        final products = await _productController.loadProductsBySubcategory(widget.subcategoryModel.subCategoryName);
        ref.read(subcategoryAllProductsProvider.notifier).setProducts(products);
      } catch (e) {
        print("Error: $e");
      }finally{
        setState(() {
          isLoading = false;
        });
      }
    }
  
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(subcategoryAllProductsProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    final crossAxisCount = screenWidth<600 ? 2:4;
    final childAspectRatio = screenWidth<600 ? 3/4 : 4/5;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subcategoryModel.subCategoryName),
      ),

      body: 
      isLoading ? 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: products.length, // number of shimmer items
          itemBuilder: (context, index) {
            return const ShimmerProductItem();
          },
        ),
      )
      :Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index){
          final product = products[index];
            return ProductItemWidget(productModel: product);
          }
        ),
      ),
    );
  }
}