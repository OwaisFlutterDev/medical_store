import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_store/controller/form_validation_controller.dart';
import 'package:medical_store/model/invoice_model.dart';
import 'package:intl/intl.dart';

class InvoiceController extends GetxController{

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("invoice");

  RxList<InvoiceModel> invoiceDataList = RxList<InvoiceModel>([]);

  TextEditingController discController;

  // ---------- onInit() ------------
  @override
  void onInit() {
    super.onInit();
    discController = TextEditingController();

    invoiceDataList.bindStream(getAllInvoiceData());
    getSumOfTotalInvoice();
  }

  // ==============================================================================
  // -------------- ===========    Add Invoice data to Firestore    ========== --------------
  //         =========================================================================
  bool addNewBillBool = false;

  Future addNewBill() async{

    addNewBillBool = true;
    update();

    final FormValidationController _formValCon = Get.put(FormValidationController());

    try {
      var collection = FirebaseFirestore.instance.collection('product');
      var querySnapshot = await collection.where('productName', isEqualTo: _formValCon.productName.text.trim()).get();

      var prodId;
      var name;
      var qty;
      var prodPrice;
      var packDisc;


      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        prodId = data["id"];
        name = data['productName'];
        packDisc = data["packDisc"];
        qty = data['quantity'];
        prodPrice = data["tPRate"];
      }

      if ( name != null ) {
        var quantityInt = num.parse(qty);
        var quantityIntOfForm = num.parse(_formValCon.quantity.text);
        var prodPriceInt = num.parse(prodPrice);

        var netTotalValue = quantityIntOfForm * prodPriceInt;
        String totalPrice = "$netTotalValue";
        // print("Total Price of Bill: $totalPrice");

        // --- strings ---
        String prodIdString = "$prodId";
        String nameString = "$name";
        String prodPriceString = "$prodPrice";

        if (quantityInt >= quantityIntOfForm){

          var quantityForProduct = quantityInt - quantityIntOfForm;
          String  quantityForProductString = "$quantityForProduct";
          // print("Quantity Of Product : $quantityForProductString");
          var makePackValue = quantityForProduct * prodPriceInt;
          String packValue = "$makePackValue";
          // print("Pack Value: $packValue");

          var prodDiscInt = num.parse(packDisc);
          var netTotalValue = makePackValue - prodDiscInt;

          String netTotal = "$netTotalValue";
          // print("Net Total: $netTotal");

          // ----- Update Product Stock
          await FirebaseFirestore.instance.collection("product").doc(prodIdString).update({
            "quantity": quantityForProductString,
            "packValue": packValue,
            "netTotal": netTotal,
          });

          // ---------- ===== add to invoice ===== -----------
          final addInvoice = FirebaseFirestore.instance.collection("invoice").doc();
          await addInvoice.set({
            "id": addInvoice.id,
            "prodName": nameString,
            "qty": _formValCon.quantity.text,
            "prodPrice": prodPriceString,
            "prodId": prodIdString,
            "totalPrice": totalPrice,
          });
          addNewBillBool = false;
          update();
          Get.snackbar(
            "Add Bill Notification",
            "Successfully Added the Bill",
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 5),
          );
          _formValCon.clearTextField();

          // ------ ======  Get Invoice Total Data  ===== ------
          getSumOfTotalInvoice();

        }
        else {
          addNewBillBool = false;
          update();

          Get.snackbar(
              "Add Bill Notification",
              "Field To Add Bill Data, Product Is Currently Out Of Stock And Unavailable",
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 5),
              icon: Icon(Icons.warning_rounded,color: Colors.red,)
          );
        }
      } else {
        addNewBillBool = false;
        update();

        Get.snackbar(
            "Add Bill Notification",
            "Field To Add Bill Data, Check Your Product Name",
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 5),
            icon: Icon(Icons.warning_rounded,color: Colors.red,)
        );
      }

    }
    catch (error){
      addNewBillBool = false;
      update();
      print("$error");
    }
  }

  // ==============================================================================
  // -------------- ===========    Get All Invoice Data from Firestore    ========== --------------
  //         =========================================================================


  Stream<List<InvoiceModel>> getAllInvoiceData() => collectionReference.snapshots().map((query) =>
      query.docs.map((item) => InvoiceModel.fromDocumentSnapshot(item)).toList());

  // ==============================================================================
  // -------------- ===========    Clear Invoice (Delete All Doc from Invoice Firestore)   ========== --------------
  //         =========================================================================
  bool clearInvoiceBool = false;
  Future clearInvoice() async{
    clearInvoiceBool = true;
    update();
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection('invoice');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
      getSumOfTotalInvoice();
      clearInvoiceBool = false;
      update();
  }
    //  Done with help of StakeOver FLow Site.
    //  Link: https://stackoverflow.com/questions/53089517/how-to-delete-all-documents-in-collection-in-firestore-with-flutter

  // ==============================================================================
  // -------------- ===========    Delete Invoice Record    ========== --------------
  //         =========================================================================
  bool deleteInvoiceRecordBool = false;
  Future deleteInvoiceRecord(String invoiceID,String prodID, String givenQty, ) async{

    deleteInvoiceRecordBool = true;
    update();

    successMsg(){
      Get.back();
      Get.snackbar(
        "Delete Invoice Record Notification",
        "The Invoice Record is Deleted Successfully And Added Back To Product Stock: ",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
      );
    }

    try {

    //  -------------- ========= add back the data to product stock ========== --------------

      // ---- get same product data for update ----
      var collectionProd = FirebaseFirestore.instance.collection('product');
      var querySnapshot = await collectionProd.where('id', isEqualTo: prodID).get();

      var oldQty;
      var prodPrice;
      var oldNetTotal;
      var oldPackValue;

      for (var queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        oldQty = data['quantity'];
        prodPrice = data["tPRate"];
        oldPackValue = data["packValue"];
        oldNetTotal = data["netTotal"];
      }

      // ---- convert to int & apply operation -----
      var oldQtyInt = num.parse(oldQty);
      var givenQtyInt = num.parse(givenQty);
      var prodPriceInt = num.parse(prodPrice);
      var oldPackValueInt = num.parse(oldPackValue);
      var oldNetTotalInt = num.parse(oldNetTotal);

      var newQtyInt = oldQtyInt + givenQtyInt;
      String newQtyIntString = "$newQtyInt";
      // print("New Qty Int: $newQtyIntString");

      var addBackTotal = prodPriceInt * givenQtyInt;
      String addBackTotalString = "$addBackTotal";
      // print("add Back Total: $addBackTotalString");
      //
      var newPackValue = addBackTotal + oldPackValueInt;
      String newPackValueString = "$newPackValue";
      // print("new Pack Value: $newPackValueString");

      var newNetTotal = addBackTotal + oldNetTotalInt;
      String newNetTotalString = "$newNetTotal";
      // print("new Net Total: $newNetTotalString");

      // ------ ===== Update data to bill system ====== ------
      await FirebaseFirestore.instance.collection("product").doc(prodID).update({
        "quantity": newQtyIntString,
        "packValue": newPackValueString,
        "netTotal": newNetTotalString,
      });

      //  -------------- ========= delete from invoice ========== --------------
      final invoiceCollection = FirebaseFirestore.instance.collection('invoice');
      await invoiceCollection
          .doc(invoiceID)
          .delete()
          .then((_) => successMsg())
          .catchError((error) => print('Delete failed: $error'));

      deleteInvoiceRecordBool = false;
      update();

      //   ------ ======  Get Invoice Total Data  ===== ------
      getSumOfTotalInvoice();

    }
    catch (error){

      deleteInvoiceRecordBool = false;
      update();

      Get.snackbar(
        "Delete Invoice Record Notification",
        "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

  // ==============================================================================
  // -------------- ===========    Get Sum Of Total Invoice     ========== --------------
  //       =========================================================================
  var sumOfTotalInvoice = 0;

  Future getSumOfTotalInvoice() async {
    collectionReference.get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) async  {
          num value =  num.parse(element.get('totalPrice').toString());
          sumOfTotalInvoice = sumOfTotalInvoice + value;
          print(value);
          update();
        });
    print(sumOfTotalInvoice);
    });
  }

  // ==============================================================================
  // -------------- ===========    Get Sum Of Total Invoice     ========== --------------
  //       =========================================================================
  var grandTotal = 0;
  var discText ;
  bool makeGrandTotalBool = false;
  String id;
  String dateForPdfBIll = "${DateFormat("dd-MM-yyyy").format(DateTime.now())}";


  Future makeGrandTotal() async{

    makeGrandTotalBool =   true;
    update();

    var discControllerText = int.parse(discController.text.isNotEmpty ? discController.text : "0");
     print("discContText = $discControllerText");

    var makeDisc =  sumOfTotalInvoice / 100 * discControllerText ;
    var makeDiscInt = makeDisc.toInt();

    discText = makeDiscInt ?? 0;

    print("Disc $makeDisc");

    grandTotal = sumOfTotalInvoice - makeDiscInt;
    var grandTotalCollection = FirebaseFirestore.instance.collection("GrandTotal").doc();

    try{

      if(grandTotal != 0 ) {

        await grandTotalCollection.set({
          "id": grandTotalCollection.id,
          "subTotal": sumOfTotalInvoice.toString(),
          "disc": makeDiscInt.toString() ?? "0",
          "grandTotal": grandTotal.toString(),
          "day": DateFormat("dd-MM-yyyy").format(DateTime.now()),
          "month": DateFormat("MM-yyyy").format(DateTime.now()),
          "year": DateFormat("yyyy").format(DateTime.now()),
        });
        id = grandTotalCollection.id;
        print("Grand Add Successfully ");

        makeGrandTotalBool =   false;
        update();

      } else  {
        print("Grand Total is Zero");
        makeGrandTotalBool =   false;
        update();
      }

    }

    catch (e) {
       print(e);
       makeGrandTotalBool =   false;
       update();
    }

  }

}