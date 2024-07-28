import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/styles.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode node;
  final String? hint;
  final bool showSuffix;
  const InputField({super.key, required this.controller, required this.node, this.hint,  this.showSuffix = true});

  @override
  Widget build(BuildContext context) {
    return Container(height: 45,
      decoration: BoxDecoration(color: Theme.of(context).primaryColorDark.withOpacity(.25),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
      child: TextFormField(
        controller: controller,
        style: textRegular.copyWith(color: Colors.white.withOpacity(0.8)),
        focusNode: node,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Get.isDarkMode? Theme.of(context).cardColor : null,
            filled: Get.isDarkMode,
          contentPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
          hintText: hint ?? 'Enter Route',
          suffixIcon: showSuffix? Icon(Icons.place_outlined, color: Colors.white.withOpacity(0.7)): const SizedBox(),
          hintStyle: textRegular.copyWith(color: Colors.white.withOpacity(0.5), fontSize : Dimensions.fontSizeSmall),
          enabledBorder: UnderlineInputBorder(
            borderSide:  BorderSide(width: 0.5, color: Theme.of(context).hintColor.withOpacity(0.5)))),
        cursorColor: Colors.white,
      ),);
  }
}
