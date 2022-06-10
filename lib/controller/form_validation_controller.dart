import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FormValidationController extends GetxController{

  //   ----- ========== Global Key ========== -----
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> enterNewProductFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> enterNewbillFormKey = GlobalKey<FormState>();


  //   ----- ========== Text Editing Controller ========== -----
  TextEditingController emailController, passwordController, searchProductController, productName, companyName, batch,
                        quantity, tPRate, packDisc,mfgDate ,expireDate;


  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    searchProductController = TextEditingController();

    productName = TextEditingController();
    companyName = TextEditingController();
    batch = TextEditingController();
    quantity = TextEditingController();
    tPRate = TextEditingController();
    packDisc = TextEditingController();


    mfgDate = TextEditingController();
    expireDate = TextEditingController();


  }
  void clearTextField(){
    emailController.clear();
    passwordController.clear();

    productName.clear();
    companyName.clear();
    batch.clear();
    quantity.clear();
    tPRate.clear();
    packDisc.clear();
    mfgDate.clear();
    expireDate.clear();
  }

}