import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/common_widgets/category_widget.dart';
import 'package:ride_sharing_user_app/features/home/controllers/category_controller.dart';
import 'package:ride_sharing_user_app/features/home/widgets/category_shimmer.dart';
import 'package:ride_sharing_user_app/features/parcel/screens/parcel_screen.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (categoryController){
      return SizedBox(height: 105, width: Get.width,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            categoryController.categoryList != null ? categoryController.categoryList!.isNotEmpty ?
            ListView.builder(
              shrinkWrap: true,
              itemCount: categoryController.categoryList!.length,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CategoryWidget(index: index,
                  category: categoryController.categoryList![index]);
              }
            ) : const SizedBox(): const CategoryShimmer(),

            Padding(padding: const EdgeInsets.only(right: 5.0),
              child: InkWell(onTap: () => Get.to(() =>  const ParcelScreen()),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).hintColor.withOpacity(.15)), width: 75, height: 70,
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: Image.asset(Images.parcel))),
                  Text('parcel'.tr, style: textSemiBold.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8),
                    fontSize: Dimensions.fontSizeSmall)),
                ]),
              ),
            ),
          ],
        ),
      );
    });
  }
}
