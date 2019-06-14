import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperWidget extends StatelessWidget {
  int itemCount = 0;
  IndexedWidgetBuilder itemBuilder;
  double height = 150;
  Widget defaultChild = null;
  bool autoplay;

//  SwiperPagination pagination;
  SwiperController controller;
  bool loop;
  int paginationType;
  int index;
  ValueChanged<int> change;

  SwiperWidget(
      {this.height,
      this.index = 0,
      this.itemCount,
      this.itemBuilder,
      this.defaultChild,
      this.loop = true,
      this.change,
      this.autoplay = true,
      this.paginationType = 1,
      this.controller}) {
//    this.pagination = this.pagination ?? new SwiperPagination();
  }

  @override
  Widget build(BuildContext context) {
    if (itemCount <= 0)
      return defaultChild ??
          new Container(
            height: height,
          );
    var pagination = null;
    switch (this.paginationType) {
      case 1:
        pagination = new SwiperPagination();
        break;
      case 2:
        pagination = new DotSwiperPaginationBuilder();
        break;
      case 3:
        pagination = new RectSwiperPaginationBuilder();
        break;
      case 4:
        pagination = new FractionPaginationBuilder();
        break;
    }
    Swiper swiper = new Swiper(
        itemBuilder: (BuildContext context, int index) {
          if (itemCount <= 0)
            return defaultChild == null ? Center() : defaultChild;
          return itemBuilder(context, index);
        },
        index: index,
        loop: loop,
        controller: controller,
        autoplay: autoplay,
        onIndexChanged: change,
        itemCount: itemCount <= 0 ? 1 : itemCount,
        pagination: pagination);
    return new Container(
      height: height,
      child: swiper,
    );
  }
}
