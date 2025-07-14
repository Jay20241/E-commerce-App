import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/controllers/product_controller.dart';
import 'package:multistoreapp/provider/top_rated_products.dart';
import 'package:multistoreapp/views/nav_screens/widgets/product_item_widget.dart';

class TopRatedWidget extends ConsumerStatefulWidget {
  const TopRatedWidget({super.key});

  @override
  ConsumerState<TopRatedWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<TopRatedWidget> {
  

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async{
      final ProductController _productController = ProductController();
      try {
        final products = await _productController.loadTopRatedProduct();
        ref.read(topRatedProductProvider.notifier).setProducts(products);
      } catch (e) {
        print("Error: $e");
      }
    }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(topRatedProductProvider);
    return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index){
                final product = products[index];
                return ProductItemWidget(productModel: product);
              }
            ),
          );
  }
}