import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multistoreapp/controllers/category_controller.dart';
import 'package:multistoreapp/controllers/subcategory_controller.dart';
import 'package:multistoreapp/models/category_model.dart';
import 'package:multistoreapp/provider/category_provider.dart';
import 'package:multistoreapp/provider/subcategory_provider.dart';
import 'package:multistoreapp/views/details/subcategory_product_screen.dart';
import 'package:multistoreapp/views/nav_screens/widgets/header_widget.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {

  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }
  

  Future<void> _fetchCategories() async{
    final categories = await CategoryController().loadCategories();
    ref.read(categoryProvider.notifier).setCategories(categories);
    for (var category in categories) {
        if (category.name == "fashion") {
          setState(() {
            _selectedCategory = category;
          });
          _loadSubcategories(category.name);
        }
      }
  }

  Future<void> _loadSubcategories(String categoryName) async{
    final subcategories = await SubcategoryController().getSubCategoriesByCategoryName(categoryName);
    ref.read(subcategoryProvider.notifier).setSubcategories(subcategories);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final subCategories = ref.watch(subcategoryProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 20), 
        child: HeaderWidget()
      ),

      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //left side
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade200,
              child: ListView.builder(
                
                itemCount: categories.length, 
                itemBuilder: (context,index){
                  final category = categories[index];
                  return ListTile(
                    onTap: (){
                      setState(() {
                        _selectedCategory = category;
                      });

                      _loadSubcategories(category.name);
                    },
                    title: Text(category.name, style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold, 
                      fontSize: 15,
                      color: _selectedCategory==category ? Colors.blue : Colors.black)),
                  );
                  })
            )),


            //Right Side
            Expanded(
              flex: 5,
              child: _selectedCategory!=null ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_selectedCategory!.name, 
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold, 
                        fontSize: 16,
                        letterSpacing: 1.7)),
                    ),
                
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(_selectedCategory!.banner),fit: BoxFit.cover)
                      ),
                    ),
                
                    subCategories.isNotEmpty ? GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 4, childAspectRatio: 2/3), 
                      itemBuilder: (context, index){
                        final subcategory = subCategories[index];
                
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context) {
                                return SubcategoryProductScreen(subcategoryModel: subcategory);
                              }));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200
                                ),
                                child: Center(child: Image.network(subcategory.image, fit: BoxFit.cover)),
                              ),
                              Center(child: Text(subcategory.subCategoryName))
                            ],
                          ),
                        );
                
                      }) : Center(child: Text('No Subcategory Available'))
                  ],
                ),
              ):Container())
        ],
      ),
    );
  }
}



/**
 * 
 * 
 * 
 * late Future<List<CategoryModel>> futureCategories;

  List<SubcategoryModel> _subCategories = [];
  final SubcategoryController _subcategoryController = SubcategoryController();
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();

    //Default selecting for first time visit.
    //once the categories are loaded, process then
    futureCategories.then((categories){
      for (var category in categories) {
        if (category.name == "fashion") {
          setState(() {
            _selectedCategory = category;
          });
          _loadSubcategories(category.name);
        }
      }
    });

  }

  Future<void> _loadSubcategories(String categoryName) async{
    final subcategories = await _subcategoryController.getSubCategoriesByCategoryName(categoryName);
    setState(() {
      _subCategories = subcategories;
    });
  }
 
 @override
 build()


 */