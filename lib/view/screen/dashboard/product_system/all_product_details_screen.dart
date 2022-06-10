import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_store/constants/constant.dart';
import 'package:medical_store/controller/product_controller.dart';
import 'package:medical_store/view/screen/dashboard/product_system/search_product_screen.dart';
import 'package:medical_store/view/widget/common_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProductDetailsScreen extends StatelessWidget{
  final ProductController _productController = Get.put(ProductController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:commonText(title: "All Product Details:", fontWidget: FontWeight.bold,fontSize: 70.sp,color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 50.w),
          child: Column(
            children: [
              SizedBox(height: 50.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText(
                    title: "All Product Details",
                    color: Colors.black,
                    fontSize: 65.sp
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(() => SearchProductScreen());
                    },
                    child: Container(
                      height: 130.h,
                      width: 250.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          border: Border.all(width: 1)
                      ),
                      child: Row(children: [
                        SizedBox(width: 10.w,),
                        Icon(CupertinoIcons.search),
                        SizedBox(width: 20.w,),
                        commonText(title: "Search Product")
                      ],),
                    ),
                  )
                ],),
              SizedBox(height: 80.h,),
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
              Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: _productController.productDataList.length,
                      itemBuilder: (context, index) {
                      return  Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        border:  TableBorder(
                          bottom: BorderSide(color: Colors.black, width: 1),
                          // right: BorderSide(color: Colors.black, width: 1),
                          // left: BorderSide(color: Colors.black, width: 1),
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
                                              title: _productController.productDataList[index].productName,
                                              color: Colors.black,
                                              fontSize: 40.sp,
                                              fontWidget: FontWeight.w400)),
                                    )),
                                TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                      child: Center(
                                          child: commonText(
                                              title: _productController.productDataList[index].companyName,
                                              color: Colors.black,
                                              fontSize: 40.sp,
                                              fontWidget: FontWeight.w400)),
                                    )),
                                TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                      child: Center(
                                          child: commonText(
                                              title: _productController.productDataList[index].batch,
                                              color: Colors.black,
                                              fontSize: 40.sp,
                                              fontWidget: FontWeight.w400)),
                                    )),
                                TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                      child: Center(
                                          child: commonText(
                                              title: _productController.productDataList[index].quantity,
                                              color: Colors.black,
                                              fontSize: 40.sp,
                                              fontWidget: FontWeight.w400)),
                                    )),
                                TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                      child: Center(
                                          child: commonText(
                                              title: _productController.productDataList[index].mfgDate,
                                              color: Colors.black,
                                              fontSize: 40.sp,
                                              fontWidget: FontWeight.w400)),
                                    )),
                                TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                      child: Center(
                                          child: commonText(
                                              title: _productController.productDataList[index].expireDate,
                                              color: Colors.black,
                                              fontSize: 40.sp,
                                              fontWidget: FontWeight.w400)),
                                    )),
                                TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                      child: Center(
                                          child: commonText(
                                              title: _productController.productDataList[index].tPRate,
                                              color: Colors.black,
                                              fontSize: 40.sp,
                                              fontWidget: FontWeight.w400)),
                                    )),
                                TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                      child: Center(
                                          child: commonText(
                                              title: _productController.productDataList[index].packValue,
                                              color: Colors.black,
                                              fontSize: 40.sp,
                                              fontWidget: FontWeight.w400)),
                                    )),
                                TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                      child: Center(
                                          child: commonText(
                                              title: _productController.productDataList[index].packDisc,
                                              color: Colors.black,
                                              fontSize: 40.sp,
                                              fontWidget: FontWeight.w400)),
                                    )),
                                TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                      child: Center(
                                          child: commonText(
                                              title: _productController.productDataList[index].netTotal,
                                              color: Colors.black,
                                              fontSize: 40.sp,
                                              fontWidget: FontWeight.w400)),
                                    )),
                                TableCell(
                                    child: Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                      child: Center(
                                          child: commonText(
                                              title: _productController.productDataList[index].datetime,
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
                                           _productController.prodNameController.text =
                                               _productController.productDataList[index].productName;

                                           _productController.compNameController.text =
                                               _productController.productDataList[index].companyName;

                                           _productController.batchController.text =
                                               _productController.productDataList[index].batch;

                                           _productController.qtyController.text =
                                               _productController.productDataList[index].quantity;

                                           _productController.mfgDateController.text =
                                               _productController.productDataList[index].mfgDate;

                                           _productController.expireDateController.text =
                                               _productController.productDataList[index].expireDate;

                                           _productController.tPRateController.text =
                                               _productController.productDataList[index].tPRate;

                                           _productController.packDiscController.text =
                                               _productController.productDataList[index].packDisc;

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
                                                                     key: controller.updateProductDialogFormKey,
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
                                                                   InkWell(
                                                                     onTap:
                                                                         () {
                                                                       controller.updateProduct(
                                                                         _productController.productDataList[index].id,
                                                                       );
                                                                     },
                                                                     child: Center(
                                                                         child:
                                                                         Text("Update Product Details", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)))),
                                                                   ),
                                                                 ),
                                                               )
                                                             : CircularProgressIndicator()
                                                             ],
                                                           ),
                                                         ),
                                                       );
                                                     });
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
                                                                      InkWell(
                                                                          onTap:() {
                                                                            Get.back();
                                                                              },
                                                                          child: commonText(title: "Cancel",fontSize: 50.sp,fontWidget: FontWeight.w600,color: Colors.white)),
                                                                      // --- Delete button ---
                                                                      controller.deleteBool == false ?
                                                                        InkWell(
                                                                        onTap: () {
                                                                             controller.deleteProduct(_productController.productDataList[index].id);
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
                                                                      )
                                                                          : CircularProgressIndicator()
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}