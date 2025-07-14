import 'package:flutter/material.dart';
import 'package:multistoreapp/views/screens/search_products_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.20,
      child: Stack(children: [
        //Image.asset('assets/searchBanner.jpeg', width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(color: const Color.fromARGB(255, 16, 77, 128)),
        ),
        Positioned(
          left: 100,
          top: 13,
          child: SizedBox(
            width: 250,
            height: 50,
            child: TextField(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SearchProductsScreen();
                }));
              },
              decoration: InputDecoration(
                hintText: 'Search MultiStore.in',
                hintStyle: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 141, 140, 140)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                prefixIcon: Image.asset('assets/search.png'),
                suffixIcon: Image.asset('assets/cam.png'),
                fillColor: Colors.grey.shade200,
                filled: true,
                focusColor: Colors.black
              ),
            ))
          ),

          Positioned(
            left: 380,
            top: 20,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                overlayColor: MaterialStateProperty.all(const Color.fromARGB(255, 42, 41, 41)),
                child: Ink(
                  width: 31, 
                  height: 31,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/bell.png'))
                  ),
                ),
              ),
            )
          ),

          Positioned(
            left: 430,
            top: 20,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                overlayColor: MaterialStateProperty.all(const Color.fromARGB(255, 42, 41, 41)),
                child: Ink(
                  width: 31, 
                  height: 31,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/message.png'))
                  ),
                ),
              ),
            )
          )
      ],
      ),
    );
  }
}


//NOTE: TextField() AND TextFormField() are basically same. But TextFormField() have addition property "validator:".
//Material() is like Scaffold().
//NOTE: Container() AND SizedBox() are basically same. But Container() have addition property "decoration:".