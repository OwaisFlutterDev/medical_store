import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_store/constants/constant.dart';
import 'package:medical_store/controller/form_validation_controller.dart';
import 'package:medical_store/controller/grand_total_controller.dart';
import 'package:medical_store/view/widget/common_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class  SearchByDateScreen extends StatelessWidget{
  final FormValidationController _formValidationController = Get.put(FormValidationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:commonText(title: " Search By Date:", fontWidget: FontWeight.bold,fontSize: 70.sp,color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.w),
          child: GetBuilder<GrandTotalController>(
            init: GrandTotalController(),
            builder: (controller) {
              return Column(
                children: [
                  SizedBox(height: 80.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 700.w,
                        height: 146.h,
                        child: commonTextFormField(
                          prefixIcon: Icon(CupertinoIcons.search),
                          hintText: "Search Invoice",
                          controller: _formValidationController.searchProductController,
                        ),
                      ),
                      SizedBox(width: 30.w,),

                      controller.searchBoolButton == false ? InkWell(
                          onTap: (){
                            controller.searchProductByDate(_formValidationController.searchProductController.text.trim());
                          },
                          child: commonText(title: "Search",fontSize: 45.sp,color: Colors.blue,fontWidget: FontWeight.w600
                          )) : CircularProgressIndicator()
                    ],
                  ),

                  controller.searchBoolByDate == true ?  Column(
                          children: [
                            SizedBox(height: 40.h,),
                            Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              border:  TableBorder(
                                top: BorderSide(color: Colors.black, width: 1),
                              ),
                              columnWidths: {
                                0: FlexColumnWidth(0.15),
                                1: FlexColumnWidth(0.4),
                                2: FlexColumnWidth(0.3),
                                3: FlexColumnWidth(0.15),
                                4: FlexColumnWidth(0.3),
                                5: FlexColumnWidth(0.3),
                                6: FlexColumnWidth(0.3),
                              },
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(237, 239, 245, 1)),
                                    children: [
                                      TableCell(
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                            child: Center(
                                                child: commonText(
                                                    title: "S.NO",
                                                    color: Colors.black,
                                                    fontSize: 40.sp,
                                                    fontWidget: FontWeight.w500)),
                                          )),
                                      TableCell(

                                          child: Center(
                                              child: commonText(
                                                  title: "Invoice Id",
                                                  color: blueColor,
                                                  fontWidget: FontWeight.w500))),
                                      TableCell(

                                          child: Center(
                                              child: commonText(
                                                  title: "Sub Total",
                                                  color: blueColor,
                                                  fontWidget: FontWeight.w500))),
                                      TableCell(
                                          child: Center(
                                              child: commonText(
                                                  title: "Disc",
                                                  color: blueColor,
                                                  fontWidget: FontWeight.w500))),
                                      TableCell(
                                          child: Center(
                                              child: commonText(
                                                  title: "Grand Total",
                                                  color: blueColor,
                                                  fontWidget: FontWeight.w500))),
                                      TableCell(
                                          child: Center(
                                              child: commonText(
                                                  title: "Date",
                                                  color: blueColor,
                                                  fontWidget: FontWeight.w500))),

                                      TableCell(
                                          child: Center(
                                              child: commonText(
                                                  title: "Delete & Edit",
                                                  color: blueColor,
                                                  fontSize: 35.sp,
                                                  fontWidget: FontWeight.w500))),

                                    ]),
                              ],
                            ),

                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: controller.snapshotOFByDate.docs.length,
                                itemBuilder: (context, index) {
                                  return  Table(
                                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                    border:  TableBorder(
                                      bottom: BorderSide(color: Colors.black, width: 1),
                                      top: BorderSide(color: Colors.black, width: 1),
                                    ),
                                    columnWidths: {
                                              0: FlexColumnWidth(0.15),
                                              1: FlexColumnWidth(0.4),
                                              2: FlexColumnWidth(0.3),
                                              3: FlexColumnWidth(0.15),
                                              4: FlexColumnWidth(0.3),
                                              5: FlexColumnWidth(0.3),
                                              6: FlexColumnWidth(0.3),
                                    },
                                    children: [
                                      TableRow(
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(237, 239, 245, 1),
                                          ),
                                          children: [
                                            TableCell(
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                  child: Center(
                                                      child: commonText(
                                                          title: "$index",
                                                          color: Colors.black,
                                                          fontSize: 40.sp,
                                                          fontWidget: FontWeight.w500)),
                                                )),
                                            TableCell(
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                  child: Center(
                                                      child: commonText(
                                                          title: controller.snapshotOFByDate.docs[index]['id'],
                                                          color: Colors.black,
                                                          fontSize: 40.sp,
                                                          fontWidget: FontWeight.w400)),
                                                )),
                                            TableCell(
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                  child: Center(
                                                      child: commonText(
                                                          title: controller.snapshotOFByDate.docs[index]['subTotal'],
                                                          color: Colors.black,
                                                          fontSize: 40.sp,
                                                          fontWidget: FontWeight.w400)),
                                                )),
                                            TableCell(
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                  child: Center(
                                                      child: commonText(
                                                          title: controller.snapshotOFByDate.docs[index]['disc'],
                                                          color: Colors.black,
                                                          fontSize: 40.sp,
                                                          fontWidget: FontWeight.w400)),
                                                )),
                                            TableCell(
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                  child: Center(
                                                      child: commonText(
                                                          title: controller.snapshotOFByDate.docs[index]['grandTotal'],
                                                          color: Colors.black,
                                                          fontSize: 40.sp,
                                                          fontWidget: FontWeight.w400)),
                                                )),
                                            TableCell(
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                  child: Center(
                                                      child: commonText(
                                                          title: controller.snapshotOFByDate.docs[index]['day'],
                                                          color: Colors.black,
                                                          fontSize: 40.sp,
                                                          fontWidget: FontWeight.w400)),
                                                )),


                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                              child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          controller.subTotalController.text =
                                                          controller.snapshotOFByDate.docs[index]['subTotal'];

                                                          controller.discController.text =
                                                          controller.snapshotOFByDate.docs[index]['disc'];

                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext context) {
                                                                return Padding(
                                                                  padding:  EdgeInsets.symmetric(horizontal: 300.w),
                                                                  child: AlertDialog(
                                                                    scrollable: true,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all( Radius.circular(15))),
                                                                    backgroundColor: Colors.indigo,
                                                                    content: GetBuilder<GrandTotalController>(

                                                                      builder: (controller) {
                                                                        return Column(
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          children: [
                                                                            SizedBox(height: 40.h,),
                                                                            commonText(title: "Update Product:",fontWidget: FontWeight.w700,color: Colors.orange),
                                                                            SizedBox(height: 40.h,),
                                                                            Container(
                                                                              width: 500.w,
                                                                              child: Form(
                                                                                  key: controller.updateByDateForSearchFormKey,
                                                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                                  child:
                                                                                  Column(
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding:
                                                                                        EdgeInsets.symmetric(horizontal: 50.h),
                                                                                        child:
                                                                                        Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            commonText(title: "Sub Total",color: Colors.white70,fontSize: 30.sp),
                                                                                            // SizedBox(height: 10.h,),
                                                                                            TextFormField(
                                                                                              decoration: InputDecoration(hintText: "Sub Total", hintStyle: TextStyle(color: Colors.white70,),),
                                                                                              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                              controller: controller.subTotalController,
                                                                                            ),
                                                                                            SizedBox(height: 30.h,),
                                                                                            commonText(title: "Disc",color: Colors.white70,fontSize: 30.sp),
                                                                                            TextFormField(
                                                                                              decoration: InputDecoration(hintText: "Disc", hintStyle: TextStyle(color: Colors.white70)),
                                                                                              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                              controller: controller.discController,
                                                                                            ),
                                                                                            SizedBox(height: 30.h,),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  )),
                                                                            ),

                                                                            SizedBox(height: 60.h,),

                                                                            // --- update button ---
                                                                         controller.updateBool == false ? Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: 50.w),
                                                                              child: Container(
                                                                                height: 100.h,
                                                                                width: Get.size.width,
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.blue,
                                                                                    borderRadius: BorderRadius.circular(20.r)),
                                                                                child: InkWell(
                                                                                        onTap:
                                                                                            () {
                                                                                          controller.updateProductByDate(
                                                                                              controller.snapshotOFByDate.docs[index]['id']
                                                                                          );
                                                                                        },
                                                                                        child: Center(
                                                                                            child:
                                                                                            Text("Update Product Details", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)))),
                                                                                      )

                                                                              ),
                                                                            ) : CircularProgressIndicator()
                                                                          ],
                                                                        );
                                                                      }
                                                                    ),
                                                                  ),
                                                                );
                                                              });

                                                          print("Edit button clicked");
                                                        },
                                                        child: Icon(
                                                          Icons.edit_outlined,
                                                          color: Colors.black,
                                                          size: 46.r,
                                                        )),

                                                    InkWell(
                                                        onTap: () {

                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext context) {
                                                                return Padding(
                                                                  padding:  EdgeInsets.symmetric(horizontal: 300.w),
                                                                  child: AlertDialog(
                                                                    scrollable: true,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all( Radius.circular(15))),
                                                                    backgroundColor: Colors.indigo,
                                                                    content: GetBuilder<GrandTotalController>(
                                                                      builder: (controller) {
                                                                        return Column(
                                                                          mainAxisSize: MainAxisSize.min,
                                                                          children: [
                                                                            SizedBox(height: 30.h,),
                                                                            commonText(title: "Delete Invoice:",fontWidget: FontWeight.w700,color: Colors.orange,fontSize: 60.sp),
                                                                            SizedBox(height:60.h,),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                commonText(title: "Are You Sure You Want To Delete This Invoice:",
                                                                                fontWidget: FontWeight.w200,color: Colors.white,fontSize: 45.sp),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 60.h,),

                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                InkWell(
                                                                                    onTap:() {
                                                                                      Get.back();
                                                                                    },
                                                                                    child: commonText(title: "Cancel",fontSize: 50.sp,fontWidget: FontWeight.w600,color: Colors.white)),
                                                                                // --- Delete button ---
                                                                               controller.deleteBool == false ? InkWell(
                                                                                  onTap: () {
                                                                                    controller.deleteProductForDate(
                                                                                        controller.snapshotOFByDate.docs[index]['id']
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: blueColor,
                                                                                      borderRadius: BorderRadius.circular(60.r),
                                                                                    ),
                                                                                    height: 125.h,
                                                                                    child: Padding(
                                                                                      padding:  EdgeInsets.symmetric(horizontal: 15.w),
                                                                                      child: Align(
                                                                                          alignment: Alignment.center,
                                                                                          child: commonText(title: "Delete Invoice", fontWidget: FontWeight.bold,fontSize: 40.sp)),
                                                                                    ),
                                                                                  ),
                                                                                ) : CircularProgressIndicator()
                                                                              ],
                                                                            )
                                                                          ],
                                                                        );
                                                                      }
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                          print("Delete button clicked");
                                                        },
                                                        child: Icon(
                                                          CupertinoIcons.delete,
                                                          color: Colors.black,
                                                          size: 46.r,
                                                        )),
                                                  ]),
                                            )
                                          ]),
                                    ],
                                  );
                                })

                          ],)
                       :  Container(),

                  SizedBox(height: 100.h,)
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}