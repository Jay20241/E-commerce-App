import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multistoreapp/controllers/product_review_controller.dart';
import 'package:multistoreapp/models/order_model.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel orderModel;
  const OrderDetailsScreen({super.key, required this.orderModel});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final TextEditingController _reviewController = TextEditingController();

  double rating = 0.0;

  final ProductReviewController _productReviewController = ProductReviewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.orderModel.productName)),
      body: Column(
        children: [
          Container(
              width: 335,
              height: 153,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 336,
                        height: 154,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.teal),
                          borderRadius: BorderRadius.circular(9)
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 13,
                              top: 9,
                              child: Container(
                                width: 78,
                                height: 78,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 125, 176, 234),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 10,
                                      top: 5,
                                      child: Image.network(
                                        widget.orderModel.image,
                                        width: 58,
                                        height: 67,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
            
                            Positioned(
                              left: 101,
                              top: 14,
                              child: SizedBox(
                                width: 216,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
            
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(widget.orderModel.productName),
                                          ),
            
                                          SizedBox(height: 4),
            
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(widget.orderModel.productPrice.toString())),
            
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              )
                            ),
                            
                            Positioned(
                              left: 13,
                              top: 113,
                              child: Container(
                                width: 100,
                                height: 25,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: widget.orderModel.delivered==true ? Colors.teal : widget.orderModel.processing==true ? Colors.purple : Colors.red,
                                  borderRadius: BorderRadius.circular(4)
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 9,
                                      top: 2,
                                      child: Text(widget.orderModel.delivered==true ? "Delivered" : widget.orderModel.processing==true ? "Processing" : "Canceled")
                                      ),
            
            
                                  ],
                                ),
                              )
                            ),
            
                            Positioned(
                              left: 298,
                              top: 115,
                              child: InkWell(
                                onTap: (){},
                                child: Icon(Icons.delete, color: Colors.red)))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              width: 336,
              height: widget.orderModel.delivered ? 170 : 120,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 171, 176, 171)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Delivery Address', style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.7)),
                        SizedBox(height: 8),

                        Text("${widget.orderModel.locality}, ${widget.orderModel.city}, ${widget.orderModel.state}"),

                        Text("To : ${widget.orderModel.fullName}"),

                        Text("Order Id : ${widget.orderModel.id}"),
                      ],
                    ),
                  ),

                  widget.orderModel.delivered
                  ? TextButton(onPressed: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text('Leave a Review'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _reviewController,
                              decoration: InputDecoration(
                                labelText: 'Your Review'
                              ),
                            ),
                            RatingBar(
                              filledIcon: Icons.star, 
                              emptyIcon: Icons.star_border,
                              onRatingChanged: (value){
                                rating = value;
                              },
                              initialRating: 3,
                              maxRating: 5,
                            )
                          ],
                        ),
                        actions: [
                          TextButton(onPressed: (){
                            final review = _reviewController.text;
                            _productReviewController.uploadReview(
                              buyerId: widget.orderModel.buyerId, 
                              email: widget.orderModel.email, 
                              fullName: widget.orderModel.fullName, 
                              productId: widget.orderModel.id, 
                              rating: rating, 
                              review: review, 
                              context: context);
                          }, child: Text('Submit'))
                        ],
                      );
                    });
                  }, child: Text('Leave a Review')) 
                  : SizedBox()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}