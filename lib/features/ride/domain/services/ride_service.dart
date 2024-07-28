import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing_user_app/features/ride/domain/repositories/ride_repository_interface.dart';
import 'package:ride_sharing_user_app/features/ride/domain/services/ride_service_interface.dart';

class RideService implements RideServiceInterface{
  RideRepositoryInterface rideRepositoryInterface;

  RideService({required this.rideRepositoryInterface});


  @override
  Future arrivalPickupPoint(String tripId) async{
    return await rideRepositoryInterface.arrivalPickupPoint(tripId);
  }

  @override
  Future biddingList(String tripId, int offset) async{
    return await rideRepositoryInterface.biddingList(tripId, offset);
  }

  @override
  Future currentRideStatus() async{
    return await rideRepositoryInterface.currentRideStatus();
  }

  @override
  Future getDirection({required LatLng pickupLatLng, required LatLng destinationLatLng, required LatLng extraOneLatLng, required LatLng extraTwoLatLng}) async{
    return await rideRepositoryInterface.getDirection(pickupLatLng: pickupLatLng, destinationLatLng: destinationLatLng, extraOneLatLng: extraOneLatLng, extraTwoLatLng: extraTwoLatLng);
  }

  @override
  Future getDriverLocation(String tripId) async{
    return await rideRepositoryInterface.getDriverLocation(tripId);
  }

  @override
  Future getEstimatedFare({required LatLng pickupLatLng, required LatLng destinationLatLng, required LatLng currentLatLng, required String type, required String pickupAddress, required String destinationAddress, LatLng? extraOneLatLng = const LatLng(0, 0), LatLng? extraTwoLatLng = const LatLng(0, 0), bool extraOne = false, bool extraTwo = false, String? parcelWeight, String? parcelCategoryId})async {
    return await rideRepositoryInterface.getEstimatedFare(pickupLatLng: pickupLatLng, destinationLatLng: destinationLatLng, currentLatLng: currentLatLng, type: type, pickupAddress: pickupAddress, destinationAddress: destinationAddress,extraOneLatLng: extraOneLatLng,extraOne: extraOne,extraTwo: extraTwo,extraTwoLatLng: extraTwoLatLng);
  }

  @override
  Future getFinalFare(String id) async{
   return await rideRepositoryInterface.getFinalFare(id);
  }

  @override
  Future getRideDetails(String tripId) async{
    return await rideRepositoryInterface.getRideDetails(tripId);
  }

  @override
  Future ignoreBidding(String biddingId) async{
    return await rideRepositoryInterface.ignoreBidding(biddingId);
  }

  @override
  Future nearestDriverList(String lat, String lng) async{
    return await rideRepositoryInterface.nearestDriverList(lat, lng);
  }

  @override
  Future remainDistance(String requestID) async{
    return await rideRepositoryInterface.remainDistance(requestID);
  }


  @override
  Future submitRideRequest({required String pickupLat, required String pickupLng, required String destinationLat, required String destinationLng,
    required String customerCurrentLat, required String customerCurrentLng, required String vehicleCategoryId, required String estimatedDistance,
    required String estimatedTime, required String actualFare,required bool bid,
    required String estimatedFare, required String note, required String paymentMethod, required String type, required String pickupAddress, required String destinationAddress, required String encodedPolyline, required List<String> middleAddress, required String entrance, String? areaId, String extraLatOne = '', String extraLngOne = '', String extraLatTwo = '', String extraLngTwo = '', bool extraOne = false, bool extraTwo = false, String? senderName, String? senderPhone, String? senderAddress, String? receiverName, String? receiverPhone, String? receiverAddress, String? parcelCategoryId, String? weight, String? payer}) async{
    return await rideRepositoryInterface.submitRideRequest(pickupLat: pickupLat, pickupLng: pickupLng, destinationLat: destinationLat, bid: bid,
        destinationLng: destinationLng, customerCurrentLat: customerCurrentLat, customerCurrentLng: customerCurrentLng, actualFare: actualFare,
        vehicleCategoryId: vehicleCategoryId, estimatedDistance: estimatedDistance, estimatedTime: estimatedTime, estimatedFare: estimatedFare, note: note, paymentMethod: paymentMethod, type: type, pickupAddress: pickupAddress, destinationAddress: destinationAddress, encodedPolyline: encodedPolyline, middleAddress: middleAddress, entrance: entrance);
  }

  @override
  Future tripAcceptOrReject(String tripId, String type, String driverId) async{
    return await rideRepositoryInterface.tripAcceptOrReject(tripId, type, driverId);
  }

  @override
  Future tripStatusUpdate(String id, String status, String cancellationCause) async{
    return await rideRepositoryInterface.tripStatusUpdate(id, status, cancellationCause);
  }

}