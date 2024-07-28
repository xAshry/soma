import 'package:get/get.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/features/coupon/domain/models/coupon_model.dart';
import 'package:ride_sharing_user_app/features/coupon/domain/services/coupon_service_interface.dart';
import 'package:ride_sharing_user_app/features/ride/controllers/ride_controller.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';

class CouponController extends GetxController implements GetxService {
  final CouponServiceInterface couponServiceInterface;
  CouponController({required this.couponServiceInterface});

  bool isLoading = false;
  CouponModel? couponModel;

  Future<Response> getCouponList(int offset, {bool isUpdate = true}) async {
    isLoading = true;

    if(isUpdate) {
      update();
    }
    Response response = await couponServiceInterface.getList(offset : offset);

    if (response.statusCode == 200) {
      if(offset == 1){
        couponModel = CouponModel.fromJson(response.body);

      }else{
        couponModel?.data!.addAll(CouponModel.fromJson(response.body).data!);
        couponModel?.offset = CouponModel.fromJson(response.body).offset;
        couponModel?.totalSize = CouponModel.fromJson(response.body).totalSize;

      }

      isLoading = false;

    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }

    update();

    return response;
  }


  bool isApplying = false;
  Future<Response> applyCoupon(String couponCode, String tripId) async {
    isApplying = true;
    update();
    Response response = await couponServiceInterface.applyCoupon(couponCode, tripId);
    if (response.statusCode == 200) {
      await Get.find<RideController>().getFinalFare(tripId);
      isApplying = false;
      showCustomSnackBar('coupon_applied_successfully'.tr, isError: false);
    }else{
      isApplying = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  Future<Response> removeCoupon(String tripId) async {
    isApplying = true;
    update();
    Response response = await couponServiceInterface.removeCoupon(tripId);
    if (response.statusCode == 200) {
      await Get.find<RideController>().getFinalFare(tripId);
      isApplying = false;
      showCustomSnackBar('coupon_removed_successfully'.tr, isError: false);

    }else{
      isApplying = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  Future<Response> customerAppliedCoupon(String couponId, int index) async {
    couponModel!.data![index].isLoading = true;
    update();
    Response response = await couponServiceInterface.customerAppliedCoupon(couponId);
    if (response.statusCode == 200) {
      couponModel!.data![index].isLoading = false;
      showCustomSnackBar(couponModel!.data![index].isApplied! ? 'coupon_removed_successfully'.tr :
      'coupon_applied_successfully'.tr, isError:couponModel!.data![index].isApplied! ? true : false);
      getCouponList(1);
    }else{
      couponModel!.data![index].isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }
}