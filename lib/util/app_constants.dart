import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/features/onboard/domain/models/on_boarding_model.dart';
import 'package:ride_sharing_user_app/localization/language_model.dart';
import 'package:ride_sharing_user_app/util/images.dart';

class AppConstants {
  static const String appName = 'AshryUP';
  static const String baseUrl = 'https://taxi.ashryup.com';
  static const String appVersion = '1.0';
  static const Color lightPrimary = Color(0xFF14B19E);
  static const Color darkPrimary = Color(0xFF00735f);
  static const String fontFamily = 'SFProText';
  static const double coverageRadiusInMeter = 50;
  static const String configUri = '/api/customer/configuration';
  static const String registration = '/api/customer/auth/registration';
  static const String loginUri = '/api/customer/auth/login';
  static const String logOutUri = '/api/user/logout';
  static const String deleteAccount = '/api/user/delete';
  static const String sendOTP = '/api/customer/auth/send-otp';
  static const String otpVerification = '/api/customer/auth/otp-verification';
  static const String otpLogin = '/api/customer/auth/otp-login';
  static const String resetPassword = '/api/customer/auth/reset-password';
  static const String changePassword = '/api/user/change-password';
  static const String forgetPassword = '/api/customer/auth/forget-password';
  static const String socialLogin = '/api/customer/auth/social-login';
  static const String profileInfo = '/api/customer/info';
  static const String updateProfileInfo = '/api/customer/update/profile';
  static const String bannerUei = '/api/customer/banner/list?limit=100&offset=1';
  static const String bannerCountUpdate = '/api/customer/banner/update-redirection-count';
  static const String vehicleMainCategory = '/api/customer/vehicle/category?limit=100&offset=1';
  static const String getZone = '/api/customer/config/get-zone-id';
  static const String geoCodeURI = '/api/customer/config/geocode-api';
  static const String searchLocationUri = '/api/customer/config/place-api-autocomplete';
  static const String getDistanceFromLatLng = '/api/customer/config/distance_api';
  static const String placeApiDetails = '/api/customer/config/place-api-details';
  static const String estimatedFare = '/api/customer/ride/get-estimated-fare';
  static const String rideRequest = '/api/customer/ride/create';
  static const String addNewAddress = '/api/customer/address/add';
  static const String getAddressList = '/api/customer/address/all-address?limit=10&offset=';
  static const String getRecentAddressList = '/api/customer/recent-address';
  static const String updateAddress = '/api/customer/address/update';
  static const String deleteAddress = '/api/customer/address/delete';
  static const String fcmTokenUpdate = '/api/customer/update/fcm-token';
  static const String updateLasLocation = '/api/customer/ride/track-location';
  static const String tripDetails = '/api/customer/ride/details/';
  static const String tripAcceptOrReject = '/api/customer/ride/trip-action';
  static const String couponList = '/api/customer/coupon/list?limit=10&offset=';
  static const String applyCoupon = '/api/customer/ride/apply-coupon';
  static const String removeCoupon = '/api/customer/ride/cancel-coupon';
  static const String remainDistance = '/api/customer/config/get-routes';
  static const String biddingList = '/api/customer/ride/bidding-list/';
  static const String ignoreBidding = '/api/customer/ride/ignore-bidding';
  static const String nearestDriverList = '/api/customer/drivers-near-me';
  static const String currentRideStatus = '/api/customer/ride/ride-resume-status';
  static const String updateTripStatus = '/api/customer/ride/update-status/';
  static const String finalFare = '/api/customer/ride/final-fare';
  static const String submitReview = '/api/customer/review/store';
  static const String tripList = '/api/customer/ride/list';
  static const String paymentUri = '/api/customer/ride/payment';
  static const String digitalPayment = '/api/customer/ride/digital-payment';
  static const String createChannel = '/api/customer/chat/create-channel';
  static const String channelList = '/api/customer/chat/channel-list';
  static const String conversationList = '/api/customer/chat/conversation';
  static const String sendMessage = '/api/customer/chat/send-message';
  static const String arrivalPickupPoint = '/api/customer/ride/arrival-time';
  static const String parcelCategoryUri = '/api/customer/parcel/category?limit=100&offset=1';
  static const String suggestedVehicleCategory = '/api/customer/parcel/suggested-vehicle-category?parcel_weight=';
  static const String notificationList = '/api/customer/notification-list?limit=10&offset=';
  static const String transactionListUri = '/api/customer/transaction/list?limit=10&offset=';
  static const String loyaltyPointListUri = '/api/customer/loyalty-points/list?limit=10&offset=';
  static const String pointConvert = '/api/customer/loyalty-points/convert';
  static const String alreadySubmittedReview = '/api/customer/review/check-submission';
  static const String parcelOngoingList = '/api/customer/ride/ongoing-parcel-list?limit=100&offset=1';
  static const String parcelUnpaidList = '/api/customer/ride/unpaid-parcel-list?limit=100&offset=1';
  static const String getDriverLocation = '/api/user/get-live-location?trip_request_id=';
  static const String findChannelRideStatus = '/api/customer/chat/find-channel';
  static const String getPaymentMethods = '/api/customer/config/get-payment-methods';
  static const String getOngoingandAcceptedCancalationCauseList = '/api/customer/config/cancellation-reason-list';
  static const String customerAppliedCoupon = '/api/customer/applied-coupon';
  static const String bestOfferList = '/api/customer/discount/list?limit=10&offset=';
  static const String changeLanguage = '/api/customer/change-language';
  static const String getProfileLevel = '/api/customer/level';


  ///Pusher web socket
  static const String appKey = 'AshryUP';

  /// Shared Key
  static const String notification = 'notification';
  static const String theme = 'theme';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String userPassword = 'user_password';
  static const String userAddress = 'user_address';
  static const String userNumber = 'user_number';
  static const String loginCountryCode = 'login_country_code';
  static const String searchAddress = 'search_address';
  static const String localization = 'X-Localization';
  static const String topic = 'notify';
  static const String intro = 'intro';
  static const String zoneId = 'zone_id';

  /// Status
  static const String pending = 'pending';
  static const String accepted = 'accepted';
  static const String ongoing = 'ongoing';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';
  static const double otpShownArea = 500;

  ///map zoom
  static const double mapZoom = 20;


  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.unitedKingdom, languageName: 'English', countryCode: 'US', languageCode: 'en',),
    LanguageModel(imageUrl: Images.saudi, languageName: 'عربي', countryCode: 'SA', languageCode: 'ar'),
  ];

  static const int limitOfPickedIdentityImageNumber = 2;
  static const double limitOfPickedImageSizeInMB = 2;

  static List<OnBoardingModel> onBoardPagerData = [
    OnBoardingModel(title: 'on_boarding_1_title'.tr, image: 'assets/image/on_board_one.png'),
    OnBoardingModel(title: 'on_boarding_2_title'.tr, image: 'assets/image/on_board_two.png'),
    OnBoardingModel(title: 'on_boarding_3_title'.tr, image: 'assets/image/on_board_three.png'),
    OnBoardingModel(title: 'on_boarding_4_title'.tr, image: 'assets/image/on_board_four.png'),
  ];
}
