import 'package:get/get.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/config_controller.dart';

class PriceConverter {

  static String convertPrice(double price, {double? discount, String? discountType,bool? loyaltyPoint}) {
    bool inRight = Get.find<ConfigController>().config!.currencySymbolPosition == 'right';
    String decimal = Get.find<ConfigController>().config!.currencyDecimalPoint?? '1';
    String symbol = loyaltyPoint == null ? Get.find<ConfigController>().config!.currencySymbol?? '\$' : '';
    String finalResult;
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price - discount;
      }else if(discountType == 'percent') {
        price = price - ((discount / 100) * price);
      }
    }
    if(inRight){
      finalResult = '${(price).toStringAsFixed(int.parse(decimal)).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} $symbol';
    }else{
      finalResult = '$symbol ''${(price).toStringAsFixed(int.parse(decimal)).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
    }
    return finalResult;
  }

  static double convertWithDiscount(double price, double discount, String discountType) {
    if(discountType == 'amount') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : '\$'} OFF';
  }
}