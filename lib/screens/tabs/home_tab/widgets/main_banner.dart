import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/home_banners_response.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';

class MainBannerHomePage extends StatelessWidget {
  final List<HomeBannerResponseData> bannerList;

  const MainBannerHomePage({required this.bannerList, super.key});

  @override
  Widget build(BuildContext context) {
    return BannerCarousel(
      height: 220,
      customizedBanners: _listOfBanners(bannerList),
      activeColor: const Color(0xff4CB6EA),
    );
  }

  List<Widget> _listOfBanners(List<HomeBannerResponseData> commingList) {
    List<Widget> list = [];
    for (var item in commingList) {
      list.add(_banner(obj: item));
    }
    return list;
  }

  Widget _banner({required HomeBannerResponseData obj}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Image.network(
        AppConstant.imagesBaseURLForBanners + obj.image!,
        fit: BoxFit.fill,
      ),
    );
  }
}
