class TripDetailsModel {
  TripDetails? data;

  TripDetailsModel(
      {
        this.data,
      });

  TripDetailsModel.fromJson(Map<String, dynamic> json) {

    data = json['data'] != null ? TripDetails.fromJson(json['data']) : null;

  }

}

class TripDetails {
  String? id;
  String? refId;
  Driver? driver;
  Vehicle? vehicle;
  VehicleCategory? vehicleCategory;
  double? estimatedFare;
  String? orgEstFare;
  String? estimatedTime;
  double? estimatedDistance;
  double? actualFare;
  double? discountActualFare;
  String? actualTime;
  String? actualDistance;
  String? waitingTime;
  String? idleTime;
  String? waitingFare;
  double? idleFee;
  double? delayFee;
  double? cancellationFee;
  double? distanceWiseFare;
  String? cancelledBy;
  double? vatTax;
  double? tips;
  String? additionalCharge;
  PickupCoordinates? pickupCoordinates;
  String? pickupAddress;
  PickupCoordinates? destinationCoordinates;
  String? destinationAddress;
  PickupCoordinates? customerRequestCoordinates;
  String? paymentMethod;
  double? couponAmount;
  double? discountAmount;
  String? note;
  String? totalFare;
  String? otp;
  int? riseRequestCount;
  String? type;
  String? createdAt;
  String? entrance;
  String? intermediateAddresses;
  String? encodedPolyline;
  String? customerAvgRating;
  String? driverAvgRating;
  String? currentStatus;
  double? paidFare;
  bool? isPaused;
  ParcelInformation? parcelInformation;
  String? paymentStatus;
  bool? isLoading;
  bool? isReviewed;

  TripDetails(
      {this.id,
        this.refId,
        this.driver,
        this.vehicle,
        this.vehicleCategory,
        this.estimatedFare,
        this.orgEstFare,
        this.estimatedTime,
        this.estimatedDistance,
        this.actualFare,
        this.actualTime,
        this.actualDistance,
        this.waitingTime,
        this.idleTime,
        this.waitingFare,
        this.idleFee,
        this.delayFee,
        this.cancellationFee,
        this.distanceWiseFare,
        this.cancelledBy,
        this.vatTax,
        this.tips,
        this.additionalCharge,
        this.pickupCoordinates,
        this.pickupAddress,
        this.destinationCoordinates,
        this.destinationAddress,
        this.customerRequestCoordinates,
        this.paymentMethod,
        this.couponAmount,
        this.discountAmount,
        this.discountActualFare,
        this.note,
        this.totalFare,
        this.otp,
        this.riseRequestCount,
        this.type,
        this.createdAt,
        this.entrance,
        this.intermediateAddresses,
        this.encodedPolyline,
        this.customerAvgRating,
        this.driverAvgRating,
        this.currentStatus,
        this.paidFare,
        this.isPaused,
        this.parcelInformation,
        this.paymentStatus,
        this.isLoading,
        this.isReviewed
      });

  TripDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'].toString();
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    vehicle = json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
    vehicleCategory = json['vehicle_category'] != null ? VehicleCategory.fromJson(json['vehicle_category']) : null;
    estimatedFare = json['estimated_fare'] != null ? double.parse(json['estimated_fare'].toString()) : 0;
    orgEstFare = json['org_est_fare'].toString();
    estimatedTime = json['estimated_time'].toString();
    estimatedDistance = json['estimated_distance'].toDouble();
    actualFare = json['actual_fare'].toDouble();
    discountActualFare = json['discount_actual_fare'].toDouble();
    actualTime = json['actual_time'].toString();
    actualDistance = json['actual_distance'].toString();
    waitingTime = json['waiting_time'].toString();
    idleTime = json['idle_time'].toString();
    waitingFare = json['waiting_fare'].toString();
    if(json['idle_fee'] != null){
      idleFee = json['idle_fee'].toDouble();
    }
    if(json['delay_fee'] != null){
      delayFee = json['delay_fee'].toDouble();
    }
    if(json['cancellation_fee'] != null){
      cancellationFee = json['cancellation_fee'].toDouble();
    }
    if(json['distance_wise_fare'] != null){
      distanceWiseFare = json['distance_wise_fare'].toDouble();
    }

    cancelledBy = json['cancelled_by'];
    if(json['vat_tax'] != null){
      vatTax = json['vat_tax'].toDouble();
    }

    if(json['tips'] != null){
      tips = json['tips'].toDouble();
    }
    additionalCharge = json['additional_charge'].toString();
    pickupCoordinates = json['pickup_coordinates'] != null ? PickupCoordinates.fromJson(json['pickup_coordinates']) : null;
    pickupAddress = json['pickup_address'];
    destinationCoordinates = json['destination_coordinates'] != null ? PickupCoordinates.fromJson(json['destination_coordinates']) : null;
    destinationAddress = json['destination_address'];
    customerRequestCoordinates = json['customer_request_coordinates'] != null ? PickupCoordinates.fromJson(json['customer_request_coordinates']) : null;

    paymentMethod = json['payment_method'];
    if(json['coupon_amount'] != null){
      try{
        couponAmount = json['coupon_amount'].toDouble();
      }catch(e){
        couponAmount = double.parse(json['coupon_amount'].toString());
      }
    }

    discountAmount = double.tryParse(json['discount_amount'].toString());
    note = json['note'];
    totalFare = json['total_fare'].toString();
    otp = json['otp'];
    riseRequestCount = json['rise_request_count'];
    type = json['type'];
    createdAt = json['created_at'];
    entrance = json['entrance'];
    intermediateAddresses = json['intermediate_addresses'];
    encodedPolyline = json['encoded_polyline'];
    customerAvgRating = json['customer_avg_rating'];
    driverAvgRating = json['driver_avg_rating'];
    currentStatus = json['current_status'];
    if(json['paid_fare'] != null){
      try{
        paidFare = json['paid_fare'].toDouble();
      }catch(e){
        paidFare = double.parse(json['paid_fare'].toString());
      }
    }

    isPaused = json['is_paused'];
    parcelInformation = json['parcel_information'] != null ? ParcelInformation.fromJson(json['parcel_information']) : null;
    paymentStatus = json['payment_status'];
    isLoading = false;
    isReviewed = json['driver_review'];
  }

}

class Driver {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationNumber;
  String? identificationType;
  String? profileImage;
  Vehicle? vehicle;

  Driver(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.identificationNumber,
        this.identificationType,
        this.profileImage,
        this.vehicle
     });

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];
    profileImage = json['profile_image'];
    vehicle = json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;


  }

}

class Vehicle {
  Model? model;
  String? licencePlateNumber;
  String? licenceExpireDate;
  String? vinNumber;
  String? transmission;
  String? fuelType;
  String? ownership;
  List<String>? documents;
  int? isActive;
  String? createdAt;

  Vehicle(
      {this.model,
        this.licencePlateNumber,
        this.licenceExpireDate,
        this.vinNumber,
        this.transmission,
        this.fuelType,
        this.ownership,
        this.documents,
        this.isActive,
        this.createdAt});

  Vehicle.fromJson(Map<String, dynamic> json) {
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    licencePlateNumber = json['licence_plate_number'];
    licenceExpireDate = json['licence_expire_date'];
    vinNumber = json['vin_number'];
    transmission = json['transmission'];
    fuelType = json['fuel_type'];
    ownership = json['ownership'];
    documents = json['documents'].cast<String>();
    isActive = json['is_active'] ? 1 : 0;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (model != null) {
      data['model'] = model!.toJson();
    }
    data['licence_plate_number'] = licencePlateNumber;
    data['licence_expire_date'] = licenceExpireDate;
    data['vin_number'] = vinNumber;
    data['transmission'] = transmission;
    data['fuel_type'] = fuelType;
    data['ownership'] = ownership;
    data['documents'] = documents;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}

class Model {
  String? id;
  String? name;
  int? seatCapacity;
  int? maximumWeight;
  int? hatchBagCapacity;
  String? engine;
  String? description;
  String? image;
  int? isActive;
  String? createdAt;

  Model(
      {this.id,
        this.name,
        this.seatCapacity,
        this.maximumWeight,
        this.hatchBagCapacity,
        this.engine,
        this.description,
        this.image,
        this.isActive,
        this.createdAt});

  Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    seatCapacity = json['seat_capacity'];
    maximumWeight = json['maximum_weight'];
    hatchBagCapacity = json['hatch_bag_capacity'];
    engine = json['engine'];
    description = json['description'];
    image = json['image'];
    isActive = json['is_active'] ? 1 : 0;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['seat_capacity'] = seatCapacity;
    data['maximum_weight'] = maximumWeight;
    data['hatch_bag_capacity'] = hatchBagCapacity;
    data['engine'] = engine;
    data['description'] = description;
    data['image'] = image;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}

class PickupCoordinates {
  String? type;
  List<double>? coordinates;

  PickupCoordinates({this.type, this.coordinates});

  PickupCoordinates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class ParcelInformation {
  String? parcelCategoryId;
  String? payer;
  double? weight;

  ParcelInformation({this.parcelCategoryId, this.payer, this.weight});

  ParcelInformation.fromJson(Map<String, dynamic> json) {
    parcelCategoryId = json['parcel_category_id'];
    payer = json['payer'];
    weight = json['weight'].toDouble();
  }

}

class VehicleCategory {
  String? id;
  String? name;
  String? image;
  String? type;

  VehicleCategory({this.id, this.name, this.image, this.type});

  VehicleCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }
}

