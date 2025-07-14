import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multistoreapp/models/banner_model.dart';

class BannerProvider extends StateNotifier<List<BannerModel>>{
  BannerProvider() : super([]); //Initialize with an empty list.

  void setBanner(List<BannerModel> banners){
    state = banners;
  }
}


final bannerProvider = StateNotifierProvider<BannerProvider, List<BannerModel>>((ref)=>BannerProvider());