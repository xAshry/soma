import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class RideServiceInterface{
  Future<dynamic> getEstimatedFare(
      {required LatLng pickupLatLng,
        required LatLng destinationLatLng,
        required LatLng currentLatLng,
        required String type,
        required String pickupAddress,
        required String destinationAddress,
        LatLng? extraOneLatLng = const LatLng(0, 0),
        LatLng? extraTwoLatLng = const LatLng(0, 0),
        bool extraOne = false, bool extraTwo = false,
        String? parcelWeight,
        String? parcelCategoryId,
      });


  Future<dynamic> submitRideRequest(
      {required String pickupLat,
        required String pickupLng,
        required String destinationLat,
        required String destinationLng,
        required String customerCurrentLat,
        required String customerCurrentLng,
        required String vehicleCategoryId,
        required String estimatedDistance,
        required String estimatedTime,
        required String estimatedFare,
        required String actualFare,
        required String note,
        required bool bid,
        required String paymentMethod,
        required String type,
        required String pickupAddress,
        required String destinationAddress,
        required String encodedPolyline,
        required List<String> middleAddress,
        required String entrance,
        String? areaId,
        String extraLatOne = '',
        String extraLngOne = '',
        String extraLatTwo = '',
        String extraLngTwo = '',
        bool extraOne = false,
        bool extraTwo = false,
        String? senderName,
        String? senderPhone,
        String? senderAddress,
        String? receiverName,
        String? receiverPhone,
        String? receiverAddress,
        String? parcelCategoryId,
        String? weight,
        String? payer,
      });

  Future<dynamic> getRideDetails(String tripId);
  Future<dynamic> tripStatusUpdate(String id, String status,String cancellationCause);
  Future<dynamic> remainDistance(String requestID);
  Future<dynamic> biddingList(String tripId, int offset);
  Future<dynamic> nearestDriverList(String  lat, String lng);
  Future<dynamic> tripAcceptOrReject(String tripId, String type, String driverId);
  Future<dynamic> ignoreBidding(String biddingId);
  Future<dynamic> currentRideStatus();
  Future<dynamic> getFinalFare(String id);
  Future<dynamic> arrivalPickupPoint(String tripId);
  Future<dynamic> getDriverLocation(String tripId);
  Future<dynamic> getDirection({required LatLng pickupLatLng, required LatLng destinationLatLng, required LatLng extraOneLatLng, required LatLng extraTwoLatLng});

}