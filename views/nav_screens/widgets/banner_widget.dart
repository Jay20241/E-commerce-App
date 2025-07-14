import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/controllers/banner_controller.dart';
//import 'package:multistoreapp/models/banner_model.dart';
import 'package:multistoreapp/provider/banner_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends ConsumerStatefulWidget {
  const BannerWidget({super.key});

  @override
  ConsumerState<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerWidget> {

  //late Future<List<BannerModel>> futureBanners;
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    //futureBanners = BannerController().loadBanners();
    _fetchBanners();
  }

  Future<void> _fetchBanners() async{
    final BannerController bannerController = BannerController();
    try {
      final banners = await bannerController.loadBanners();
      ref.read(bannerProvider.notifier).setBanner(banners);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(bannerProvider);
    return 
      Container(
        width: MediaQuery.of(context).size.width,
        
        decoration: BoxDecoration(
        
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
            children: [
              SizedBox(
                
                child: Image.asset('assets/ss2.png'),
              ),

                

                SmoothPageIndicator(
                  controller: _controller,
                  count: 5,
                  effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 8,
                    activeDotColor: Colors.blue, // Customize
                    dotColor: Colors.grey.shade400,
                  ),
                ),

            ],
          ),
      );
  }
}

/**
 * GridView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, crossAxisSpacing: 8, mainAxisSpacing: 4),
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: banners.length,
                  itemBuilder: (context,index){
                    final banner = banners[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(banner.image)),
                    );
                  })
 */