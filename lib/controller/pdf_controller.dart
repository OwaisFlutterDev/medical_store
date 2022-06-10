import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medical_store/controller/invoice_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;


class PdfController extends GetxController{


  // ---------- onInit() ------------
  @override
  void onInit() {
    super.onInit();
    // makePdf();
    //  createPDF();
  }

  Future<html.Blob> myGetBlobPdfContent() async {
    final InvoiceController _invoiceController = Get.put(InvoiceController());

    var data =  await rootBundle.load("assets/Roboto-Regular.ttf");
    pw.Font fontQ = pw.Font.ttf(data);

    var myStyle = pw.TextStyle(font: fontQ, fontSize: 36.0);

    final imageJpeg = (await rootBundle.load('assets/new_logo.jpeg')).buffer.asUint8List();

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(

        pageFormat: PdfPageFormat(7 * PdfPageFormat.cm, 17 * PdfPageFormat.cm, marginAll: 0.5 * PdfPageFormat.cm),
        build: (pw.Context context) =>  [
          pw.Center(child:  pw.Image(pw.MemoryImage(imageJpeg),height: 140,width: 140,fit: pw.BoxFit.scaleDown),),
          pw.SizedBox(height: 6),
          pw.Center(child: pw.Text('NEAR WOMEN AND CHILDREN HOSPITAL KARAK', style: pw.TextStyle(font: fontQ, fontSize: 7.0,),textAlign: pw.TextAlign.center),),
          pw.Center(child: pw.Text('03359006021', style: pw.TextStyle(font: fontQ, fontSize: 7.0)),),
          // Thanks for visiting
          // Hassan pharmacy
          pw.SizedBox(height: 9),
          //--- ====  invoice id ==== ---
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                  pw.Text(
                    "Invoice ID:",
                    style: pw.TextStyle(font: fontQ, fontSize: 7.0,),
                  ),
                  pw.Text(
                      "    ${_invoiceController.id}",
                    style: pw.TextStyle(font: fontQ, fontSize: 7.5,),
                  ),
          ]),
          pw.SizedBox(height: 1),
          //--- ====  date ==== ---
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "Date:",
                  style: pw.TextStyle(font: fontQ, fontSize: 7.0,),
                ),
                pw.Text(
                  "    ${_invoiceController.dateForPdfBIll}",
                  style: pw.TextStyle(font: fontQ, fontSize: 7.5,),
                ),
              ]),
          pw.SizedBox(height: 1),


          pw.Divider(),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('S.NO', style: pw.TextStyle(font: fontQ, fontSize: 7,fontWeight: pw.FontWeight.bold)),
                pw.Text('-', style: pw.TextStyle(font: fontQ, fontSize: 7,)),
                pw.Text('P-Name', style: pw.TextStyle(font: fontQ, fontSize: 7.0,fontWeight: pw.FontWeight.bold)),
                pw.Text('-', style: pw.TextStyle(font: fontQ, fontSize: 7,)),
                pw.Text('P-Price', style: pw.TextStyle(font: fontQ, fontSize: 7,fontWeight: pw.FontWeight.bold)),
                pw.Text('-', style: pw.TextStyle(font: fontQ, fontSize: 7,)),
                pw.Text('Qty', style: pw.TextStyle(font: fontQ, fontSize: 7,fontWeight: pw.FontWeight.bold)),
                pw.Text('-', style: pw.TextStyle(font: fontQ, fontSize: 7,)),
                pw.Text('T-Price', style: pw.TextStyle(font: fontQ, fontSize: 7,fontWeight: pw.FontWeight.bold)),
              ]),
          // pw.Divider(),
          pw.SizedBox(height: 1),
          pw.ListView.builder(
              itemCount: _invoiceController.invoiceDataList.length,
              itemBuilder: (context, index) {
                return pw.Column(children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text("$index", style: pw.TextStyle(font: fontQ, fontSize: 6.0,fontWeight: pw.FontWeight.bold)),
                        ]),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(_invoiceController.invoiceDataList[index].prodName,
                                  style: pw.TextStyle(font: fontQ, fontSize: 6.0,fontWeight: pw.FontWeight.bold)),
                                ]),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(_invoiceController.invoiceDataList[index].prodPrice,
                                  style: pw.TextStyle(font: fontQ, fontSize: 6.0,fontWeight: pw.FontWeight.bold)),
                            ]),

                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(_invoiceController.invoiceDataList[index].qty,
                                  style: pw.TextStyle(font: fontQ, fontSize: 6.0,fontWeight: pw.FontWeight.bold)),
                            ]),

                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(_invoiceController.invoiceDataList[index].totalPrice,
                                  style: pw.TextStyle(font: fontQ, fontSize: 6.0,fontWeight: pw.FontWeight.bold)),
                            ]),
                            ]),
                ],);
              },
              ),

          pw.Divider(),
          // --===============-----=-=--- sub total ---=-=-----==============--
          pw.SizedBox(height: 1),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  "Sub Total:     ",
                  style: pw.TextStyle(font: fontQ, fontSize: 7.0,),
                ),
                pw.Text(
                  "    ${_invoiceController.sumOfTotalInvoice}",
                  style: pw.TextStyle(font: fontQ, fontSize: 7.0,),
                ),
              ]),
          // pw.Divider(),
          // --===============-----=-=--- Disc ---=-=-----==============--
          pw.SizedBox(height: 1),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  "Disc:     ",
                  style: pw.TextStyle(font: fontQ, fontSize: 7.0,),
                ),
                pw.Text(
                  "    ${_invoiceController.discText}",
                  style: pw.TextStyle(font: fontQ, fontSize: 7.0,),
                ),
              ]),
          pw.Divider(),
          // --===============-----=-=--- grand total ---=-=-----==============--
          pw.SizedBox(height: 1),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  "Grand Total:     ",
                  style: pw.TextStyle(font: fontQ, fontSize: 8.0,),
                ),
                pw.Text(
                  "    ${_invoiceController.grandTotal}",
                  style: pw.TextStyle(font: fontQ, fontSize: 8.0,),
                ),
              ]),

          pw.Divider(),

          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  "Thanks for visiting",
                  style: pw.TextStyle(font: fontQ, fontSize: 5.7,),
                ),
          ]),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [

                pw.Text(
                  "Hassan pharmacy",
                  style: pw.TextStyle(font: fontQ, fontSize: 5.7,),
                ),
              ])
        ],
      ),
    );
    final bytes = await pdf.save();
    html.Blob blob = html.Blob([bytes], 'application/pdf');
    return blob;
  }

}