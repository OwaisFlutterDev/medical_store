import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_store/controller/form_validation_controller.dart';
import 'package:intl/intl.dart';

class GrandTotalController extends GetxController{

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("GrandTotal");

  //   ----- ========== Global Key ========== -----
  final GlobalKey<FormState> addStockFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateByIdForSearchFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateByDateForSearchFormKey = GlobalKey<FormState>();

  TextEditingController subTotalController = new TextEditingController();
  TextEditingController discController = new TextEditingController();

// ==============================================================================
// -------------- ===========    Search Product By Date    ========== --------------
//         ======================================================================

  QuerySnapshot snapshotOFByDate;
  bool searchBoolByDate = false;
  bool searchBoolButton = false;

  Future searchProductByDate(String date) async {

    searchBoolButton = true;
    update();

    try{
      await FirebaseFirestore.instance.collection('GrandTotal').where('day', isEqualTo: date).get().then((value) {
        snapshotOFByDate = value;
      });
      if(snapshotOFByDate.docs.isEmpty){
        Get.snackbar(
          "Search Invoice Notification",
          "Invoice Record Not Found...!",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 4),
        );
      }
      searchBoolButton = false;
      searchBoolByDate = true;
      update();
    }

    catch(e){
      searchBoolButton = false;
      update();
    }



  }

// ==============================================================================
// -------------- ===========    Search Product By Date    ========== --------------
//         ======================================================================

  QuerySnapshot snapshotOFById;
  bool searchBoolById = false;

  Future searchProductById(String id) async {
    searchBoolButton = true;
    update();

    try{
      await FirebaseFirestore.instance.collection('GrandTotal').where('id', isEqualTo: id).get().then((value) {
        snapshotOFById = value;
      });
      if(snapshotOFById.docs.isEmpty){
        Get.snackbar(
          "Search Invoice Notification",
          "Invoice Record Not Found...!",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 4),
        );
      }
      searchBoolButton = false;
      searchBoolById = true;
      // print("length ${snapshotOFSearchProduct.docs.length}");
      update();
    }

    catch(e){
      searchBoolButton = false;
      update();
    }

  }

// ==============================================================================
// -------------- ===========    Update Invoice By Date    ========== --------------
//         ======================================================================
  bool updateBool = false;
  Future updateProductByDate(String id) async {
    updateBool = true;
    update();
    final FormValidationController _formValidationController = Get.put(FormValidationController());

    var subTotalInt = num.parse(subTotalController.text);
    var discInt = num.parse(discController.text);

    var makeDisc =  subTotalInt / 100 * discInt ;
    var makeDiscInt = makeDisc.toInt();

    var makeGrandTotal = subTotalInt - makeDiscInt;

    successMsg(){
      Get.back();
      Get.snackbar(
        "Update Invoice Notification",
        "Successfully Update the Invoice Record",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }

    try {

      await FirebaseFirestore.instance.collection('GrandTotal').doc(id)
          .update(
          {
            "id": id,
            "subTotal": subTotalController.text,
            "disc": discController.text,
            "grandTotal": makeGrandTotal.toString(),
          }
      )
          .then((_) {successMsg();})
          .catchError((onError) => print(onError.toString()));
      searchProductByDate(_formValidationController.searchProductController.text);
      updateBool = false;
      update();

    }
    catch (error){
      updateBool = false;
      update();
      Get.snackbar(
        "Update Invoice Notification",
        "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }

  }

// ==============================================================================
// -------------- ===========    Update Invoice By Date    ========== --------------
//         ======================================================================

  Future updateProductById(String id) async {
    updateBool = true;
    update();
    final FormValidationController _formValidationController = Get.put(FormValidationController());

    var subTotalInt = num.parse(subTotalController.text);
    var discInt = num.parse(discController.text);

    var makeDisc =  subTotalInt / 100 * discInt ;
    var makeDiscInt = makeDisc.toInt();

    var makeGrandTotal = subTotalInt - makeDiscInt;

    successMsg(){
      Get.back();
      Get.snackbar(
        "Update Invoice Notification",
        "Successfully Update the Invoice Record",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }

    try {

      await FirebaseFirestore.instance.collection('GrandTotal').doc(id)
          .update(
          {
            "id": id,
            "subTotal": subTotalController.text,
            "disc": discController.text,
            "grandTotal": makeGrandTotal.toString(),
          }
      )
          .then((_) {successMsg();})
          .catchError((onError) => print(onError.toString()));
      searchProductById(_formValidationController.searchProductController.text);
      updateBool = false;
      update();

    }
    catch (error){
      updateBool = false;
      update();
      Get.snackbar(
        "Update Invoice Notification",
        "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }

  }

// ==============================================================================
  // -------------- ===========    Delete Product For Date  ========== --------------
  //         =========================================================================
  bool deleteBool = false;
  Future deleteProductForDate(String productID) async{
    deleteBool = true;
    update();
  final FormValidationController _formValidationController = Get.put(FormValidationController());

  successMsg(){
      Get.back();
      Get.snackbar(
        "Delete Invoice Notification",
        "The Invoice is Deleted Successfully: ",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
      );
    }

    try {

      final collection = FirebaseFirestore.instance.collection('GrandTotal');
      await collection
          .doc(productID) // <-- Doc ID to be deleted.
          .delete() // <-- Delete
          .then((_) => successMsg())
          .catchError((error) => print('Delete failed: $error'));
      searchProductByDate(_formValidationController.searchProductController.text);
      deleteBool = false;
      update();
    }
    catch (error){
      deleteBool = false;
      update();
      Get.snackbar(
        "Delete Invoice Notification",
        "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

  // ==============================================================================
  // -------------- ===========    Delete Product For Id  ========== --------------
  //         =========================================================================

  Future deleteProductForID(String productID) async{
    deleteBool = true;
    update();
    successMsg(){
      Get.back();
      Get.snackbar(
        "Delete Invoice Notification",
        "The Invoice is Deleted Successfully: ",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
      );
    }

    try {

      final collection = FirebaseFirestore.instance.collection('GrandTotal');
      await collection
          .doc(productID) // <-- Doc ID to be deleted.
          .delete() // <-- Delete
          .then((_) => successMsg())
          .catchError((error) => print('Delete failed: $error'));
      searchBoolById = false;
      deleteBool = false;
      update();
    }
    catch (error){
      deleteBool = false;
      update();
      Get.snackbar(
        "Delete Invoice Notification",
        "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

  //      ==============================================================================
  // -------------- ===========    get sum of total bills  this MONTH ========== -----------------
  //         =========================================================================
  bool forThisMonthBool = false;
  num sumOfThisMonth = 0;

  Future getSumOfThisMonth() async {
    return FirebaseFirestore.instance.collection('GrandTotal').where("month",
        isEqualTo: DateFormat("MM-yyyy").format(DateTime.now())).get().then((querySnapshot) {
      querySnapshot.docs.forEach((element) async {
        num value =  num.parse(element.data()["grandTotal"]);
        sumOfThisMonth = sumOfThisMonth + value;
        update();
      });
      forThisMonthBool = false;
      print("Get Sum Of Total Bills $sumOfThisMonth");
      update();
    });
  }

  //      ==============================================================================
  // -------------- ===========    get sum of total bills  today ========== -----------------
  //         =========================================================================
  bool forTodayBool = false;
  num sumOfToday = 0;

  Future getSumOfToday() async {

    try {

      FirebaseFirestore.instance.collection('GrandTotal').where("day",
          isEqualTo: DateFormat("dd-MM-yyyy").format(DateTime.now())).get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) async {
          num value =  num.parse(element.data()["grandTotal"]);
          sumOfToday = sumOfToday + value;
          update();
        });
        print("Get Sum Of Total Bills $sumOfToday");
        forTodayBool = false;
        update();
      });}

   catch(error){
    print(error);
    forTodayBool = false;
   }
  }

}