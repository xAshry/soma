import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/common_widgets/country_picker_widget.dart';
import 'package:ride_sharing_user_app/localization/localization_controller.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final bool isAmount;
  final Function(String text)? onChanged;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final double borderRadius;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool showBorder;
  final String? countryDialCode;
  final double prefixHeight;
  final Color? fillColor;
  final bool prefix;
  final bool suffix;
  final Color? textColor;
  final Function()? onPressedSuffix;
  final Function(CountryCode countryCode)? onCountryChanged;
  final String? errorText;
  final Function()? onTap;
  final bool read;


  const CustomTextField(
      {super.key,
        this.hintText = 'Write something...',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onChanged,
        this.prefixIcon,
        this.capitalization = TextCapitalization.none,
        this.isPassword = false,
        this.isAmount = false,
        this.borderRadius=50,
        this.showBorder = true,
        this.prefixHeight = 30,
        this.countryDialCode,
        this.onCountryChanged,
        this.fillColor,
        this.prefix=true,
        this.suffix=true,
        this.suffixIcon,
        this.onPressedSuffix,
        this.textColor,
        this.errorText,
        this.onTap,
        this.read = false
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _validate = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: widget.textColor),
      textInputAction: widget.inputAction,
      keyboardType: (widget.isAmount || widget.inputType == TextInputType.phone) ? const TextInputType.numberWithOptions(
        signed: false, decimal: true,
      ) : widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      textAlignVertical: TextAlignVertical.center,
      autofillHints: widget.inputType == TextInputType.name ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress ? [AutofillHints.email]
          : widget.inputType == TextInputType.phone ? [AutofillHints.telephoneNumber]
          : widget.inputType == TextInputType.streetAddress ? [AutofillHints.fullStreetAddress]
          : widget.inputType == TextInputType.url ? [AutofillHints.url]
          : widget.inputType == TextInputType.visiblePassword ? [AutofillHints.password] : null,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))]
          : widget.isAmount ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))] : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:  BorderSide(width: widget.showBorder? 0.5 : 0.5,
              color: Theme.of(context).hintColor.withOpacity(widget.showBorder?0.5:0.0)),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:  BorderSide(width: widget.showBorder? 0.5 : 0.5,
              color: Theme.of(context).hintColor.withOpacity(.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:  BorderSide(width: widget.showBorder? 0.5 : 0.5,
              color: Theme.of(context).primaryColor),
        ),

        hintText: widget.hintText,
        fillColor: widget.fillColor ?? Theme.of(context).cardColor,
        hintStyle: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: widget.prefix? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault,
        vertical: !widget.isEnabled? 12:0),

        prefixIcon: widget.prefix == false ? null: widget.prefixIcon!=null ? Container(
          margin: EdgeInsets.only(right: widget.fillColor != null ? 0 : Get.find<LocalizationController>().isLtr?10:0, left: Get.find<LocalizationController>().isLtr? 0 : 10),
          width: widget.prefixHeight,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color:  widget.fillColor != null ?Colors.transparent :Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.only(
              topRight: Get.find<LocalizationController>().isLtr?  const Radius.circular(0):Radius.circular(widget.borderRadius),
              bottomRight: Get.find<LocalizationController>().isLtr?  const Radius.circular(0):Radius.circular(widget.borderRadius),
              topLeft: Get.find<LocalizationController>().isLtr? Radius.circular(widget.borderRadius):const Radius.circular(0),
              bottomLeft: Get.find<LocalizationController>().isLtr? Radius.circular(widget.borderRadius):const Radius.circular(0),
            ),
          ),
          child: Center(child: Image.asset(widget.prefixIcon!, height: 20, width: 20)),
        ) : SizedBox(width: 130,
          child: Row(children: [
              Container(width: 70,height: 50,
                decoration: BoxDecoration(
                  color:Get.isDarkMode? Theme.of(context).primaryColor.withOpacity(0.1) : widget.fillColor ?? Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topRight: Get.find<LocalizationController>().isLtr?  const Radius.circular(0):Radius.circular(widget.borderRadius),
                    bottomRight: Get.find<LocalizationController>().isLtr?  const Radius.circular(0):Radius.circular(widget.borderRadius),
                    topLeft: Get.find<LocalizationController>().isLtr? Radius.circular(widget.borderRadius): const Radius.circular(0),
                    bottomLeft: Get.find<LocalizationController>().isLtr? Radius.circular(widget.borderRadius): const Radius.circular(0),
                  ),
                ),
                margin:  EdgeInsets.only(right: Get.find<LocalizationController>().isLtr? 10 : 0, left: Get.find<LocalizationController>().isLtr? 0 : 10),
                padding:  EdgeInsets.only(left: Get.find<LocalizationController>().isLtr?15:0 , right: Get.find<LocalizationController>().isLtr?0:15),
                child: Center(
                  child: CodePickerWidget(
                    flagWidth: 25,
                    padding: EdgeInsets.zero,
                    onChanged: widget.onCountryChanged,
                    initialSelection: widget.countryDialCode,
                    favorite: [widget.countryDialCode!],
                    showDropDownButton: true,
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    showFlagDialog: true,
                    hideMainText: true,
                    showFlagMain: true,
                    dialogBackgroundColor: Theme.of(context).cardColor,
                    barrierColor: Get.isDarkMode?Colors.black.withOpacity(0.4):null,
                    textStyle: textRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(widget.countryDialCode??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
              ),
            ],
          ),
        ),
        suffixIcon: widget.suffixIcon!=null?
        InkWell(
          onTap: widget.onPressedSuffix,
          child: Container(
            margin: EdgeInsets.only(right: widget.fillColor!=null ? 0: 10),
            width: 40,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color:  widget.fillColor!=null ?Colors.transparent :Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.borderRadius),
                bottomLeft: Radius.circular(widget.borderRadius),
              ),
            ),
            child: Center(child: Image.asset(widget.suffixIcon!, height: 20, width: 20)),),
        ) :widget.isPassword ?
        IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor.withOpacity(0.5)),
          onPressed: _toggle,
        ) : null,

        errorText: _validate? widget.errorText : '',
        errorStyle: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, height: 0.1),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:  BorderSide(width: widget.showBorder? 0.5 : 0.5,
              color: Theme.of(context).hintColor.withOpacity(widget.showBorder?0.5:0.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:  BorderSide(width: widget.showBorder? 0.5 : 0.5,
              color: Theme.of(context).primaryColor),
        ),


      ),
      onSubmitted: (text) {

        widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
            : null;
        setState(() {
          widget.controller!.text.isEmpty ? _validate = true : _validate = false;
        });
      },
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      readOnly: widget.read,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}