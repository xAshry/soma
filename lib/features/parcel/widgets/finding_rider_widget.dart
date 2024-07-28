import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/common_widgets/button_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/expandable_bottom_sheet.dar.dart';
import 'package:ride_sharing_user_app/common_widgets/swipable_button_widget/slider_button_widget.dart';
import 'package:ride_sharing_user_app/features/parcel/widgets/tolltip_widget.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/features/dashboard/controllers/bottom_menu_controller.dart';
import 'package:ride_sharing_user_app/features/map/controllers/map_controller.dart';
import 'package:ride_sharing_user_app/features/parcel/controllers/parcel_controller.dart';
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';

enum FindingRide{ride, parcel}

class FindingRiderWidget extends StatefulWidget {
  final FindingRide fromPage;
  final GlobalKey<ExpandableBottomSheetState> expandableKey;
  const FindingRiderWidget({super.key, required this.fromPage, required this.expandableKey});

  @override
  State<FindingRiderWidget> createState() => _FindingRiderWidgetState();
}

class _FindingRiderWidgetState extends State<FindingRiderWidget> {

  bool isSearching = true;

  @override
  void initState() {
    Get.find<RideController>().countingTimeStates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController){
      return GetBuilder<ParcelController>(builder: (parcelController){
        return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: isSearching ?
          Column(children: [
            TollTipWidget(
              title: rideController.selectedCategory == RideType.parcel ?
              'deliveryman' : 'rider_finding',
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(width: MediaQuery.of(context).size.width *0.27,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey.withOpacity(.50),
                    color: Theme.of(context).primaryColor,value: rideController.firstCount,
                  ),
              ),

              SizedBox(width: MediaQuery.of(context).size.width *0.27,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey.withOpacity(.50),
                    color: Theme.of(context).primaryColor,value: rideController.secondCount,
                  ),
              ),

              SizedBox(width: MediaQuery.of(context).size.width *0.27,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey.withOpacity(.50),
                    color: Theme.of(context).primaryColor,value: rideController.thirdCount,
                  ),
              ),
            ]),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge),
              child: Image.asset(Images.findRiderIcon, width: 70),
            ),

            Text(
                rideController.selectedCategory == RideType.parcel ?
                'finding_deliveryman'.tr :
                rideController.stateCount  == 0 ?
                'searching_for_rider'.tr :
                rideController.stateCount == 1 ?
                'please_wait_just_for_a_moment'.tr :
                'looks_like_riders_around_you_are_busy_now'.tr,
              style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
            ),

            rideController.stateCount  == 2 ?
            Text('please_hold_on_a_little_more'.tr,
              style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
            ):
            const SizedBox(),
            const SizedBox(height: Dimensions.paddingSizeLarge * 2),

            Center(child: SliderButton(
                action: (){
                  isSearching = false;
                  setState(() {});

                },
                label: Text(
                  'cancel_searching'.tr,style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                dismissThresholds: 0.5, dismissible: false, shimmer: false,
                width: 1170, height: 40, buttonSize: 40, radius: 20,
                icon: Center(child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).cardColor),
                  child: Center(child: Icon(
                      Get.find<LocalizationController>().isLtr ?
                      Icons.arrow_forward_ios_rounded :
                      Icons.keyboard_arrow_left,
                      color: Colors.grey, size: 20.0,
                    )),
                )),
                isLtr: Get.find<LocalizationController>().isLtr,
                boxShadow: const BoxShadow(blurRadius: 0),
                buttonColor: Colors.transparent,
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
                baseColor: Theme.of(context).primaryColor,
              )),
          ]) :
          Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
              child: Image.asset(Images.cancelRideIcon, width: 70),
            ),

            Text('are_you_sure'.tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),

            Text('you_want_to_cancel_searching'.tr, style: textMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).hintColor,
            )),

            rideController.isLoading ?
            const Padding(
              padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: CircularProgressIndicator(),
            ) :
            Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical:Dimensions.paddingSizeDefault,
                  horizontal:Dimensions.paddingSizeExtraOverLarge,
                ),
                child: ButtonWidget(
                  buttonText: 'keep_searching'.tr,
                  onPressed: (){
                    isSearching = true;
                    setState(() {});
                    rideController.initCountingTimeStates(isRestart: true);
                  },
                  backgroundColor: Colors.grey.withOpacity(0.25),
                  radius: 10,
                  textColor: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.paddingSizeExtraOverLarge ,
                  right: Dimensions.paddingSizeExtraOverLarge ,
                  bottom: Dimensions.paddingSizeDefault,
                ),
                child: ButtonWidget(
                  buttonText: 'cancel_searching'.tr,
                  onPressed: (){
                    widget.expandableKey.currentState?.contract();

                    rideController.tripStatusUpdate(
                        rideController.tripDetails!.id!,'cancelled',
                        'ride_request_cancelled_successfully','',
                    ).then((value){
                      if(value.statusCode == 200){
                        rideController.updateRideCurrentState(RideState.initial);
                        Get.find<MapController>().notifyMapController();
                        Get.find<RideController>().clearRideDetails();
                        Get.find<BottomMenuController>().navigateToDashboard();

                      }
                    });

                  },
                  radius: 10,
                ),
              ),

            ]),

            if(rideController.isLoading)
              const SizedBox(height: Dimensions.paddingSizeSignUp),

          ]),
        );
      });
    });
  }

}
