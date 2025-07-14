import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/provider/cart_provider.dart';
import 'package:multistoreapp/views/main_screen.dart';
import 'package:multistoreapp/views/screens/checkout_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

//ref.read() is for functions
//ref.watch() is for data

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {

    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);

    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.20), 
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/user.png'), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              left: 322,
              top: 52,
              child: Stack(
                children: [
                  Image.asset('assets/user.png', width: 25, height: 25),
                  Positioned(top: 1, right: 1, child: Container(width: 20, height: 20, padding: EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)), 
                  child: Center(child: Text(cartData.length.toString() , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),),),))
                ],
              )),

              Positioned(
                left: 61,
                top: 51,
                child: Text('My Cart')
              )
          ],
        ),
        ),
      ),

        body: cartData.isEmpty ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Your Shopping Cart is Empty\n', textAlign: TextAlign.center),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return MainScreen();
            }));
          }, child: Text('Shop Now'))
        ],) 
        ): SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 49,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(),

                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 49,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 112, 107, 107)
                        ),
                        
                      )
                      ),

                      Positioned(
                        left: 44,
                        top: 19,
                        child: Container(
                          width: 10,
                          height: 10,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)
                          ),
                        )),

                        Positioned(
                        left: 69,
                        top: 14,
                        child: Text('You have ${cartData.length} items')),

                  ],
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                itemCount: cartData.length,
                itemBuilder: (context, index){
                  final cartItem = cartData.values.toList()[index];

                  return Card(
                    child: SizedBox(
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(cartItem.image[0], fit: BoxFit.cover),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cartItem.productName),
                              Text("\$ ${cartItem.productPrice.toStringAsFixed(2)}"),

                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 158, 49, 209)
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(onPressed: (){
                                          _cartProvider.decrementCartItem(cartItem.productId);

                                        }, icon: Icon(CupertinoIcons.minus, color: Colors.white)),
                                        Text(cartItem.quantity.toString(), style: TextStyle(color: Colors.white)),
                                        IconButton(onPressed: (){
                                          _cartProvider.incrementCartItem(cartItem.productId);

                                        }, icon: Icon(CupertinoIcons.add, color: Colors.white)),
                                      ],
                                    ),
                                  )
                                ],
                              ),

                              IconButton(onPressed: (){
                                _cartProvider.removeCartItem(cartItem.productId);

                              }, icon: Icon(CupertinoIcons.delete, color: Colors.red)),


                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })
            ],
          ),
        ),

        bottomNavigationBar: Container(
          width: 416,
          height: 89,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 416,
                  height: 89,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Color(0xFFC4C4C4))),
                ),
              ),

              Align(
                alignment: Alignment(-0.63, -0.26),
                child: Text('Subtotal', style: TextStyle(color: Colors.black)),
              ),

              Align(
                alignment: Alignment(-0.19, -0.31),
                child: Text("\$${totalAmount.toStringAsFixed(2)}"),
              ),

              Align(
                alignment: Alignment(0.83, -1),
                child: InkWell(
                  onTap: totalAmount==0.0 ? null : () {

                    if (totalAmount!=0.0) {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CheckoutScreen();
                      }));
                    }
                    
                  },
                  child: Container(
                    width: 166,
                    height: 71,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(color: totalAmount==0.0 ? Colors.grey : Colors.teal),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Check out'),
                            Icon(Icons.arrow_forward_ios, color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}