import 'package:carousel_slider/carousel_controller.dart';
import 'package:e_commerce/data/repository/banner/banner_repository.dart';
import 'package:e_commerce/features/shopping/models/banners_model.dart';
import 'package:e_commerce/utils/popups/snackbar_helpers.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{
  static  BannerController get instance => Get.find();

  // variables
  final _repository= Get.put(BannerRepository());
  RxList<BannerModel> banners=<BannerModel>[].obs;
  RxBool isBannerLoading =false.obs;

  final carouselController =CarouselSliderController();
  RxInt currentIndex=0.obs;

  @override
  void onInit() {

    fetchBanner();

    super.onInit();
  }

  void onPageChanged(int index){
    currentIndex.value=index;
  }

  // function for Fetch all Active Banner
   Future<void> fetchBanner()async{
   try{
     // st loading
     isBannerLoading.value= true;
    List<BannerModel> activeBanners=await _repository.fetchActiveBanner();
    banners.assignAll(activeBanners);

   }catch (e){
     USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
   }finally{
     //stop loading
     isBannerLoading.value=false;
   }
 }



}