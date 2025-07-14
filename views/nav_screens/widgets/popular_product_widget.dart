import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/controllers/product_controller.dart';
import 'package:multistoreapp/provider/product_provider.dart';
import 'package:multistoreapp/views/nav_screens/widgets/product_item_widget.dart';
import 'package:multistoreapp/views/nav_screens/widgets/shimmer_product_item.dart';

class PopularProductWidget extends ConsumerStatefulWidget {
  const PopularProductWidget({super.key});

  @override
  ConsumerState<PopularProductWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<PopularProductWidget> {
  
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    final products = ref.read(productProvider);
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
        final products = await _productController.loadPopularProduct();
        ref.read(productProvider.notifier).setProducts(products);
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
    final products = ref.watch(productProvider);
    return SizedBox(
            height: 250,
            child: isLoading? 
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: products.length, // number of shimmer items
                itemBuilder: (context, index) {
                return Center(child: const ShimmerProductItem());
              },
            )
            :GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: products.length,
              itemBuilder: (context, index){
                final product = products[index];
                return Center(child: ProductItemWidget(productModel: product));
              }
            ),
          );
  }
}