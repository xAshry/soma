import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/common_widgets/image_widget.dart';
import 'package:ride_sharing_user_app/features/home/domain/models/categoty_model.dart';
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';
import 'package:ride_sharing_user_app/features/set_destination/screens/set_destination_screen.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/config_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  final bool? isSelected;
  final bool fromSelect;
  final int index;
  final Function (void)? onTap;
  const CategoryWidget({
    super.key, required this.category, this.isSelected,
    this.fromSelect = false, required this.index,this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<RideController>().setRideCategoryIndex(index);
        if(!fromSelect) {
          Get.to(() => const SetDestinationScreen());
        }else{
          return onTap!('');
        }
      },
      child: SizedBox(child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(height: isSelected != null ? 80 : 70, width: isSelected != null ? 90 : 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            color:  (isSelected != null && isSelected!) ? Theme.of(context).primaryColor.withOpacity(0.8)
                : Theme.of(context).hintColor.withOpacity(0.1),
          ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              child: category.id == '0' ?
              Image.asset(category.image??'') :
              ImageWidget(
                image: '${Get.find<ConfigController>().config?.imageBaseUrl?.vehicleCategory}/${category.image}',
                fit: BoxFit.contain,
              ),
            ),

            Image.asset(Images.offerIcon,height: 16,width: 16)
          ]),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        Text(
          category.name??'',
          style: textSemiBold.copyWith(
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
            fontSize: Dimensions.fontSizeSmall,
          ), maxLines: 1, overflow: TextOverflow.ellipsis,
        ),
      ])),
    );
  }
}