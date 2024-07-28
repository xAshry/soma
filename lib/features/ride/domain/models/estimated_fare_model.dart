class EstimatedFareModel {
  String? responseCode;
  String? message;
  List<FareModel>? data;


  EstimatedFareModel(
      {this.responseCode,
        this.message,
        this.data,
       });

  EstimatedFareModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FareModel>[];
      json['data'].forEach((v) {
        data!.add(FareModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class FareModel {
  String? id;
  String? zoneId;
  String? vehicleCategoryId;
  String? vehicleCategoryType;
  double? baseFare;
  double? baseFarePerKm;
  double? fare;
  String? estimatedDistance;
  String? estimatedDuration;
  double? estimatedFare;
  double? discountFare;
  double? discountAmount;
  bool?   couponApplicable;
  String? requestType;
  String? polyline;
  String? areaId;


  FareModel(
      {this.id,
        this.zoneId,
        this.vehicleCategoryId,
        this.vehicleCategoryType,
        this.baseFare,
        this.baseFarePerKm,
        this.fare,
        this.estimatedDistance,
        this.estimatedDuration,
        this.estimatedFare,
        this.requestType,
        this.polyline,
        this.areaId,
        this.discountAmount,
        this.couponApplicable,
        this.discountFare
      });

  FareModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zoneId = json['zone_id'];
    vehicleCategoryId = json['vehicle_category_id'];
    vehicleCategoryType = json['vehicle_category_type'];
    baseFare = json['base_fare'].toDouble();
    baseFarePerKm = json['base_fare_per_km'].toDouble();
    fare = json['fare'].toDouble();
    estimatedDistance = json['estimated_distance'].toString();
    estimatedDuration = json['estimated_duration'].toString();
    estimatedFare = json['estimated_fare'].toDouble();
    requestType = json['request type'];
    polyline = json['encoded_polyline'];
    areaId = json['area_id'];
    discountAmount = json['discount_amount'].toDouble();
    couponApplicable = json['coupon_applicable'];
    discountFare = json['discount_fare'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['zone_id'] = zoneId;
    data['vehicle_category_id'] = vehicleCategoryId;
    data['base_fare'] = baseFare;
    data['base_fare_per_km'] = baseFarePerKm;
    data['fare'] = fare;
    data['estimated_distance'] = estimatedDistance;
    data['estimated_duration'] = estimatedDuration;
    data['estimated_fare'] = estimatedFare;
    data['request type'] = requestType;
    data['encoded_polyline'] = polyline;
    data['area_id'] = areaId;
    return data;
  }
}
