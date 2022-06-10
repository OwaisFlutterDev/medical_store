import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_store/constants/constant.dart';
import 'package:medical_store/constants/validation_constant.dart';
import 'package:medical_store/controller/form_validation_controller.dart';
import 'package:medical_store/controller/invoice_controller.dart';
import 'package:medical_store/controller/pdf_controller.dart';
import 'package:medical_store/view/screen/pdf_invoice.dart';
import 'package:medical_store/view/widget/common_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universal_html/html.dart' as html;

class MakeNewInvoiceScreen extends StatelessWidget{

  final FormValidationController  _formValidationController = Get.put(FormValidationController());
  final InvoiceController _invoiceController = Get.put(InvoiceController());
  final PdfController _pdfController = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:commonText(title: "Make New Invoice:", fontWidget: FontWeight.bold,fontSize: 70.sp,color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 45.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h,),
              GetBuilder<InvoiceController>(
                init: InvoiceController(),
                builder: (controller) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 50.w),
                    child: Column(
                      children: [
                        Form(
                          key: _formValidationController.enterNewbillFormKey,
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
                              SizedBox(height: 40.h,),
                              commonText(title: "   Quantity",fontSize: 30.sp),
                              SizedBox(height: 8.h,),
                              commonTextFormField(
                                  hintText: "Quantity",
                                  controller: _formValidationController.quantity,
                                  validator: ValidationConstant.commonValidator
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 100.h,),

                       controller.addNewBillBool == false  ?  commonButton(
                            buttonName: "Add To Invoice",
                            onTap: (){

                              _formValidationController.enterNewbillFormKey.currentState.save();
                              if(_formValidationController.enterNewbillFormKey.currentState.validate()){
                               controller.addNewBill();
                               // ----- ====  === -----
                               _invoiceController.sumOfTotalInvoice = 0;
                               print(_invoiceController.sumOfTotalInvoice);
                              }
                              else{
                                Get.snackbar(
                                  "Add Bill Notification",
                                  "Please Fill All The Fields",
                                  snackPosition: SnackPosition.TOP,
                                  duration: Duration(seconds: 5),
                                );
                              }
                            }
                        ) : CircularProgressIndicator(),
                        SizedBox(height: 120.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonText(title: "  Invoice:",color: Colors.greenAccent,fontSize: 60.sp,fontWidget: FontWeight.w600),
                            controller.clearInvoiceBool == false ?
                               GestureDetector(
                                onTap: (){},
                                onDoubleTap:  () {
                                  _invoiceController.sumOfTotalInvoice = 0;
                                  _invoiceController.discController.text = "0";
                                  _invoiceController.grandTotal = 0;
                                  _invoiceController.clearInvoice();
                                },
                                child: Container(
                                    height: 100.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50.r),
                                        color: blueColor
                                    ),
                                    child: Center(child: commonText(title: "Clear Invoice:",color: Colors.black,fontSize: 45.sp,fontWidget: FontWeight.w400))))
                                : CircularProgressIndicator()
                          ],
                        ),
                        SizedBox(height: 30.h,),
                        // --------- ====== invoice ====== -------
                        Table(
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          border:  TableBorder(
                            top: BorderSide(color: Colors.black, width: 1),
                            // horizontalInside: BorderSide(color: Colors.red, width: 2),
                          ),
                          columnWidths: {
                            0: FlexColumnWidth(0.15),
                            1: FlexColumnWidth(0.5),
                            2: FlexColumnWidth(0.2),
                            3: FlexColumnWidth(0.3),
                            4: FlexColumnWidth(0.3),
                            5: FlexColumnWidth(0.3),
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
                                              title: "Description",
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
                                              title: "Rate",
                                              color: blueColor,
                                              fontWidget: FontWeight.w500))),
                                  TableCell(

                                      child: Center(
                                          child: commonText(
                                              title: "Total",
                                              color: blueColor,
                                              fontWidget: FontWeight.w500))),
                                  TableCell(

                                      child: Center(
                                          child: commonText(
                                              title: "Remove",
                                              color: blueColor,
                                              fontWidget: FontWeight.w500))),
                                ]),
                          ],
                        ),
                        // ------- ========= Invoice Data ======== -------
                        Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: _invoiceController.invoiceDataList.length,
                                itemBuilder: (context, index) {
                                  return  Table(
                                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                    border:  TableBorder(
                                      bottom: BorderSide(color: Colors.black, width: 1),
                                      top: BorderSide(color: Colors.black, width: 1),
                                    ),
                                    columnWidths: {
                                      0: FlexColumnWidth(0.15),
                                      1: FlexColumnWidth(0.5),
                                      2: FlexColumnWidth(0.2),
                                      3: FlexColumnWidth(0.3),
                                      4: FlexColumnWidth(0.3),
                                      5: FlexColumnWidth(0.3),
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
                                                          title: _invoiceController.invoiceDataList[index].prodName,
                                                          color: Colors.black,
                                                          fontSize: 40.sp,
                                                          fontWidget: FontWeight.w400)),
                                                )),
                                            TableCell(
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                  child: Center(
                                                      child: commonText(
                                                          title: _invoiceController.invoiceDataList[index].qty,
                                                          color: Colors.black,
                                                          fontSize: 40.sp,
                                                          fontWidget: FontWeight.w400)),
                                                )),
                                            TableCell(
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                  child: Center(
                                                      child: commonText(
                                                          title: _invoiceController.invoiceDataList[index].prodPrice,
                                                          color: Colors.black,
                                                          fontSize: 40.sp,
                                                          fontWidget: FontWeight.w400)),
                                                )),
                                            TableCell(
                                                child: Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical:15.h),
                                                  child: Center(
                                                      child: commonText(
                                                          title:_invoiceController.invoiceDataList[index].totalPrice,
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

                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext context) {
                                                                return GetBuilder<InvoiceController>(
                                                                    init: InvoiceController(),
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
                                                                              Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  commonText(title: "Are You Sure: ",fontWidget: FontWeight.w700,color: Colors.orange,fontSize: 50.sp),
                                                                                  SizedBox(height: 20.h,),
                                                                                  commonText(title: "The Data Will Be Remove From The Invoice List and It Will Automatically Add Back To Stock:",color: Colors.white,fontSize: 40.sp),
                                                                                  SizedBox(height: 140.h,),

                                                                                ],
                                                                              ),

                                                                              // --- update button ---
                                                                              Padding(
                                                                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                                                                child: Row(
                                                                                  children: [
                                                                                    InkWell(
                                                                                        onTap: () => Get.back(),
                                                                                        child: commonText(title: "Cancel")),
                                                                                    SizedBox(width: 50.w,),
                                                                                    controller.deleteInvoiceRecordBool == false ?
                                                                                       Container(
                                                                                      height: 100.h,
                                                                                      width: 150.w,
                                                                                      decoration: BoxDecoration(
                                                                                          color: Colors.blue,
                                                                                          borderRadius: BorderRadius.circular(20.r)),
                                                                                      child:
                                                                                      InkWell(
                                                                                        onTap:
                                                                                            () {
                                                                                          controller.deleteInvoiceRecord(
                                                                                              controller.invoiceDataList[index].id,
                                                                                              controller.invoiceDataList[index].prodId,
                                                                                              controller.invoiceDataList[index].qty
                                                                                          );
                                                                                          _invoiceController.sumOfTotalInvoice = 0;
                                                                                        },
                                                                                        child: Center(
                                                                                            child:
                                                                                            Text("Remove", style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 42.sp, color: Colors.white)))),
                                                                                      ),
                                                                                    )
                                                                                        : CircularProgressIndicator(),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                              });

                                                          print("Remove button clicked");
                                                        },
                                                        child: Icon(
                                                          CupertinoIcons.minus_circle_fill,
                                                          color: Colors.red,
                                                          size: 46.r,
                                                        )),

                                                  ]),
                                            )
                                          ]),
                                    ],
                                  );
                              }),
                        ),
                        SizedBox(height: 140.h,),
                        GetBuilder<InvoiceController>(
                          init: InvoiceController(),
                          builder: (controller) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  // ----- === sub Total === -----
                                  Divider(),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      commonText(title: "Sub Total: ", fontSize: 50.sp, fontWidget: FontWeight.w500,),
                                      SizedBox(width: 180.w,),
                                      commonText(title: " ${controller.sumOfTotalInvoice}",
                                          fontSize: 60.sp,fontWidget: FontWeight.w700,  color: Colors.red),
                                      SizedBox(width: 15.w,),
                                    ],
                                  ),

                                  // ----- === disc in % === -----
                                  Divider(),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      commonText(title: "Disc in %",fontSize: 50.sp, fontWidget: FontWeight.w500,),
                                      SizedBox(width: 150.w,),
                                      Container(
                                        height: 70.h,
                                        width: 70.w,
                                        child: commonTextFormField(
                                            controller: _invoiceController.discController
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),

                                  // ----- === Net Total === -----
                                  Divider(),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () => controller.makeGrandTotal(),
                                        child: Container(
                                          height: 100.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50.r),
                                          color: blueColor
                                          ),
                                            child: Center(child: commonText(title: "Make Grand Total:",
                                                          color: Colors.black,fontSize: 45.sp,fontWidget: FontWeight.w400))
                                        ),
                                      ),
                                      SizedBox(width: 100.w,),
                                      controller.makeGrandTotalBool == false ? commonText(title: " ${controller.grandTotal}",
                                          fontSize: 60.sp,fontWidget: FontWeight.w700,  color: Colors.red) : CircularProgressIndicator(),
                                      SizedBox(width: 15.w,),


                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Divider(),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      InkWell(
                                        onTap: () async {
                                          final url = html.Url.createObjectUrlFromBlob(
                                              await _pdfController.myGetBlobPdfContent());
                                          final anchor =
                                          html.document.createElement('a') as html.AnchorElement
                                            ..href = url
                                            ..style.display = 'none'
                                            ..download = 'some_name.pdf';
                                          html.document.body.children.add(anchor);
                                          anchor.click();
                                          html.document.body.children.remove(anchor);
                                          html.Url.revokeObjectUrl(url);
                                        },
                                        child: Container(
                                            height: 100.h,
                                            width: 150.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50.r),
                                                color: blueColor
                                            ),
                                            child: Center(child: commonText(title: "Download Invoice ",
                                                color: Colors.black,fontSize: 45.sp,fontWidget: FontWeight.w400))
                                        ),
                                      ),

                                      SizedBox(width: 100,),

                                      InkWell(
                                        onTap: () async {
                                          final url = html.Url.createObjectUrlFromBlob(
                                              await _pdfController.myGetBlobPdfContent());
                                          html.window.open(url, "_blank");
                                          html.Url.revokeObjectUrl(url);
                                        },
                                        child: Container(
                                            height: 100.h,
                                            width: 150.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50.r),
                                                color: blueColor
                                            ),
                                            child: Center(child: commonText(title: "Print Invoice",
                                                color: Colors.black,fontSize: 45.sp,fontWidget: FontWeight.w400))
                                        ),
                                      ),


                                    ],
                                  ),



                                ],
                              );
                          }
                        ),
                        SizedBox(height: 200.h,),

                      ],
                    ),
                  );
                }
              )

            ],
          ),
        ),
      ),
    );
  }
}