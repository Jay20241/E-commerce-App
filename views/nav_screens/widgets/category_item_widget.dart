import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multistoreapp/controllers/category_controller.dart';
import 'package:multistoreapp/provider/category_provider.dart';
import 'package:multistoreapp/views/details/inner_category_screen.dart';
import 'package:multistoreapp/views/nav_screens/widgets/reusable_text_widget.dart';

class CategoryWidget extends ConsumerStatefulWidget {
  const CategoryWidget({super.key});

  @override
  ConsumerState<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends ConsumerState<CategoryWidget> {

  //A future that will hold the list of categories once loaded from API.
  //late Future<List<CategoryModel>> futureCategories;
  @override
  void initState() {
    super.initState();
    //futureCategories = CategoryController().loadCategories();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async{
    final CategoryController categoryController = CategoryController();
    try {
      final categories  = await categoryController.loadCategories();
      ref.read(categoryProvider.notifier).setCategories(categories);
    } catch (e) {
      print("Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {

    final categories = ref.watch(categoryProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          ReusableTextWidget(title: 'Categories', subtitle: 'View all'),

          GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8), 
                  itemBuilder: (context,index){
                    final category = categories[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> InnerCategoryScreen(categoryModel: category)));
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Image.network(category.image, width: 50, height: 50),
                          Text(category.name,
                          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    );
                  })
          
        ],
      ),
    );
  }
}







//Using FutureBuilder, which is not preferable becoz it re-build the page every time we visit.
/**
 * @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          ReusableTextWidget(title: 'Categories', subtitle: 'View all'),
      
          FutureBuilder(
            future: futureCategories, 
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }else if(snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.error}'));
              }else if(!snapshot.hasData || snapshot.data!.isEmpty){
                return const Center(child: Text('No categories found'));
              }
              else{
                final List<CategoryModel> categories = snapshot.data!;
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8), 
                  itemBuilder: (context,index){
                    final category = categories[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> InnerCategoryScreen(categoryModel: category)));
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Image.network(category.image, width: 50, height: 50),
                          Text(category.name,
                          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    );
                  });
              }
            }),
        ],
      ),
    );
  }
 */