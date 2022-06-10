import 'package:flutter/material.dart';
import 'package:medical_store/constants/constant.dart';
import 'package:medical_store/controller/grand_total_controller.dart';
import 'package:medical_store/view/screen/dashboard/bill_system/search_by_date_screen.dart';
import 'package:medical_store/view/screen/dashboard/bill_system/search_by_invoice_id_Screen.dart';
import 'package:medical_store/view/widget/common_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceHistoryScreen extends StatefulWidget{

  @override
  _InvoiceHistoryScreenState createState() => _InvoiceHistoryScreenState();
}

class _InvoiceHistoryScreenState extends State<InvoiceHistoryScreen> {

  final GrandTotalController _grandTotalController = Get.put(GrandTotalController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:commonText(title: "Invoice History:", fontWidget: FontWeight.bold,fontSize: 70.sp,color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            children: [
              SizedBox(height: 100.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText(
                      title: "Invoice History Details",
                      color: Colors.black,
                      fontSize: 65.sp
                  ),
                  SizedBox(width: 50.w,),
                  Row(
                    children: [
                    InkWell(
                    onTap: (){
                         Get.to(() => SearchByInvoiceIdScreen());
                     },
                    child: Container(
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(60.r),
                      ),
                      height: 110.h,
                      child: Align(
                          alignment: Alignment.center,
                          child: commonText(title: "        Search By Invoice Id         " , fontWidget: FontWeight.w600,fontSize: 50.sp)),
                    ),
                  ),

                      SizedBox(width: 20.w,),
                      InkWell(
                        onTap: (){
                          Get.to(() => SearchByDateScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(60.r),
                          ),
                          height: 110.h,
                          child: Align(
                              alignment: Alignment.center,
                              child: commonText(title: "       Search By Date        " , fontWidget: FontWeight.w600,fontSize: 50.sp)),
                        ),
                      ),

                      SizedBox(width: 20.w,),
                    ],
                  ),
                ],),
              SizedBox(height: 140.h,),


              GetBuilder<GrandTotalController>(
                init: GrandTotalController(),
                builder: (controller) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(children: [
                      Divider(),
                      SizedBox(height: 30.h,),
                      // -------------  =============   Today Sale Amount: ========== ------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          commonText(title: "    Today Sale Amount:",fontSize: 50.sp,fontWidget: FontWeight.w600,color: Colors.teal),
                        ],
                      ),
                      SizedBox(height: 50.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 40.w,),
                          // --- ==== Get Today Sale button ==== ---
                          InkWell(
                            onTap: (){

                              setState(() {
                                controller.forTodayBool = true;
                              });
                              controller.sumOfToday = 0;
                              controller.getSumOfToday();

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(55.r),
                                  bottomLeft: Radius.circular(55.r),
                                ),
                              ),
                              height: 130.h,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: commonText(title: "   Get Today Sale Amount     " , fontWidget: FontWeight.w600,fontSize: 50.sp)),
                            ),
                          ),

                          // --- ===  amount === -------
                          SizedBox(width: 80.w,),
                          controller.forTodayBool == false ?

                          commonText(
                              title: "${controller.sumOfToday}",
                              color: Colors.orange,
                              fontSize: 60.sp,
                              fontWidget: FontWeight.w600
                          ) : CircularProgressIndicator() ,
                          SizedBox(height: 350.h,),
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      Divider(),

                      // ------------  ===========  This Month Sale Amount: ========= -------------
                      SizedBox(height: 30.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          commonText(title: "      This Month Sale Amount:",fontSize: 50.sp,fontWidget: FontWeight.w600,color: Colors.teal),
                        ],
                      ),
                      SizedBox(height: 50.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           SizedBox(width: 40.w,),
                          // --- ==== Get This Month Sale button ==== ---
                          InkWell(
                            onTap: (){

                              setState(() {
                                controller.forThisMonthBool = true;
                              });
                              controller.sumOfThisMonth = 0;
                              controller.getSumOfThisMonth();

                            },
                            child: Container(
                                    decoration: BoxDecoration(
                                      color: blueColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(55.r),
                                        bottomLeft: Radius.circular(55.r),
                                      ),
                                    ),
                                    height: 130.h,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child:
                                        commonText(title: "   Get This Month Sale Amount     " ,
                                            fontWidget: FontWeight.w600,fontSize: 50.sp)),
                                  ),
                          ),

                          // --- ===  amount === -------
                          SizedBox(width: 80.w,),
                          controller.forThisMonthBool == false ?
                          commonText(
                              title: "${controller.sumOfThisMonth}",
                              color: Colors.orange,
                              fontSize: 60.sp,
                              fontWidget: FontWeight.w600
                          ) : CircularProgressIndicator() ,

                          SizedBox(height: 350.h,),
                        ],
                      ),
                      SizedBox(height: 50.h,),
                      Divider(),
                    ],),
                  );
                }
              ),

              SizedBox(height: 40.h,)
            ],
          ),
        ),
      ),
    );
  }
}