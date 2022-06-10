import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_store/controller/user_auth_controller.dart';
import 'package:medical_store/view/screen/dashboard/bill_system/invoice_history_screen.dart';
import 'package:medical_store/view/screen/dashboard/bill_system/make_new_invoice_screen.dart';
import 'package:medical_store/view/screen/dashboard/product_system/all_product_details_screen.dart';
import 'package:medical_store/view/widget/common_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'product_system/enter_new_product_screen.dart';

class DashboardScreen extends StatelessWidget{
  final UserAuthController _userAuthController = Get.put(UserAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ---- =======================   About Developer  ===================== ----------
      bottomNavigationBar: Container(
                           height: 100.h,
                             child: Padding(
                               padding:  EdgeInsets.symmetric(horizontal: 30.w),
                               child: Column(

                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        commonText(title: "Developed By:"),
                                        SizedBox(width: 13.w,),
                                        commonText(title: "Muhammad Owais",fontWidget: FontWeight.w600,fontSize: 45.sp),
                                        SizedBox(width: 30.w,),
                                        commonText(title: "Contact:"),
                                        SizedBox(width: 13.w,),
                                        commonText(title: "03352410002",fontWidget: FontWeight.w600,fontSize: 45.sp),
                                      ],
                                    ),
                                  SizedBox(height: 10.h,)
                                  ],),
                             ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 70.w),
          child: Column(
            children: [
              SizedBox(height: 50.h,),
              // ---- ===================  Logo And LogOut ================== ------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 330.h,
                    width: 290.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/logo.png"),fit: BoxFit.fill)
                    ),
                  ),

                  Container(
                    height: 100.h,
                    // width: 120.w,
                    decoration: (
                    BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(60.r)
                    )
                    ),
                    child: InkWell(
                        onTap: () {
                          _userAuthController.logOut();
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SizedBox(width:  20.w,),
                              commonText(title: " Logout",
                                  fontWidget: FontWeight.w600,fontSize: 50.sp,color: Colors.white),
                              SizedBox(width: 20.w,),
                              Icon(CupertinoIcons.arrowshape_turn_up_left_2,color: Colors.white,size: 56.r,),
                              SizedBox(width:  10.w,),
                            ],
                          ),
                        )),
                  ),

                ],
              ),
              // ---- =======================   Buttons  ===================== ----------
              Column(
                children: [
                  SizedBox(height: 400.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300.w,
                        child: commonButton(
                          onTap: (){
                            Get.to(() => EnterNewProductScreen());
                          },
                          buttonName: "Enter New Product"
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80.h,),
                  Container(
                    width: 300.w,
                    child: commonButton(
                        onTap: (){
                          Get.to(() => AllProductDetailsScreen());
                        },
                        buttonName: "All Products Data"
                    ),
                  ),
                  SizedBox(height: 80.h,),
                  Container(
                    width: 300.w,
                    child: commonButton(
                        onTap: (){
                          Get.to(() => InvoiceHistoryScreen());
                        },
                        buttonName: "Invoice History"
                    ),
                  ),
                  SizedBox(height: 80.h,),
                  Container(
                    width: 300.w,
                    child: commonButton(
                        onTap: (){
                          Get.to(() => MakeNewInvoiceScreen());
                          },
                        buttonName: "Make New Invoice"
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}