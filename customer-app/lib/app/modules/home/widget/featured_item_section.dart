import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../util/style.dart';
import '../../../../widget/item_card_grid.dart';
import '../controllers/home_controller.dart';

Widget featureditemSection() {
  return GetBuilder<HomeController>(
    builder: (homeController) => Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
          child: Row(
            children: [
              SizedBox(
                height: 24.h,
                child: Text(
                  "FEATURED_ITEMS".tr,
                  style: fontBold,
                ),
              ),
            ],
          ),
        ),
        MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          itemCount: homeController.featuredItemDataList.length > 4
              ? 4
              : homeController.featuredItemDataList.length,
          itemBuilder: (context, index) {
            return itemCardGrid(
                homeController.featuredItemDataList, index, context);
          },
        ),
      ],
    ),
  );
}
