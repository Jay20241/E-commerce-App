import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multistoreapp/controllers/product_controller.dart';
import 'package:multistoreapp/controllers/subcategory_controller.dart';
import 'package:multistoreapp/models/category_model.dart';
import 'package:multistoreapp/models/product_model.dart';
import 'package:multistoreapp/models/subcategory_model.dart';
import 'package:multistoreapp/views/details/subcategory_product_screen.dart';
import 'package:multistoreapp/views/nav_screens/widgets/product_item_widget.dart';
import 'package:multistoreapp/views/nav_screens/widgets/reusable_text_widget.dart';

class InnerCategoryContent extends StatefulWidget {

  final CategoryModel categoryModel;
  const InnerCategoryContent({super.key, required this.categoryModel});

  @override
  State<InnerCategoryContent> createState() => _InnerCategoryContentState();
}

class _InnerCategoryContentState extends State<InnerCategoryContent> {
  late Future<List<SubcategoryModel>> _subCategories;

  late Future<List<ProductModel>> futureProducts;
  
  final SubcategoryController _subcategorycontroller = SubcategoryController();
  @override
  void initState() {
    super.initState();
    _subCategories = _subcategorycontroller.getSubCategoriesByCategoryName(widget.categoryModel.name);
    futureProducts = ProductController().loadProductByCategory(widget.categoryModel.name);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Stack(children: [
              Image.asset('assets/searchBanner.jpeg', width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
            
              Positioned(
                left: 16,
                top: 68,
                child: IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.arrow_back, color: Colors.white))),
            
              Positioned(
                left: 64,
                top: 68,
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
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
                  left: 311,
                  top: 78,
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
                  left: 354,
                  top: 78,
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
            ])),

            SizedBox(height: 170, width: MediaQuery.of(context).size.width, child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(widget.categoryModel.image,fit: BoxFit.cover))),

            Text('Shop by subcategories'),


            FutureBuilder(
          future: _subCategories, 
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Center(child: Text('Error: ${snapshot.error}'));
            }else if(!snapshot.hasData || snapshot.data!.isEmpty){
              return const Center(child: Text('No categories found'));
            }
            else{
              final List<SubcategoryModel> subcategories = snapshot.data!;
              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: subcategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8), 
                itemBuilder: (context,index){
                  final subcategory = subcategories[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SubcategoryProductScreen(subcategoryModel: subcategory);
                      },));
                    },
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Image.network(subcategory.image, width: 50, height: 50),
                        Text(subcategory.subCategoryName,
                        style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                  );
                });
            }
          }),

          ReusableTextWidget(title: 'Popular Products', subtitle: 'View all'),


          FutureBuilder(
      future: futureProducts, 
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              Center(child: CircularProgressIndicator()),
              Center(child: Text('Just a moment....')),
            ],
          );
        }else if(snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(child: Text('Oops! Out of Stock'));
        }else{
          final products = snapshot.data;
          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products!.length,
              itemBuilder: (context, index){
                final product = products[index];
                return ProductItemWidget(productModel: product);
              }
            ),
          );
        }
      })

          ],
        ),
      ),
    );
  }
}