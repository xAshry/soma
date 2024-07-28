import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/features/auth/widgets/test_field_title.dart';
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/features/auth/controllers/auth_controller.dart';
import 'package:ride_sharing_user_app/features/auth/domain/models/sign_up_body.dart';
import 'package:ride_sharing_user_app/features/splash/controllers/config_controller.dart';
import 'package:ride_sharing_user_app/common_widgets/button_widget.dart';
import 'package:ride_sharing_user_app/common_widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode fNameNode = FocusNode();
  FocusNode lNameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode passwordNode = FocusNode();


  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().countryDialCode = CountryCode.fromCountryCode(Get.find<ConfigController>().config!.countryCode!).dialCode!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: GetBuilder<AuthController>(builder: (authController){
        return Center(child: SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Image.asset(Images.logoWithName, height: 75),
                        const SizedBox(height: Dimensions.paddingSizeLarge),

                        Image.asset(Images.signUpScreenLogo, width: 150),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                  ])),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),

                  Text('sign_up'.tr,
                    style: textBold.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeOverLarge,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                  Text(
                    'sign_up_message'.tr,maxLines: 2,
                    style: textMedium.copyWith(
                        color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  TextFieldTitle(title: 'first_name'.tr),

                  CustomTextField(
                    capitalization: TextCapitalization.words,
                    hintText: 'first_name'.tr,
                    inputType: TextInputType.name,
                    prefixIcon: Images.person,
                    controller: fNameController,
                    focusNode: fNameNode,
                    nextFocus: lNameNode,
                    inputAction: TextInputAction.next,
                    prefixHeight: 70,
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),

                  TextFieldTitle(title: 'last_name'.tr),

                  CustomTextField(
                    capitalization: TextCapitalization.words,
                    hintText: 'last_name'.tr,
                    inputType: TextInputType.name,
                    prefixIcon: Images.person,
                    controller: lNameController,
                    focusNode: lNameNode,
                    nextFocus: phoneNode,
                    inputAction: TextInputAction.next,
                    prefixHeight: 70,
                  ),

                  TextFieldTitle(title: 'phone'.tr),

                  CustomTextField(
                    // prefixIcon: countryDialCode,
                    hintText: 'phone'.tr,
                    inputType: TextInputType.number,
                    countryDialCode: authController.countryDialCode,
                    controller: phoneController,
                    focusNode: phoneNode,
                    nextFocus: passwordNode,
                    inputAction: TextInputAction.next,
                    onCountryChanged: (CountryCode countryCode){
                      authController.countryDialCode = countryCode.dialCode!;
                      authController.setCountryCode(countryCode.dialCode!);
                    },
                  ),

                  TextFieldTitle(title: 'password'.tr),

                  CustomTextField(
                    hintText: 'enter_password'.tr,
                    inputType: TextInputType.text,
                    prefixIcon: Images.password,
                    isPassword: true,
                    controller: passwordController,
                    focusNode: passwordNode,
                    nextFocus: confirmPasswordNode,
                    inputAction: TextInputAction.next,
                    prefixHeight: 70,
                  ),

                  TextFieldTitle(title: 'confirm_password'.tr),

                  CustomTextField(
                    hintText: 'enter_confirm_password'.tr,
                    inputType: TextInputType.text,
                    prefixIcon: Images.password,
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordNode,
                    inputAction: TextInputAction.done,
                    prefixHeight: 70,
                    isPassword: true,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault * 3),

                  authController.isLoading ?
                  Center(child: SpinKitCircle(color: Theme.of(context).primaryColor, size: 40.0)) :
                  ButtonWidget(
                    buttonText: 'submit'.tr,
                    radius: 50,
                    onPressed: () {
                      String fName = fNameController.text.trim();
                      String lName = lNameController.text.trim();
                      String phone = phoneController.text.trim();
                      String password = passwordController.text.trim();
                      String confirmPassword = confirmPasswordController.text.trim();

                      if(fName.isEmpty) {
                        showCustomSnackBar('first_name_is_required'.tr);
                        FocusScope.of(context).requestFocus(fNameNode);
                      }else if(lName.isEmpty) {
                        showCustomSnackBar('last_name_is_required'.tr);
                        FocusScope.of(context).requestFocus(lNameNode);
                      }else if(phone.isEmpty) {
                        showCustomSnackBar('phone_is_required'.tr);
                        FocusScope.of(context).requestFocus(phoneNode);
                      }else if(!GetUtils.isPhoneNumber(authController.countryDialCode + phone)) {
                        showCustomSnackBar('phone_number_is_not_valid'.tr);
                        FocusScope.of(context).requestFocus(phoneNode);
                      }else if(password.isEmpty) {
                        showCustomSnackBar('password_is_required'.tr);
                        FocusScope.of(context).requestFocus(passwordNode);
                      }else if(password.length < 8) {
                        showCustomSnackBar('minimum_password_length_is_8'.tr);
                        FocusScope.of(context).requestFocus(passwordNode);
                      }else if(confirmPassword.isEmpty) {
                        showCustomSnackBar('confirm_password_is_required'.tr);
                        FocusScope.of(context).requestFocus(confirmPasswordNode);
                      }else if(password != confirmPassword) {
                        showCustomSnackBar('password_is_mismatch'.tr);
                        FocusScope.of(context).requestFocus(confirmPasswordNode);
                      } else{
                        authController.register(SignUpBody(
                          fName: fName,
                          lName: lName,
                          phone: authController.countryDialCode + phone,
                          password: password,
                          confirmPassword: confirmPassword,
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),

                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        '${'already_have_an_account'.tr} ',
                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                      ),

                      TextButton(
                          onPressed: () =>  Get.back(),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero, minimumSize: const Size(50,30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text('login'.tr, style: textRegular.copyWith(
                              decoration: TextDecoration.underline, color: Theme.of(context).primaryColor,
                          )),
                      ),
                  ]),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                ],
              ),
            ),
          ));
      }),
    ));
  }
}
