import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/theme/theme_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/features/address/domain/models/address_model.dart';
import 'package:ride_sharing_user_app/features/set_destination/screens/set_destination_screen.dart';
import 'package:ride_sharing_user_app/util/styles.dart';


class AddressItemCard extends StatelessWidget {
  final Address address;
  const AddressItemCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
          Get.to(() => SetDestinationScreen(address: address));
      },
      child: Container(width: Get.width * 0.6,
        margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(
              color:Get.isDarkMode ?
              Theme.of(context).hintColor :
              Theme.of(context).primaryColor.withOpacity(0.4),width:0.5,
          ),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            address.addressLabel == 'home' ? Images.homeIcon :
            address.addressLabel == 'office' ? Images.workIcon : Images.otherIcon,
            color: Get.find<ThemeController>().darkTheme ?
            Theme.of(context).primaryColor :
            Theme.of(context).hintColor,
            height: 16,width: 16,
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(address.addressLabel!.tr,style: textBold),

              Text(address.address ?? '',style: textRegular,overflow: TextOverflow.ellipsis)
            ],
          )),

        ]),
      ),
    );
  }
}
