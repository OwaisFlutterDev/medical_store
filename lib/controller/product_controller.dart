import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_store/controller/form_validation_controller.dart';
import 'package:medical_store/model/product_model.dart';
import 'package:intl/intl.dart';

class ProductController extends GetxController {

  //     ---- ================ product Model Instance =============== -----

  RxList<ProductModel> productDataList = RxList<ProductModel>([]);

  // RxList<ProductModel> productDataListForSearch = RxList<ProductModel>([]);

  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("product");

  //   ----- ========== Global Key ========== -----
  final GlobalKey<FormState> addStockFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateProductDialogFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateProductForSearchFormKey = GlobalKey<FormState>();

  TextEditingController prodNameController = new TextEditingController();
  TextEditingController compNameController = new TextEditingController();
  TextEditingController batchController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  TextEditingController tPRateController = new TextEditingController();
  TextEditingController packDiscController = new TextEditingController();

  TextEditingController packValueController = new TextEditingController();
  TextEditingController netTotalController = new TextEditingController();

  TextEditingController mfgDateController = new TextEditingController();
  TextEditingController expireDateController = new TextEditingController();


  // ---------- onInit() ------------

  @override
  void onInit() {
    super.onInit();
     productDataList.bindStream(getAllProductData());
  }

  // ==============================================================================
  // -------------- ===========    Add product data to Firestore    ========== --------------
  //         =========================================================================
  bool addBool = false;
  Future addProduct() async{
    addBool = true;
    update();
    final FormValidationController _formValCon = Get.put(FormValidationController());

    successMsg(){
      Get.snackbar(
        "Add Product Notification",
        "Successfully Added the Product",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }

    try {

      var quantityInt = num.parse(_formValCon.quantity.text);
      var tPRateInt = num.parse(_formValCon.tPRate.text);

      var makePackValue = quantityInt * tPRateInt;

      String packValue = "$makePackValue";
      print("Pack Value: $packValue");

      var packDiscInt = num.parse(_formValCon.packDisc.text);
      var netTotalValue = makePackValue - packDiscInt;

      String netTotal = "$netTotalValue";
      print("Net Total: $netTotal");

      final addProduct = FirebaseFirestore.instance.collection("product").doc();
      await addProduct.set({
        "id": addProduct.id,
        "productName": _formValCon.productName.text,
        "companyName": _formValCon.companyName.text,
        "batch": _formValCon.batch.text,
        "mfgDate": _formValCon.mfgDate.text,
        "expireDate": _formValCon.expireDate.text,
        "datetime": DateFormat("dd-MM-yyyy – kk:mm a").format(DateTime.now()),

        "quantity": _formValCon.quantity.text,
        "tPRate": _formValCon.tPRate.text,
        "packValue": packValue,
        "packDisc": _formValCon.packDisc.text,
        "netTotal": netTotal,
      }).then((_) => successMsg()).catchError((onError) => print(onError.toString()));
       addBool = false;
      _formValCon.clearTextField();
      update();

    }
    catch (error){
     print("$error");
     addBool = false;
     update();
    }
  }

  // ==============================================================================
  // -------------- ===========    Get the product data from Firestore    ========== --------------
  //         =========================================================================


  Stream<List<ProductModel>> getAllProductData() => collectionReference.orderBy("productName").limit(50).snapshots().map((query) =>
      query.docs.map((item) => ProductModel.fromDocumentSnapshot(item)).toList());


// ==============================================================================
// -------------- ===========    Update Product    ========== --------------
//         =========================================================================

  bool updateBool = false;

  Future updateProduct(String id) async {

    updateBool =  true;
    update();
    var quantityInt = num.parse(qtyController.text);
    var tPRateInt = num.parse(tPRateController.text);

    var makePackValue = quantityInt * tPRateInt;

    String packValue = "$makePackValue";
    print("Pack Value: $packValue");

    var packDiscInt = num.parse(packDiscController.text);
    var netTotalValue = makePackValue - packDiscInt;

    String netTotal = "$netTotalValue";
    print("Net Total: $netTotal");

    successMsg(){
      Get.back();
      Get.snackbar(
        "Update Product Notification",
        "Successfully Update the Product",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
    }


    try {

      await FirebaseFirestore.instance.collection('product').doc(id)
          .update(
          {
            "id": id,
            "productName": prodNameController.text,
            "companyName": compNameController.text,
            "batch": batchController.text,
            "mfgDate": mfgDateController.text,
            "expireDate": expireDateController.text,
            "datetime": DateFormat("dd-MM-yyyy – kk:mm a").format(DateTime.now()),

            "quantity": qtyController.text,
            "tPRate": tPRateController.text,
            "packValue": packValue,
            "packDisc": packDiscController.text,
            "netTotal": netTotal,
          }
      )
          .then((_) {successMsg();})
          .catchError((onError) => print(onError.toString()));
      searchProduct(prodNameController.text);
      updateBool = false;
      update();

    }
    catch (error){
      updateBool = false;
      update();
      Get.snackbar(
        "Update Product Notification",
        "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }

  }

  // ==============================================================================
  // -------------- ===========    Search Product data from Firestore    ========== --------------
  //         =========================================================================
  QuerySnapshot snapshotOFSearchProduct;
  bool searchBool = false;
  bool searchBoolForButton = false;

  Future searchProduct(String productName) async {

    searchBoolForButton = true;
    update();

    try{
          await FirebaseFirestore.instance.collection('product').where('productName', isEqualTo: productName).get().then((value) {
          snapshotOFSearchProduct = value;
        });
          if(snapshotOFSearchProduct.docs.isEmpty) {
            Get.snackbar(
              "Search Product Notification",
              "Product Record Not Found...!",
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 4),
            );
          } else {}

          searchBool = true;
          searchBoolForButton = false;
          print("length ${snapshotOFSearchProduct.docs.length}");
          update();

    }
    catch(e)
      {
        searchBoolForButton = false;
        update();
      }


  }

  // ==============================================================================
  // -------------- ===========    Delete Product    ========== --------------
  //         =========================================================================

  bool deleteBool = false;
  Future deleteProduct(String productID) async{
   deleteBool = true;
   update();
    successMsg(){
      Get.back();
      Get.snackbar(
        "Delete Product Notification",
        "The Product is Deleted Successfully: ",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
      );
    }

    try {

      final collection = FirebaseFirestore.instance.collection('product');
      await collection
          .doc(productID) // <-- Doc ID to be deleted.
          .delete() // <-- Delete
          .then((_) => successMsg())
          .catchError((error) => print('Delete failed: $error'));
      searchBool = false;
      deleteBool = false;
      update();
    }
    catch (error){
      Get.snackbar(
        "Delete Product Notification",
        "Check Your Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
      deleteBool = false;
      update();
    }
  }


}
