import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multistoreapp/controllers/order_controller.dart';
import 'package:multistoreapp/provider/cart_provider.dart';
import 'package:multistoreapp/provider/user_provider.dart';
import 'package:multistoreapp/services/manage_http_response.dart';
import 'package:multistoreapp/views/main_screen.dart';
import 'package:multistoreapp/views/nav_screens/widgets/gradient_button.dart';
import 'package:multistoreapp/views/screens/shipping_address_screen.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  
  String selectedPaymentMethod = 'stripe';
  final OrderController _orderController = OrderController();
  

  @override
  Widget build(BuildContext context) {

    final _cartProvider = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final user = ref.watch(userProvider);
    

    //final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();
    //double total = totalAmount + 10;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Checkout',
          style: GoogleFonts.getFont(
            'Lato',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ShippingAddressScreen();
                    },));
                  },
                  child: SizedBox(
                    width: 335,
                    height: 74,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 335,
                            height: 74,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFEFF0F2),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 70,
                          top: 17,
                          child: SizedBox(
                            width: 215,
                            height: 41,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  left: -1,
                                  top: -1,
                                  child: SizedBox(
                                    width: 219,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            
                                          },
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: SizedBox(
                                              width: 114,
                                              child: user!.state.isNotEmpty ? Text(
                                                "Your address",
                                                style: GoogleFonts.getFont(
                                                  'Lato',
                                                  color: const Color(0xFF0B0C1E),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.1,
                                                ),
                                              ) 
                                              : Text(
                                                "Add address",
                                                style: GoogleFonts.getFont(
                                                  'Lato',
                                                  color: const Color(0xFF0B0C1E),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: user!.state.isNotEmpty ? Text(
                                            user.state,
                                            style: GoogleFonts.getFont(
                                              'Lato',
                                              color: const Color(0xFF7F808C),
                                              fontSize: 12,
                                              height: 1.6,
                                            ),
                                          ) 
                                          : Text(
                                            "US",
                                            style: GoogleFonts.getFont(
                                              'Lato',
                                              color: const Color(0xFF7F808C),
                                              fontSize: 12,
                                              height: 1.6,
                                            ),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: user!.state.isNotEmpty ? Text(
                                            user.city,
                                            style: GoogleFonts.getFont(
                                              'Lato',
                                              color: const Color(0xFF7F808C),
                                              fontSize: 12,
                                              height: 1.6,
                                            ),
                                          )
                                          : Text(
                                            "Enter City",
                                            style: GoogleFonts.getFont(
                                              'Lato',
                                              color: const Color(0xFF7F808C),
                                              fontSize: 12,
                                              height: 1.6,
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        
                        Positioned(
                          left: 16,
                          top: 16,
                          child: SizedBox.square(
                            dimension: 42,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 43,
                                    height: 43,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFBF7F5),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Positioned(
                                          left: 11,
                                          top: 11,
                                          child: Image.network(
                                            'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png',
                                            width: 26,
                                            height: 26,
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 11,
                                  top: 11,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 305,
                          top: 25,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F6ce18a0efc6e889de2f2878027c689c9caa53feeedit%201.png?alt=media&token=a3a8a999-80d5-4a2e-a9b7-a43a7fa8789a',
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your Order',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
            
                Flexible(
                  child: ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: cartData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final cartItem = cartData.values.toList()[index];
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            width: 336,
                            height: 91,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFEFF0F2),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  left: 6,
                                  top: 6,
                                  child: SizedBox(
                                    width: 311,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 78,
                                          height: 78,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFBCC5FF),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Image.network(
                                              cartItem.image[0]),
                                        ),
                                        const SizedBox(width: 11),
                                        Expanded(
                                          child: Container(
                                            height: 78,
                                            alignment: const Alignment(0, -0.51),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      cartItem.productName,
                                                      style: GoogleFonts.getFont(
                                                        'Lato',
                                                        color:
                                                            const Color(0xFF0B0C1E),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        height: 1.3,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      cartItem.category,
                                                      style: GoogleFonts.getFont(
                                                        'Lato',
                                                        color:
                                                            const Color(0xFF7F808C),
                                                        fontSize: 12,
                                                        height: 1.6,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Container(
                                          height: 78,
                                          alignment: const Alignment(0, -0.03),
                                          child: Text(
                                            '\$${cartItem.productPrice.toStringAsFixed(2)}',
                                            style: GoogleFonts.getFont(
                                              'Lato',
                                              color: const Color(0xFF0B0C1E),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              height: 1.3,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Payment Method',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                RadioListTile<String>(
                  title: Text('Stripe 📱', style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  )),
                  value: 'stripe',
                  groupValue: selectedPaymentMethod, 
                  onChanged: (String? value){
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  }),

                  RadioListTile<String>(
                  title: Text('Cash on Delivery 🛵', style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  )),
                  value: 'cashOnDelivery',
                  groupValue: selectedPaymentMethod, 
                  onChanged: (String? value){
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  })
                
                
              ],
            ),
          ),
        ),
      ),
      //ref.watch(userProvider)!.state=="" ?
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  user!.state.isEmpty ?
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ShippingAddressScreen();
          },));

        }, child: Text('Enter Address'))
        :InkWell(
          onTap: () async{
            if (selectedPaymentMethod=='stripe') {
              
            }else{
              await Future.forEach(
              _cartProvider.getCartItems.entries, 
              (entry){
                var item = entry.value;
                _orderController.uploadOrders(
                  id: '', //blank because it is autogenerated
                  fullName: ref.read(userProvider)!.fullname, 
                  email: ref.read(userProvider)!.email, 
                  state: ref.read(userProvider)!.state, 
                  city: ref.read(userProvider)!.city, 
                  locality: ref.read(userProvider)!.locality, 
                  productName: item.productName, 
                  productPrice: item.productPrice, 
                  quantity: item.quantity, 
                  category: item.category, 
                  image: item.image[0], 
                  buyerId: ref.read(userProvider)!.id, 
                  vendorId: item.vendorId, 
                  processing: true, 
                  delivered: false, 
                  context: context);
              }).then((value) {
                _cartProvider.clearCart();
                showSnackbar(context, 'Order Placed');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MainScreen();
                },));
              });
            }
          },
          child: GradientButtonDemo(btnText: selectedPaymentMethod=='stripe' ? 'Pay Now' : 'Place Order')),
      ),
    );
  }
}