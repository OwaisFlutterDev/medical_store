import 'package:flutter/material.dart';
import 'package:medical_store/constants/validation_constant.dart';
import 'package:medical_store/controller/form_validation_controller.dart';
import 'package:medical_store/controller/product_controller.dart';
import 'package:medical_store/view/widget/common_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnterNewProductScreen extends StatelessWidget{
  final FormValidationController  _formValidationController = Get.put(FormValidationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:commonText(title: "Enter New Product:", fontWidget: FontWeight.bold,fontSize: 70.sp,color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 45.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70.h,),
              commonText(title: "Enter New Product Detail Here:",color: Colors.black,fontSize: 60.sp),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 50.w),
                child: Column(
                  children: [
                    SizedBox(height: 150.h,),
                    Form(
                      key: _formValidationController.enterNewProductFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonText(title: "   Product Name",fontSize: 30.sp),
                          SizedBox(height: 8.h,),
                          commonTextFormField(
                              hintText: "Product Name",
                              validator: ValidationConstant.commonValidator,
                              controller: _formValidationController.productName
                          ),

                          SizedBox(height: 50.h,),
                          commonText(title: "   Company Name",fontSize: 30.sp),
                          SizedBox(height: 8.h,),
                          commonTextFormField(
                              hintText: "Company Name",
                              controller: _formValidationController.companyName,
                              validator: ValidationConstant.commonValidator
                          ),

                          SizedBox(height: 50.h,),
                          commonText(title: "   Batch",fontSize: 30.sp),
                          SizedBox(height: 8.h,),
                          commonTextFormField(
                              hintText: "Batch ",
                              controller: _formValidationController.batch,
                              validator: ValidationConstant.commonValidator
                          ),

                          SizedBox(height: 50.h,),
                          commonText(title: "   MFG Date",fontSize: 30.sp),
                          SizedBox(height: 8.h,),
                          commonTextFormField(
                              hintText: "MFG Date",
                              controller: _formValidationController.mfgDate,
                              validator: ValidationConstant.commonValidator
                          ),
                          SizedBox(height: 50.h,),
                          commonText(title: "   Expire Date",fontSize: 30.sp),
                          SizedBox(height: 8.h,),
                          commonTextFormField(
                              hintText: "Expire Date",
                              controller: _formValidationController.expireDate,
                              validator: ValidationConstant.commonValidator
                          ),

                          SizedBox(height: 50.h,),
                          commonText(title: "   Quantity",fontSize: 30.sp),
                          SizedBox(height: 8.h,),
                          commonTextFormField(
                              hintText: "Quantity",
                              controller: _formValidationController.quantity,
                              validator: ValidationConstant.commonValidator
                          ),

                          SizedBox(height: 50.h,),
                          commonText(title: "   TP Rate (Per Quantity Rate)",fontSize: 30.sp),
                          SizedBox(height: 8.h,),
                          commonTextFormField(
                              hintText: "TP Rate ",
                              controller: _formValidationController.tPRate,
                              validator: ValidationConstant.commonValidator
                          ),

                          SizedBox(height: 50.h,),
                          commonText(title: "   Pack Disc",fontSize: 30.sp),
                          SizedBox(height: 8.h,),
                          commonTextFormField(
                              hintText: "Pack Disc ",
                              controller: _formValidationController.packDisc,
                              validator: ValidationConstant.commonValidator
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 130.h,),
                    GetBuilder<ProductController>(
                      init: ProductController(),
                      builder: (controller) {
                        return controller.addBool == false ? commonButton(
                             buttonName: "Submit",
                             onTap: (){
                               _formValidationController.enterNewProductFormKey.currentState.save();
                               if(_formValidationController.enterNewProductFormKey.currentState.validate()){

                                 controller.addProduct();
                               }
                               else{
                                 Get.snackbar(
                                   "Add Product Notification",
                                   "Please Fill All The Fields",
                                   snackPosition: SnackPosition.TOP,
                                   duration: Duration(seconds: 5),
                                 );
                               }
                             }
                            ) : CircularProgressIndicator();
                      }
                    ) ,
                    SizedBox(height: 60.h,),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}