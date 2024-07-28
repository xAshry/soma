import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/features/map/screens/map_screen.dart';
import 'package:ride_sharing_user_app/features/parcel/domain/models/parcel_estimated_fare_model.dart';
import 'package:ride_sharing_user_app/features/payment/screens/payment_screen.dart';
import 'package:ride_sharing_user_app/features/ride/domain/models/bidding_model.dart';
import 'package:ride_sharing_user_app/features/ride/domain/models/estimated_fare_model.dart';
import 'package:ride_sharing_user_app/features/ride/domain/models/final_fare_model.dart';
import 'package:ride_sharing_user_app/features/ride/domain/models/nearest_driver_model.dart';
import 'package:ride_sharing_user_app/features/ride/domain/models/remaining_distance_model.dart';
import 'package:ride_sharing_user_app/features/ride/domain/models/trip_details_model.dart';
import 'package:ride_sharing_user_app/features/ride/domain/services/ride_service_interface.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/helper/pusher_helper.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:ride_sharing_user_app/features/home/controllers/category_controller.dart';
import 'package:ride_sharing_user_app/features/address/domain/models/address_model.dart';
import 'package:ride_sharing_user_app/features/location/controllers/location_controller.dart';
import 'package:ride_sharing_user_app/features/location/view/access_location_screen.dart';
import 'package:ride_sharing_user_app/features/map/controllers/map_controller.dart';
import 'package:ride_sharing_user_app/features/parcel/controllers/parcel_controller.dart';
import 'package:ride_sharing_user_app/features/payment/controllers/payment_controller.dart';



enum RideState{initial, riseFare, findingRider, acceptingRider, afterAcceptRider, otpSent, ongoingRide, completeRide}
enum RideType{car, bike, parcel, luxury}

class RideController extends GetxController implements GetxService {
  final RideServiceInterface rideServiceInterface;
  RideController({required this.rideServiceInterface});

  RideState currentRideState = RideState.initial;
  RideType selectedCategory = RideType.car;
  TripDetails? tripDetails;
  TripDetails? rideDetails;
  double currentFarePrice = 0;
  int rideCategoryIndex = 0;
  bool isLoading = false;
  String estimatedDistance = '0';
  String estimatedDuration = '0';
  double estimatedFare = 0;
  double actualFare = 0;
  List<FareModel> fareList = [];
  ParcelEstimatedFare? parcelEstimatedFare;
  String parcelFare = '0';
  String encodedPolyLine = '';
  bool loading = false;
  bool isEstimate = false;
  bool isSubmit = false;
  List<Nearest> nearestDriverList = [];
  FinalFare? finalFare;
  List<Bidding> biddingList = [];
  List<RemainingDistanceModel>? remainingDistanceModel = [];
  bool isCouponApplicable = false;
  double discountFare = 0;
  double discountAmount = 0;


  TripDetails? get currentTripDetails => tripDetails;

  TextEditingController inputFarePriceController = TextEditingController(text: '0.00');
  TextEditingController noteController = TextEditingController();

  void initData() {
    currentRideState = RideState.initial;
    isLoading = false;
    loading = false;
    encodedPolyLine = '';
  }


  void updateRideCurrentState(RideState newState) {
    currentRideState = newState;
    update();
  }

  void updateSelectedRideType(RideType newType){
    selectedCategory= newType;
    update();
  }




  Future<void> setBidingAmount(String balance) async{
    if(balance.isNotEmpty){
      actualFare = double.parse(balance);
      parcelFare = balance;
    }
    update();
  }

  String categoryName = '';
  String selectedCategoryId = '';
  FareModel? selectedType;
  void setRideCategoryIndex(int newIndex){
    rideCategoryIndex = newIndex;
    categoryName = Get.find<CategoryController>().categoryList![rideCategoryIndex].id!;


    if(fareList.isNotEmpty){
      for(int i = 0; i< fareList.length; i++){
        if(fareList[i].vehicleCategoryId == categoryName){
          selectedType =  fareList[i];
          break;
        }
      }

      estimatedDistance = selectedType!.estimatedDistance!;
      estimatedDuration = selectedType!.estimatedDuration!;
      selectedCategoryId = selectedType!.vehicleCategoryId!;
      estimatedFare = selectedType!.estimatedFare!;
      currentFarePrice = estimatedFare;
      actualFare = estimatedFare;
      isCouponApplicable = selectedType!.couponApplicable!;
      discountFare = selectedType!.discountFare!;
      discountAmount = selectedType!.discountAmount!;
    }

    update();
  }

  void resetControllerValue(){
    currentRideState = RideState.initial;
    selectedCategory = RideType.car;
    rideCategoryIndex = 0;
    update();
  }


  void clearRideDetails(){
    tripDetails = null;
    rideDetails = null;
    update();
  }


  @override
  onInit(){
    if(tripDetails != null && Get.find<AuthController>().getUserToken() != ''){
      startLocationRecord();
    }else{
      stopLocationRecord();
    }
    super.onInit();


  }



  Future<Response> getEstimatedFare(bool parcel) async {
    loading = true;
    isEstimate = true;
    update();
    parcelEstimatedFare = null;
    LocationController locController = Get.find<LocationController>();
    ParcelController parcelController = Get.find<ParcelController>();
    Address fromPosition = parcel ? locController.parcelSenderAddress! : locController.fromAddress!;
    Address toPosition = parcel ? locController.parcelReceiverAddress! : locController.toAddress!;

    Response? response = await rideServiceInterface.getEstimatedFare(
      pickupLatLng: LatLng(fromPosition.latitude!, fromPosition.longitude!),
      destinationLatLng: LatLng(toPosition.latitude!, toPosition.longitude!),
      currentLatLng: LatLng(locController.initialPosition.latitude, locController.initialPosition.longitude),
      type: parcel ? 'parcel' : 'ride_request',
      pickupAddress : parcel ? parcelController.senderAddressController.text
          : locController.fromAddress!.address.toString(),
      destinationAddress: parcel ? parcelController.receiverAddressController.text
          : locController.toAddress!.address!,
      extraOne: locController.extraOneRoute,
      extraTwo: locController.extraTwoRoute,
      extraOneLatLng: locController.extraRouteAddress != null ? LatLng(
        locController.extraRouteAddress!.latitude!, locController.extraRouteAddress!.longitude!,
      ) : null,
      extraTwoLatLng: locController.extraRouteTwoAddress != null ? LatLng(
        locController.extraRouteTwoAddress!.latitude!, locController.extraRouteTwoAddress!.longitude!,
      ) : null,
      parcelWeight: Get.find<ParcelController>().parcelWeightController.text,
      parcelCategoryId: parcel ? parcelController.parcelCategoryList![parcelController.selectedParcelCategory].id : '',
    );

    if(response!.statusCode == 200) {
      loading = false;
      isEstimate = false;
      /*locController.pickupLocationController.clear();
      locController.destinationLocationController.clear();
      locController.extraRouteOneController.clear();
      locController.extraRouteTwoController.clear();*/


      if(parcel) {
        parcelEstimatedFare = ParcelEstimatedFare.fromJson(response.body);
        encodedPolyLine = ParcelEstimatedFare.fromJson(response.body).data!.encodedPolyline!;
        parcelFare = ParcelEstimatedFare.fromJson(response.body).data!.estimatedFare!.toString();
      }else{
        fareList = [];
        fareList.addAll(EstimatedFareModel.fromJson(response.body).data!);
        setRideCategoryIndex(rideCategoryIndex != 0?  rideCategoryIndex : 0);
        encodedPolyLine = fareList[rideCategoryIndex].polyline!;
        if(encodedPolyLine != '' && encodedPolyLine.isNotEmpty) {
       //   Get.find<MapController>().getPolyline();

        }
      }
    }else{
      loading = false;
      isEstimate = false;
      ApiChecker.checkApi(response);
      if(response.statusCode == 403 && !parcel) {
        getCurrentRideStatus(navigateToMap: false);
      }
    }

    update();
    return response;
  }

  Future<Response> submitRideRequest(String note, bool parcel, {String categoryId = ''}) async {
    initCountingTimeStates();
    isSubmit = true;
    update();

    LocationController locController = Get.find<LocationController>();
    Address pickUpPosition = parcel ? locController.parcelSenderAddress! : locController.fromAddress!;
    Address destinationPosition = parcel ? locController.parcelReceiverAddress! : locController.toAddress!;

    Response response = await rideServiceInterface.submitRideRequest(
      pickupLat: pickUpPosition.latitude.toString(),
      pickupLng: pickUpPosition.longitude.toString(),
      destinationLat: destinationPosition.latitude.toString(),
      destinationLng: destinationPosition.longitude.toString(),
      customerCurrentLat: locController.initialPosition.latitude.toString(),
      customerCurrentLng: locController.initialPosition.longitude.toString(),
      type: parcel ? 'parcel' : 'ride_request',
      pickupAddress: parcel ? Get.find<ParcelController>().senderAddressController.text
          : locController.fromAddress!.address.toString(),
      destinationAddress: parcel ? Get.find<ParcelController>().receiverAddressController.text
          : locController.toAddress!.address!,
      vehicleCategoryId: parcel ? categoryId : selectedCategoryId,
      estimatedDistance: parcel ? parcelEstimatedFare!.data!.estimatedDistance!.toString() : estimatedDistance,
      estimatedTime: parcel ? parcelEstimatedFare!.data!.estimatedDuration!.replaceFirst('min', '') : estimatedDuration,
      estimatedFare: parcel ? parcelFare : estimatedFare.toString(),
      actualFare: parcel ? parcelFare : estimatedFare != actualFare ? actualFare.toString() : estimatedFare.toString(),
      bid:parcel ? false : estimatedFare != actualFare,
      note: note,
      paymentMethod: Get.find<PaymentController>().paymentTypeList[Get.find<PaymentController>().paymentTypeIndex],
      encodedPolyline: parcel ? encodedPolyLine : fareList[rideCategoryIndex].polyline!,
      middleAddress: [locController.extraRouteAddress?.address ?? '', locController.extraRouteTwoAddress?.address ?? ''],
      entrance: locController.entranceController.text.toString(),
      extraOne: locController.extraOneRoute,
      extraTwo: locController.extraTwoRoute,
      extraLatOne: locController.extraRouteAddress != null ? locController.extraRouteAddress!.latitude.toString() : '',
      extraLngOne: locController.extraRouteAddress != null ? locController.extraRouteAddress!.longitude.toString() : '',
      extraLatTwo: locController.extraRouteTwoAddress != null ? locController.extraRouteTwoAddress!.latitude.toString() : '',
      extraLngTwo: locController.extraRouteTwoAddress != null ? locController.extraRouteTwoAddress!.longitude.toString() : '',
      areaId: parcel ? '' : fareList[rideCategoryIndex].areaId ?? '',
      senderName: Get.find<ParcelController>().senderNameController.text,
      senderPhone: Get.find<ParcelController>().senderContactController.text,
      senderAddress: Get.find<ParcelController>().senderAddressController.text,
      receiverName: Get.find<ParcelController>().receiverNameController.text,
      receiverPhone: Get.find<ParcelController>().receiverContactController.text,
      receiverAddress: Get.find<ParcelController>().receiverAddressController.text,
      parcelCategoryId: parcel ? Get.find<ParcelController>().parcelCategoryList![Get.find<ParcelController>().selectedParcelCategory].id : '',
      payer: Get.find<ParcelController>().payReceiver?'receiver':"sender",
      weight: Get.find<ParcelController>().parcelWeightController.text,
    );

    if(response.statusCode == 200 && response.body['data'] != null) {
      biddingList = [];
      tripDetails = TripDetailsModel.fromJson(response.body).data!;
      tripDetails!.id = response.body['data']['id'];
      encodedPolyLine = tripDetails!.encodedPolyline!;
      if(encodedPolyLine != '' && encodedPolyLine.isNotEmpty) {

      //  Get.find<MapController>().getPolyline();

      }
      Get.find<ParcelController>().receiverNameController.clear();
      Get.find<ParcelController>().receiverContactController.clear();
      Get.find<ParcelController>().receiverAddressController.clear();
      Get.find<ParcelController>().parcelWeightController.clear();
      PusherHelper().pusherDriverStatus(response.body['data']['id']);
      isSubmit = false;
      noteController.clear();
    }else{
      isSubmit = false;
      ApiChecker.checkApi(response);
      if(response.statusCode == 403) {
        getCurrentRideStatus(navigateToMap: false);
      }
    }
    actualFare = 0;
    isLoading = false;
    update();

    return response;
  }

  void clearExtraRoute(){
    Get.find<LocationController>().extraOneRoute = false;
    Get.find<LocationController>().extraTwoRoute = false;
    Get.find<LocationController>().extraRouteAddress = null;
    Get.find<LocationController>().extraRouteTwoAddress = null;
  }

  Future<Response> getRideDetails(String tripId) async {
    isLoading = true;
    tripDetails = null;

    update();
    Response response = await rideServiceInterface.getRideDetails(tripId);
    if (response.statusCode == 200) {
      Get.find<MapController>().notifyMapController();
      tripDetails = TripDetailsModel.fromJson(response.body).data!;
      estimatedDistance = tripDetails!.estimatedDistance!.toString();
      isLoading = false;
      encodedPolyLine = tripDetails!.encodedPolyline!;
    }
    update();
    return response;
  }
  bool runningTrip = false;

  Future<Response> getCurrentRideStatus({bool fromRefresh = false, bool navigateToMap = true}) async {
    runningTrip = true;
    Response response = await rideServiceInterface.currentRideStatus();
    if (response.statusCode == 200 && response.body['data'] != null) {
      runningTrip = false;
      tripDetails = TripDetailsModel.fromJson(response.body).data!;
      estimatedDistance = tripDetails!.estimatedDistance!.toString();
      String currentRideStatus = tripDetails!.currentStatus!;
      encodedPolyLine = tripDetails!.encodedPolyline ?? '';
      if(encodedPolyLine.isNotEmpty) {
      //  Get.find<MapController>().getPolyline();
      }

      if(currentRideStatus == AppConstants.accepted || currentRideStatus == AppConstants.ongoing) {
        updateRideCurrentState(currentRideStatus == AppConstants.accepted ?  RideState.acceptingRider : RideState.ongoingRide );
        Get.find<MapController>().notifyMapController();
        if(navigateToMap) {
          Get.to(() => const MapScreen(fromScreen: MapScreenType.splash));
        }
      }
      else if(currentRideStatus == AppConstants.pending) {
        Get.find<RideController>().updateRideCurrentState(RideState.findingRider);
        Get.find<RideController>().getBiddingList(tripDetails!.id!, 1);
        Get.find<MapController>().notifyMapController();
        if(navigateToMap) {
          Get.to(() => const MapScreen(fromScreen: MapScreenType.splash));
        }
      } else if (currentRideStatus == AppConstants.completed || currentRideStatus == AppConstants.cancelled) {
        getFinalFare(tripDetails!.id!);
        Get.off(() => const PaymentScreen());
      }
      else{
        if(Get.find<LocationController>().getUserAddress() != null) {
          if(!fromRefresh) {
            Get.offAll(() => const DashboardScreen());
          }
        }else{
          Get.offAll(() => const AccessLocationScreen());
        }
      }
    } else {
      runningTrip = false;
      tripDetails = null;
      rideDetails = null;
      if(Get.find<LocationController>().getUserAddress() != null) {
        if(!fromRefresh) {
          Get.offAll(() => const DashboardScreen());
        }
      } else {
        Get.to(() =>  const AccessLocationScreen());
      }
    }
    update();
    return response;
  }


  Future<Response> getCurrentRide({bool fromRefresh = false, bool navigateToMap = true}) async {
    Response response = await rideServiceInterface.currentRideStatus();
    if (response.statusCode == 200 && response.body['data'] != null) {
      tripDetails = rideDetails = TripDetailsModel.fromJson(response.body).data!;
      estimatedDistance = rideDetails!.estimatedDistance!.toString();
      encodedPolyLine = rideDetails!.encodedPolyline ?? '';
    }else if(response.statusCode == 403){
      rideDetails = null;
    }
    update();
    return response;
  }


  Future<Response> remainingDistance(String requestID,{bool mapBound = false}) async {
    isLoading = true;
    Response response = await rideServiceInterface.remainDistance(requestID);
    if (response.statusCode == 200) {
      Get.find<MapController>().getDriverToPickupOrDestinationPolyline(response.body[0]["encoded_polyline"],mapBound: mapBound);
      remainingDistanceModel = [];
      for(var distance in response.body) {
        remainingDistanceModel!.add(RemainingDistanceModel.fromJson(distance));
      }

      if(Get.find<MapController>().isInside && tripDetails != null && currentRideState == RideState.acceptingRider) {
        currentRideState = RideState.otpSent;
      }
      if(Get.find<MapController>().isInside && Get.find<ParcelController>().currentParcelState == ParcelDeliveryState.acceptRider){
        Get.find<ParcelController>().updateParcelState(ParcelDeliveryState.otpSent);
      }
      arrivalPickupPoint(tripDetails!.id!);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  Future<Response> getBiddingList(String tripId, int offset) async {
    isLoading = true;

    Response response = await rideServiceInterface.biddingList(tripId, offset);
    if (response.statusCode == 200) {
      biddingList = [];
      biddingList.addAll(BiddingModel.fromJson(response.body).data!);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  Future<Response> ignoreBidding(String bidId,String tripId) async {
    isLoading = true;
    update();
    Response response = await rideServiceInterface.ignoreBidding(bidId);
    if (response.statusCode == 200) {
     getBiddingList(tripId, 1).then((value){
       if(biddingList.isEmpty){
         Get.back();
       }
     });
      isLoading = false;
    }else{
      getBiddingList(tripId, 1).then((value){
        if(biddingList.isEmpty){
          Get.back();
          Future.delayed(const Duration(milliseconds: 300)).then((value){
            ApiChecker.checkApi(response);
          });
        }
      });
      isLoading = false;
    }
    update();
    return response;
  }

  Future<Response> getNearestDriverList(String  lat, String lng) async {
    Response response = await rideServiceInterface.nearestDriverList(lat, lng);
    if (response.statusCode == 200) {
      nearestDriverList = [];
      nearestDriverList.addAll(NearestDriverModel.fromJson(response.body).data!);
      Get.find<MapController>().searchDeliveryMen();
    }else{
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  Timer? _timer;
  void startLocationRecord() {
    ///For First time call next call every 10 seconds.......
    if(Get.find<RideController>().tripDetails != null && Get.find<AuthController>().getUserToken() != ''){
      Get.find<RideController>().remainingDistance(Get.find<RideController>().tripDetails!.id!,mapBound: true);
    }else{
      _timer?.cancel();
    }
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if(Get.find<RideController>().tripDetails != null && Get.find<AuthController>().getUserToken() != '' && (Get.find<RideController>().tripDetails?.currentStatus == 'accepted' || Get.find<RideController>().tripDetails?.currentStatus == 'ongoing')){
        Get.find<RideController>().remainingDistance(Get.find<RideController>().tripDetails!.id!);
      }else{
        _timer?.cancel();
      }
    });
  }

  void stopLocationRecord() {
    _timer?.cancel();
  }

  Future<Response> tripAcceptOrRejected(String tripId, String type, String driverId) async {
    isLoading = true;
    update();
    Response response = await rideServiceInterface.tripAcceptOrReject(tripId, type, driverId);
    if (response.statusCode == 200) {
      biddingList = [];
      showCustomSnackBar('trip_is_accepted'.tr, isError: false);
      Get.back();
      getRideDetails(tripId).then((value) {
        if(value.statusCode == 200){
          remainingDistance(tripDetails!.id!,mapBound: true);
          updateRideCurrentState(RideState.otpSent);
          Get.find<MapController>().notifyMapController();
          Get.offAll(()=> const MapScreen(fromScreen: MapScreenType.ride));
        }
      });
      isLoading = false;
    }else{
      getBiddingList(tripId, 1).then((value){
        if(biddingList.isEmpty){
          Get.back();
          Future.delayed(const Duration(milliseconds: 300)).then((value){
            ApiChecker.checkApi(response);
          });
        }
      });
      isLoading = false;
    }
    update();
    return response;
  }

  void clearBiddingList(){
    biddingList = [];
    update();
}

  Future<Response> tripStatusUpdate(String tripId, String status, String message, String cancellationCause, {bool afterAccept = false}) async {
    isLoading = true;
    update();
    Response response = await rideServiceInterface.tripStatusUpdate(tripId, status, cancellationCause);
    if (response.statusCode == 200) {
      if(status == "cancelled" && !afterAccept){
        tripDetails = null;
      }
      showCustomSnackBar(message.tr, isError: false);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
    return response;
  }

  Future<Response> getFinalFare(String tripId) async {
    isLoading = true;
    update();
    Response response = await rideServiceInterface.getFinalFare(tripId);
    if (response.statusCode == 200 ) {
      if(response.body['data'] != null){
        finalFare = FinalFareModel.fromJson(response.body).data!;
      }
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();
    return response;
  }



  Future<Response> arrivalPickupPoint(String tripId) async {
    isLoading = true;
    Response response = await rideServiceInterface.arrivalPickupPoint(tripId);
    if (response.statusCode == 200) {

    }else {
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();
    return response;
  }

  String driverLat = '0';
  String driverLng = '0';
  Future<void> detDriverLocation(String tripId) async {
    Response response = await rideServiceInterface.arrivalPickupPoint(tripId);
    if (response.statusCode == 200) {
      driverLat = response.body['data']['latitude'];
      driverLng = response.body['data']['longitude'];
    }
    update();

  }


  double? firstCount = 0;
  double? secondCount = 0;
  double? thirdCount = 0;
  int stateCount = 0;


  void countingTimeStates() async{
    if(stateCount == 0){
      await Future.delayed(const Duration(seconds: 1)).then((value){
        firstCount = null;
        update();
      });
      await Future.delayed(const Duration(minutes: 1)).then((value){
        firstCount = 1;
        stateCount = 1;
      });
    }

    if(stateCount == 1){
      await Future.delayed(const Duration(milliseconds: 100)).then((value){
        secondCount = null;
        update();
      });
      await Future.delayed(const Duration(minutes: 1)).then((value){
        secondCount = 1;
        stateCount = 2;
      });
    }

    if(stateCount == 2){
      await  Future.delayed(const Duration(milliseconds: 100)).then((value){
        thirdCount = null;
        update();
      });
      await Future.delayed(const Duration(minutes: 3)).then((value){
        thirdCount = 1;
        stateCount = 3;
        update();
      });
    }

    if(stateCount == 3){
      update();
    }

  }


  void initCountingTimeStates({bool isRestart = false}){
    if(isRestart){
      if(stateCount == 3){
        firstCount = 0;
        secondCount = 0;
        thirdCount = 0;
        stateCount = 0;
      }
      countingTimeStates();
    }else{
      firstCount = 0;
      secondCount = 0;
      thirdCount = 0;
      stateCount = 0;
    }
  }

  void resumeCountingTimeState(int duration){
     if(duration < 60){
       secondCount =0;
       thirdCount = 0;
       stateCount = 0;

     }else if(duration >60 && duration < 120){
       firstCount =1;
       thirdCount = 0;
       stateCount = 1;
     }else if (duration >120 && duration < 300){
       firstCount =1;
       secondCount = 1;
       stateCount = 2;

     }else{
       firstCount =1;
       secondCount = 1;
       thirdCount =1;
       stateCount = 3;

     }
     countingTimeStates();
  }
}