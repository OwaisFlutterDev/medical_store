import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medical_store/constants/validation_constant.dart';
import 'package:medical_store/controller/form_validation_controller.dart';
import 'package:medical_store/controller/user_auth_controller.dart';
import 'package:medical_store/view/screen/forget_password_screen.dart';
import 'package:medical_store/view/widget/common_widget.dart';

class LoginScreen extends StatelessWidget{
  final FormValidationController _formValidationController = Get.put(FormValidationController());
  final UserAuthController _userAuthController = Get.put(UserAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          // ---- login button ------
          GetBuilder<UserAuthController>(

            builder: (controller) {
              return  controller.loginBool == false ?  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 80.w,vertical: 100.h),
                child: commonButton(
                  buttonName: "LOGIN",
                  onTap: (){
                    _formValidationController.loginFormKey.currentState.save();
                    if (_formValidationController.loginFormKey.currentState.validate()) {
                      _userAuthController.signInThroughEmailAndPassword();
                    } else {
                      Get.snackbar("Forget Password Screen",
                          "Please Fill All The Fields",
                          duration: Duration(seconds: 5));
                    }
                  }
                )
              ) : CircularProgressIndicator();
            }
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
                color: Colors.black,
                fontSize: 80.sp,
                fontWidget: FontWeight.bold
              ),
              SizedBox(height: 160.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.w),
                child: Form(
                  key: _formValidationController.loginFormKey,
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

                    commonTextFormField(
                        hintText: "Password",
                        prefixIcon: Icon(CupertinoIcons.lock),
                        obscureText: true,
                        controller: _formValidationController.passwordController,
                        validator: ValidationConstant.passwordValidatorForSignIn
                    ),
                    SizedBox(height: 40.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      InkWell(
                        onTap: () {
                           Get.to(ForgetPasswordScreen());
                          },
                          child: commonText(
                             title: "Forget Password",
                             color: Colors.orange,
                          )),
                        SizedBox(width: 10.w,),
                    ],)
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