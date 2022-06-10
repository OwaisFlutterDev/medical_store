// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:medical_store/controller/pdf_controller.dart';
//
// import 'package:universal_html/html.dart' as html;
//
// class PdfDemo extends StatelessWidget {
//   final PdfController _pdfController = Get.put(PdfController());
//
//   @override
//   Widget build(BuildContext context) {
//     _pdfController.myGetBlobPdfContent();
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             RaisedButton(
//               child: Text("Open"),
//               onPressed: () async {
//                 final url = html.Url.createObjectUrlFromBlob(
//                     await _pdfController.myGetBlobPdfContent());
//                 html.window.open(url, "_blank");
//                 html.Url.revokeObjectUrl(url);
//               },
//             ),
//             RaisedButton(
//               child: Text("Download"),
//               onPressed: () async {
//                 final url = html.Url.createObjectUrlFromBlob(
//                     await _pdfController.myGetBlobPdfContent());
//                 final anchor =
//                 html.document.createElement('a') as html.AnchorElement
//                   ..href = url
//                   ..style.display = 'none'
//                   ..download = 'some_name.pdf';
//                 html.document.body.children.add(anchor);
//                 anchor.click();
//                 html.document.body.children.remove(anchor);
//                 html.Url.revokeObjectUrl(url);
//               },
//             ),
//           ],
//           mainAxisAlignment: MainAxisAlignment.center,
//         ),
//       ),
//     );
//   }
// }