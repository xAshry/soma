
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:ride_sharing_user_app/helper/price_converter.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class PaymentItemInfoWidget extends StatefulWidget {
  final String? icon;
  final String title;
  final double amount;
  final bool isSubTotal;
  final bool isFromTripDetails;
  final String? paymentType;
  final bool discount;
  final String? toolTipText;
  final String? subTitle;

  const PaymentItemInfoWidget({super.key, required this.title,  this.icon, required this.amount,  this.isSubTotal = false,
    this.isFromTripDetails = false, this.paymentType, this.discount = false,this.subTitle,this.toolTipText});

  @override
  State<PaymentItemInfoWidget> createState() => _PaymentItemInfoWidgetState();
}

class _PaymentItemInfoWidgetState extends State<PaymentItemInfoWidget> {
  JustTheController tooltipController = JustTheController();

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if(widget.icon != null)
          SizedBox(width:Dimensions.iconSizeSmall, child: Image.asset(widget.icon!)),

        if(widget.icon != null)
          const SizedBox(width: Dimensions.paddingSizeSmall),

        Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start, children: [
          Row(children: [
            widget.icon != null?
            Text(widget.title, style: textMedium.copyWith(color: Theme.of(context).primaryColor)):
            Text(widget.title, style: textBold.copyWith(color: Theme.of(context).primaryColor)),

            widget.toolTipText != null ?
            JustTheTooltip(
              backgroundColor:Get.isDarkMode ?
              Theme.of(context).primaryColor :
              Theme.of(context).textTheme.bodyMedium!.color,
              controller: tooltipController,
              preferredDirection: AxisDirection.right,
              tailLength: Dimensions.paddingSizeSmall,
              tailBaseWidth: Dimensions.paddingSizeLarge,
              content: Container(width: Get.width * 0.45,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Text(widget.toolTipText!.tr,
                      style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault))),
              child: InkWell(
                  onTap: () async {
                    tooltipController.showTooltip();
                  },

                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Icon(Icons.info,color: Theme.of(context).primaryColor,size: 16,))),
            ) : const SizedBox()]),

          widget.subTitle != null ?
          Text(
            widget.subTitle!.tr,
            style: textRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context).hintColor,
            ),
          ) : const SizedBox()
        ])),

        widget.isSubTotal || widget.isFromTripDetails ?
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeSmall,
            vertical: Dimensions.paddingSizeExtraSmall,
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(.15),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
          ),
          child: Text(
            PriceConverter.convertPrice(widget.amount),
            style: textSemiBold.copyWith(
              color: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColorDark,
            ),
          ),
        ) :
        widget.paymentType != null ?
        Text(widget.paymentType!,style: textRegular.copyWith(color: Theme.of(context).primaryColor)) :
        widget.discount ?
        Text(
          '-${PriceConverter.convertPrice(widget.amount)}',
          style: textRegular.copyWith(
            color: Get.isDarkMode? Colors.white : Theme.of(context).primaryColor,
          ),
        ) :
        Text(
          PriceConverter.convertPrice(widget.amount),
          style: textRegular.copyWith(
            color: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),

      ]),
    );
  }
}