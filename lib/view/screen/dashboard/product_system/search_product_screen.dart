import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_store/constants/constant.dart';
import 'package:medical_store/controller/form_validation_controller.dart';
import 'package:medical_store/controller/product_controller.dart';
import 'package:medical_store/view/widget/common_widget.dart';

class SearchProductScreen extends StatelessWidget{

  final FormValidationController _formValidationController = Get.put(FormValidationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:commonText(title: "Search Product:", fontWidget: FontWeight.bold,fontSize: 70.sp,color: Colors.white),
      ),
      body:  SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 50.w),
                child: GetBuilder<ProductController>(
                  init: ProductController(),
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
                                  hintText: "Search Product",
                                  controller: _formValidationController.searchProductController,
                              ),
                            ),
                            SizedBox(width: 30.w,),

                             controller.searchBoolForButton == false ?
                               InkWell(
                                      onTap: (){
                                        controller.searchProduct(_formValidationController.searchProductController.text.trim());
                                      },
                                    child: commonText(title: "Search",fontSize: 45.sp,color: Colors.blue,fontWidget: FontWeight.w600
                                  ))
                                 : CircularProgressIndicator()
                          ],
                        ),

                        controller.searchBool == true ? GetBuilder<ProductController>(
                         builder: (controller) {
                           return Column(
                              children: [
                                SizedBox(height: 40.h,),
                                Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  border:  TableBorder(
                                    top: BorderSide(color: Colors.black, width: 1),
                                    // horizontalInside: BorderSide(color: Colors.red, width: 2),
                                  ),
                                  columnWidths: {
                                    0: FlexColumnWidth(0.15),
                                    1: FlexColumnWidth(0.3),
                                    2: FlexColumnWidth(0.3),
                                    3: FlexColumnWidth(0.2),
                                    4: FlexColumnWidth(0.3),
                                    5: FlexColumnWidth(0.2),
                                    6: FlexColumnWidth(0.2),
                                    7: FlexColumnWidth(0.3),
                                    8: FlexColumnWidth(0.3),
                                    9: FlexColumnWidth(0.2),
                                    10: FlexColumnWidth(0.3),
                                    11: FlexColumnWidth(0.3),
                                    12: FlexColumnWidth(0.2),

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
                                                      title: "Product Name",
                                                      color: blueColor,
                                                      fontWidget: FontWeight.w500))),
                                          TableCell(

                                              child: Center(
                                                  child: commonText(
                                                      title: "Company Name",
                                                      color: blueColor,
                                                      fontWidget: FontWeight.w500))),
                                          TableCell(
                                              child: Center(
                                                  child: commonText(
                                                      title: "Batch",
                                                      color: blueColor,
                                                      fontWidget: FontWeight.w500))),
                                          TableCell(
                                              child: Center(
                                                  child: commonText(
                                                      title: "QTY",
                                                      color: blueColor,
                                                      fontWidget: FontWeight.w500))),
                                          TableCell(
                                              child: Center(
                                                  child: commonText(
                                                      title: "MFG Date",
                                                      color: blueColor,
                                                      fontWidget: FontWeight.w500))),
                                          TableCell(
                                              child: Center(
                                                  child: commonText(
                                                      title: "Expire Date",
                                                      color: blueColor,
                                                      fontWidget: FontWeight.w500))),
                                          TableCell(

                                              child: Center(
                                                  child: commonText(
                                                      title: "TP Rate",
                                                      color: blueColor,
                                                      fontWidget: FontWeight.w500))),
                                          TableCell(

                                              child: Center(
                                                  child: commonText(
                                                      title: "Pack Value",
                                                      color: blueColor,
                                                      fontWidget: FontWeight.w500))),
                                          TableCell(

                                              child: Center(
                                                  child: commonText(
                                                      title: "Pack Disc",
                                                      color: blueColor,
                                                      fontWidget: FontWeight.w500))),
                                          TableCell(

                                              child: Center(
                                                  child: commonText(
                                                      title: "Net Total",
                                                      color: blueColor,
                                                      fontWidget: FontWeight.w500))),
                                          TableCell(
                                              child: Center(
                                                  child: commonText(
                                                      title: "Date & Time",
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
                                              itemCount: controller.snapshotOFSearchProduct.docs.length,
                                              itemBuilder: (context, index) {
                                                return  Table(
                                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                                  border:  TableBorder(
                                                    bottom: BorderSide(color: Colors.black, width: 1),
                                                    top: BorderSide(color: Colors.black, width: 1),
                                                  ),
                                                  columnWidths: {
                                                    0: FlexColumnWidth(0.15),
                                                    1: FlexColumnWidth(0.3),
                                                    2: FlexColumnWidth(0.3),
                                                    3: FlexColumnWidth(0.2),
                                                    4: FlexColumnWidth(0.3),
                                                    5: FlexColumnWidth(0.2),
                                                    6: FlexColumnWidth(0.2),
                                                    7: FlexColumnWidth(0.3),
                                                    8: FlexColumnWidth(0.3),
                                                    9: FlexColumnWidth(0.2),
                                                    10: FlexColumnWidth(0.3),
                                                    11: FlexColumnWidth(0.3),
                                                    12: FlexColumnWidth(0.2),
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
                                                                        title: controller.snapshotOFSearchProduct.docs[index]['productName'],
                                                                        color: Colors.black,
                                                                        fontSize: 40.sp,
                                                                        fontWidget: FontWeight.w400)),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                                child: Center(
                                                                    child: commonText(
                                                                        title: controller.snapshotOFSearchProduct.docs[index]['companyName'],
                                                                        color: Colors.black,
                                                                        fontSize: 40.sp,
                                                                        fontWidget: FontWeight.w400)),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                                child: Center(
                                                                    child: commonText(
                                                                        title: controller.snapshotOFSearchProduct.docs[index]['batch'],
                                                                        color: Colors.black,
                                                                        fontSize: 40.sp,
                                                                        fontWidget: FontWeight.w400)),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                                child: Center(
                                                                    child: commonText(
                                                                        title: controller.snapshotOFSearchProduct.docs[index]['quantity'],
                                                                        color: Colors.black,
                                                                        fontSize: 40.sp,
                                                                        fontWidget: FontWeight.w400)),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                                child: Center(
                                                                    child: commonText(
                                                                        title: controller.snapshotOFSearchProduct.docs[index]['mfgDate'],
                                                                        color: Colors.black,
                                                                        fontSize: 40.sp,
                                                                        fontWidget: FontWeight.w400)),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                                child: Center(
                                                                    child: commonText(
                                                                        title: controller.snapshotOFSearchProduct.docs[index]['expireDate'],
                                                                        color: Colors.black,
                                                                        fontSize: 40.sp,
                                                                        fontWidget: FontWeight.w400)),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                                child: Center(
                                                                    child: commonText(
                                                                        title:  controller.snapshotOFSearchProduct.docs[index]['tPRate'],
                                                                        color: Colors.black,
                                                                        fontSize: 40.sp,
                                                                        fontWidget: FontWeight.w400)),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                                child: Center(
                                                                    child: commonText(
                                                                        title:  controller.snapshotOFSearchProduct.docs[index]['packValue'],
                                                                        color: Colors.black,
                                                                        fontSize: 40.sp,
                                                                        fontWidget: FontWeight.w400)),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                                child: Center(
                                                                    child: commonText(
                                                                        title: controller.snapshotOFSearchProduct.docs[index]['packDisc'],
                                                                        color: Colors.black,
                                                                        fontSize: 40.sp,
                                                                        fontWidget: FontWeight.w400)),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                                child: Center(
                                                                    child: commonText(
                                                                        title: controller.snapshotOFSearchProduct.docs[index]['netTotal'],
                                                                        color: Colors.black,
                                                                        fontSize: 40.sp,
                                                                        fontWidget: FontWeight.w400)),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                                child: Center(
                                                                    child: commonText(
                                                                        title: controller.snapshotOFSearchProduct.docs[index]['datetime'],
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
                                                                            controller.prodNameController.text =
                                                                            controller.snapshotOFSearchProduct.docs[index]['productName'];

                                                                            controller.compNameController.text =
                                                                            controller.snapshotOFSearchProduct.docs[index]['companyName'];

                                                                            controller.batchController.text =
                                                                            controller.snapshotOFSearchProduct.docs[index]['batch'];

                                                                            controller.qtyController.text =
                                                                            controller.snapshotOFSearchProduct.docs[index]['quantity'];

                                                                            controller.mfgDateController.text =
                                                                            controller.snapshotOFSearchProduct.docs[index]['mfgDate'];

                                                                            controller.expireDateController.text =
                                                                            controller.snapshotOFSearchProduct.docs[index]['expireDate'];

                                                                            controller.tPRateController.text =
                                                                            controller.snapshotOFSearchProduct.docs[index]['tPRate'];

                                                                            controller.packDiscController.text =
                                                                            controller.snapshotOFSearchProduct.docs[index]['packDisc'];

                                                                            showDialog(
                                                                                context: context,
                                                                                builder:
                                                                                    (BuildContext context) {
                                                                                  return GetBuilder<ProductController>(
                                                                                    init: ProductController(),
                                                                                    builder: (controller) {
                                                                                      return Padding(
                                                                                              padding:  EdgeInsets.symmetric(horizontal: 300.w),
                                                                                              child: AlertDialog(
                                                                                                scrollable: true,
                                                                                                shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.all( Radius.circular(15))),
                                                                                                backgroundColor: Colors.indigo,
                                                                                                content: Column(
                                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                                  children: [
                                                                                                    SizedBox(height: 40.h,),
                                                                                                    commonText(title: "Update Product:",fontWidget: FontWeight.w700,color: Colors.orange),
                                                                                                    SizedBox(height: 40.h,),
                                                                                                    Container(
                                                                                                      width: 500.w,
                                                                                                      child: Form(
                                                                                                          key: controller.updateProductForSearchFormKey,
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
                                                                                                                    commonText(title: "Product Name",color: Colors.white70,fontSize: 30.sp),
                                                                                                                    // SizedBox(height: 10.h,),
                                                                                                                    TextFormField(
                                                                                                                      decoration: InputDecoration(hintText: "Product Name", hintStyle: TextStyle(color: Colors.white70,),),
                                                                                                                      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                                                      controller: controller.prodNameController,
                                                                                                                    ),

                                                                                                                    SizedBox(height: 30.h,),
                                                                                                                    commonText(title: "Company Name",color: Colors.white70,fontSize: 30.sp),
                                                                                                                    TextFormField(
                                                                                                                      decoration: InputDecoration(hintText: "Company Name", hintStyle: TextStyle(color: Colors.white70)),
                                                                                                                      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                                                      controller: controller.compNameController,
                                                                                                                    ),

                                                                                                                    SizedBox(height: 30.h,),
                                                                                                                    commonText(title: "Batch Number",color: Colors.white70,fontSize: 30.sp),
                                                                                                                    TextFormField(
                                                                                                                      decoration: InputDecoration(hintText: "Batch Number", hintStyle: TextStyle(color: Colors.white70)),
                                                                                                                      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                                                      controller: controller.batchController,
                                                                                                                    ),

                                                                                                                    SizedBox(height: 30.h,),
                                                                                                                    commonText(title: "Quantity",color: Colors.white70,fontSize: 30.sp),
                                                                                                                    TextFormField(
                                                                                                                      decoration: InputDecoration(hintText: "Quantity", hintStyle: TextStyle(color: Colors.white70)),
                                                                                                                      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                                                      controller: controller.qtyController,
                                                                                                                    ),

                                                                                                                    SizedBox(height: 30.h,),
                                                                                                                    commonText(title: "MFG Date",color: Colors.white70,fontSize: 30.sp),
                                                                                                                    TextFormField(
                                                                                                                      decoration: InputDecoration(hintText: "MFG Date", hintStyle: TextStyle(color: Colors.white70)),
                                                                                                                      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                                                      controller: controller.mfgDateController,
                                                                                                                    ),

                                                                                                                    SizedBox(height: 30.h,),
                                                                                                                    commonText(title: "Expire Date",color: Colors.white70,fontSize: 30.sp),
                                                                                                                    TextFormField(
                                                                                                                      decoration: InputDecoration(hintText: "Expire Date", hintStyle: TextStyle(color: Colors.white70)),
                                                                                                                      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                                                      controller: controller.expireDateController,
                                                                                                                    ),


                                                                                                                    SizedBox(height: 30.h,),
                                                                                                                    commonText(title: "TP Rate",color: Colors.white70,fontSize: 30.sp),
                                                                                                                    TextFormField(
                                                                                                                      decoration: InputDecoration(hintText: "TP Rate", hintStyle: TextStyle(color: Colors.white70)),
                                                                                                                      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                                                      controller: controller.tPRateController,
                                                                                                                    ),

                                                                                                                    SizedBox(height: 30.h,),
                                                                                                                    commonText(title: "Pack Disc",color: Colors.white70,fontSize: 30.sp),
                                                                                                                    TextFormField(
                                                                                                                      decoration: InputDecoration(hintText: "Pack Disc", hintStyle: TextStyle(color: Colors.white70)),
                                                                                                                      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)),
                                                                                                                      controller: controller.packDiscController,
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
                                                                                                    controller.updateBool == false ?
                                                                                                    Padding(
                                                                                                          padding: EdgeInsets.symmetric(horizontal: 50.w),
                                                                                                          child: Container(
                                                                                                            height: 100.h,
                                                                                                            width: Get.size.width,
                                                                                                            decoration: BoxDecoration(
                                                                                                                color: Colors.blue,
                                                                                                                borderRadius: BorderRadius.circular(20.r)),
                                                                                                            child:
                                                                                                            GetBuilder<ProductController>(

                                                                                                              builder: (controller1) {
                                                                                                                return InkWell(
                                                                                                                  onTap:
                                                                                                                      () {
                                                                                                                    controller1.updateProduct(
                                                                                                                        controller1.snapshotOFSearchProduct.docs[index]['id']
                                                                                                                    );
                                                                                                                  },
                                                                                                                  child: Center(
                                                                                                                      child:
                                                                                                                      Text("Update Product Details", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)))),
                                                                                                                );
                                                                                                              }
                                                                                                            ),
                                                                                                          ),
                                                                                                        )
                                                                                                        : CircularProgressIndicator()
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                    }
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
                                                                              return GetBuilder<ProductController>(

                                                                                builder: (controller) {
                                                                                  return Padding(
                                                                                          padding:  EdgeInsets.symmetric(horizontal: 300.w),
                                                                                          child: AlertDialog(
                                                                                            scrollable: true,
                                                                                            shape: RoundedRectangleBorder(
                                                                                                borderRadius: BorderRadius.all( Radius.circular(15))),
                                                                                            backgroundColor: Colors.indigo,
                                                                                            content: Column(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              children: [
                                                                                                SizedBox(height: 30.h,),
                                                                                                commonText(title: "Delete Product:",fontWidget: FontWeight.w700,color: Colors.orange,fontSize: 60.sp),
                                                                                                SizedBox(height:60.h,),
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                                  children: [
                                                                                                    commonText(title: "Are You Sure You Want To Delete This Product:",fontWidget: FontWeight.w200,color: Colors.white,fontSize: 45.sp),
                                                                                                  ],
                                                                                                ),
                                                                                                SizedBox(height: 60.h,),

                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    // --- Cancel button ---
                                                                                                    InkWell(
                                                                                                        onTap:() {
                                                                                                          Get.back();
                                                                                                        },
                                                                                                        child: commonText(title: "Cancel",fontSize: 50.sp,fontWidget: FontWeight.w600,color: Colors.white)),

                                                                                                    // --- Delete button ---
                                                                                                  controller.deleteBool == false ?
                                                                                                    InkWell(
                                                                                                      onTap: () {
                                                                                                        controller.deleteProduct(
                                                                                                            controller.snapshotOFSearchProduct.docs[index]['id']
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
                                                                                                              child: commonText(title: "Delete Product", fontWidget: FontWeight.bold,fontSize: 40.sp)),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ) : CircularProgressIndicator()
                                                                                                  ],
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                }
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

                            ],);
                         }
                       ) :  Container()
                    ],);
                  }
                ),

              ),),
          )

    );
  }
}