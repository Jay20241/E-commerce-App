import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multistoreapp/controllers/product_controller.dart';
import 'package:multistoreapp/models/product_model.dart';
import 'package:multistoreapp/provider/cart_provider.dart';
import 'package:multistoreapp/provider/favorite_provider.dart';
import 'package:multistoreapp/provider/related_product_provider.dart';
import 'package:multistoreapp/services/manage_http_response.dart';
import 'package:multistoreapp/views/nav_screens/widgets/product_item_widget.dart';
import 'package:multistoreapp/views/nav_screens/widgets/reusable_text_widget.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {

  final ProductModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  
  
  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async{
      final ProductController _productController = ProductController();
      try {
        final products = await _productController.loadRelatedProductBySubcategory(widget.productModel.id);
        ref.read(relatedProductProvider.notifier).setProducts(products);
      } catch (e) {
        print("Error: $e");
      }
    }
  
  @override
  Widget build(BuildContext context) {
    final relatedProducts = ref.watch(relatedProductProvider);
    final cartData = ref.watch(cartProvider);
    final cartProviderData = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider); //only this line can make favorite button filled or not "real-time"
    
////but still whenever user close app and come again the cart & favorite is empty.
////we will solve this via storing in locally.
    
    final isInCart = cartData.containsKey(widget.productModel.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel.productName, style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
             favoriteProviderData.addProuctToFavorite(
              productName: widget.productModel.productName, 
              productPrice: widget.productModel.productPrice, 
              category: widget.productModel.category, 
              image: widget.productModel.images, 
              vendorId: widget.productModel.vendorId, 
              productQuantity: widget.productModel.quantity, 
              quantity: 1, 
              productId: widget.productModel.id, 
              description: widget.productModel.description, 
              fullname: widget.productModel.fullname);

              showSnackbar(context, 'Added to Favorite');
          }, 
          icon: favoriteProviderData.getFavoriteItem.containsKey(widget.productModel.id) ? 
            Icon(Icons.favorite, color: Colors.red)
            :Icon(Icons.favorite_border_outlined))
        ],
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(
                width: 260,
                height: 275,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 50,
                      child: Container(
                        width: 260,
                        height: 260,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(130)
                        ),
                      )
                      ),
          
                      Positioned(
                        left: 22,
                        top: 0,
                      child: Container(
                        width: 216,
                        height: 274,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 155, 191, 209),
                          borderRadius: BorderRadius.circular(14)
                        ),
          
                        child: SizedBox(
                          height: 300,
                          child: PageView.builder(
                            itemCount: widget.productModel.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Image.network(widget.productModel.images[index], width: 198, height: 225, fit: BoxFit.cover);
                            },),
                        ),
                      )
                      )
                  ],
                ),
              )),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.productModel.productName),
          
                    Text("\$ ${widget.productModel.productPrice.toString()}"),
                  ],
                ),
              ),
          
              widget.productModel.totalRatings==0 ? Text('') 
              : Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    
                    RatingBar.readOnly(
                      filledIcon: Icons.star, 
                      emptyIcon: Icons.star_border,
                      initialRating: widget.productModel.averageRating,
                      maxRating: 5,
                    ),
          
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Text(widget.productModel.averageRating.toStringAsFixed(1)),
                        Text("(${widget.productModel.totalRatings})"),
                      ],
                    ),
                  ],
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About',
                    style: GoogleFonts.lato(fontSize: 17, letterSpacing: 1.7, color: Colors.indigo, fontWeight: FontWeight.w500)),
          
                    Text(widget.productModel.description, style: GoogleFonts.lato(letterSpacing: 1.7, fontSize: 15)),
                  ],
                ),
              ),
          
              ReusableTextWidget(title: 'Related Products', subtitle: ''),
          
              SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: relatedProducts.length,
                itemBuilder: (context, index){
                  final product = relatedProducts[index];
                  return ProductItemWidget(productModel: product);
                }
              ),
            ),

            SizedBox(height: 60)
          
            ],
          ),
        ),
        bottomSheet: Padding(padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: isInCart ? null : () {
            cartProviderData.addProductToCart(
              productName: widget.productModel.productName, 
              productPrice: widget.productModel.productPrice, 
              category: widget.productModel.category, 
              image: widget.productModel.images, 
              vendorId: widget.productModel.vendorId, 
              productQuantity: widget.productModel.quantity, 
              quantity: 1, 
              productId: widget.productModel.id, 
              description: widget.productModel.description, 
              fullname: widget.productModel.fullname);

              showSnackbar(context, "Added to Cart ✔");
          },
          child: Container(
            width: 386,
            height: 46,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isInCart ? Colors.grey : Colors.green,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Center(child: Text('ADD TO CART')),
          ),
          )),
    );
  }
}