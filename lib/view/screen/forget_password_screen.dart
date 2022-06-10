import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medical_store/constants/validation_constant.dart';
import 'package:medical_store/controller/form_validation_controller.dart';
import 'package:medical_store/controller/user_auth_controller.dart';
import 'package:medical_store/view/widget/common_widget.dart';

class ForgetPasswordScreen extends StatelessWidget{
  final FormValidationController _formValidationController = Get.put(FormValidationController());
  final UserAuthController _userAuthController = Get.put(UserAuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      // ---- login button ------
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 80.w,vertical: 100.h),
        child: commonButton(
            buttonName: "Reset Password",
            onTap: (){
              _formValidationController.forgetPasswordFormKey.currentState.save();
              if (_formValidationController.forgetPasswordFormKey.currentState.validate()) {
                _userAuthController.resetPasswordRequest();
              } else {
                Get.snackbar("Forget Password Screen",
                    "Please Fill All The Fields",
                    duration: Duration(seconds: 5));
              }
            }
        ),
      ),

      // ----- body ------
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 50.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h,),
              commonText(
                  title: "Medical Store System",
                  color: Colors.blue,
                  fontSize: 80.sp,
                  fontWidget: FontWeight.bold
              ),
              SizedBox(height: 20.h,),
              commonText(
                  title: "Enter Your Email In The Given Below Field.",
                  color: Colors.black,
                  fontSize: 50.sp,
              ),
              SizedBox(height: 160.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                child: Form(
                  key: _formValidationController.forgetPasswordFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      commonTextFormField(
                          hintText: "Email",
                          prefixIcon: Icon(CupertinoIcons.mail),
                          validator: ValidationConstant.emailValidator,
                          controller: _formValidationController.emailController
                      ),
                      SizedBox(height: 50.h,),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}