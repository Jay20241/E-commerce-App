import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multistoreapp/models/product_model.dart';
import 'package:multistoreapp/provider/cart_provider.dart';
import 'package:multistoreapp/provider/favorite_provider.dart';
import 'package:multistoreapp/services/manage_http_response.dart';
import 'package:multistoreapp/views/details/product_details_screen.dart';

class ProductItemWidget extends ConsumerStatefulWidget {

  final ProductModel productModel;
  const ProductItemWidget({super.key, required this.productModel});

  @override
  ConsumerState<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    
    final cartProviderData = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.productModel.id);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ProductDetailsScreen(productModel: widget.productModel);
        }));
      },
      child: Container(
        width: 170,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(24)
              ),
              child: Stack(
                children: [
                  Image.network(widget.productModel.images[0], height: 170, width: 170, fit: BoxFit.cover),
                  
                  Positioned(
                    top: 5,
                    right: 0,
                    child: InkWell(onTap: (){
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
          child: favoriteProviderData.getFavoriteItem.containsKey(widget.productModel.id) ? 
            Icon(Icons.favorite, color: Colors.red)
            :Icon(Icons.favorite_border_outlined))),
      
      
                    Positioned(
                    bottom: 0,
                    right: 0,
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
                      child: isInCart ? 
                      Icon(Icons.shopping_bag)
                      :Icon(Icons.shopping_bag_outlined)
                      )
                    )
      
                ],
              ),
            ),
      
            
            
            Text(widget.productModel.productName, overflow: TextOverflow.ellipsis, style: GoogleFonts.roboto(fontSize: 14, color: const Color.fromARGB(255, 48, 62, 68), fontWeight: FontWeight.bold)),
      
            widget.productModel.averageRating==0?SizedBox()
            :Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 12),
                SizedBox(width: 4),
                Text(widget.productModel.averageRating.toStringAsFixed(1))
              ],
            ),

            
      
            //Text(widget.productModel.category, style: GoogleFonts.quicksand(fontSize: 13, color: const Color.fromARGB(255, 99, 102, 104))),

            Text('\$${widget.productModel.productPrice.toStringAsFixed(2)}',
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.purple
            ))
          ],
        ),
      ),
    );
  }
}