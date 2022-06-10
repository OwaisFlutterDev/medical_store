import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medical_store/controller/form_validation_controller.dart';
import 'package:medical_store/view/screen/dashboard/dashboard_screen.dart';

class UserAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    // final UserProfileController _userProfileController = Get.put(UserProfileController());
    // _userProfileController.getUserData();
  }

  // ==============================================================================
  // -------------- ===========    Sign up through email & password used for (Employee)  ========== --------------
  //         =========================================================================

  Future createAccount() async {
    final FormValidationController _formValidationController = Get.put(FormValidationController());

    try {
      User firebaseUser = (await _auth.createUserWithEmailAndPassword(
          email: _formValidationController.emailController.text.trim(),
          password: _formValidationController.passwordController.text.trim())).user;
      firebaseUser.sendEmailVerification();

      if (firebaseUser != null) {

        _formValidationController.clearTextField();
        // Get.back();

        Get.snackbar(
          "Create Account Notification",
          "You Created Account Successfully, Please Verify Your Email Before Login ",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
        // return _user;
      } else {
        Get.snackbar(
          "Create Account Notification",
          "Account creation field!  please check your email or password",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Create Account Notification",
          "The password provided is too weak.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Create Account Notification",
          "The Account Already Exists For That Email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      }
    } catch (error) {
      print(error);
      // Get.snackbar(
      //   "Add Employee Notification",
      //   error.toString(),
      //   snackPosition: SnackPosition.TOP,
      //   duration: Duration(seconds: 5),
      // );
      return null;
    }
  }

  // ==============================================================================
// -------------- ===========    Sign In through email and password As (Admin)    ========== --------------
//         =========================================================================
  bool loginBool = false;

  Future signInThroughEmailAndPassword() async {
    loginBool = true;
    update();
    final FormValidationController _formValidationController = Get.put(FormValidationController());

    try {
      User _user = (await _auth.signInWithEmailAndPassword(
          email: _formValidationController.emailController.text.trim(),
          password: _formValidationController.passwordController.text.trim())).user;

      if (_user.emailVerified) {
        loginBool = false;
        update();
        Get.to(() => DashboardScreen());

        Get.snackbar(
          "Sign In Notification",
          "You are Successfully SignIn to Dashboard",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
        _formValidationController.clearTextField();

      } else {

        Get.snackbar(
          "Sign In Notification",
          "Your account is not verified. We are sending you verification email please verify your account to login Thanks",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
        loginBool = false;
        update();
        _user.sendEmailVerification();
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {

        Get.snackbar(
          "Sign In Notification",
          "No user found for that email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
        loginBool = false;
        update();
      } else if (e.code == 'wrong-password') {

        Get.snackbar(
          "Sign In Notification",
          "Wrong password provided for that user.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
        loginBool = false;
        update();
      }
    } catch (error) {
      loginBool = false;
      update();
      print(error);
      return null;
    }
  }

// ==============================================================================
// -------------- ===========    Forget Password Method    ========== ----------------------
//         =========================================================================

  Future resetPasswordRequest() async {
    final FormValidationController _formValidationController = Get.put(FormValidationController());

    try {
      await _auth.sendPasswordResetEmail(email: _formValidationController.emailController.text.trim());
      Get.snackbar("Reset Password Screen",
          "The mail is send to ${_formValidationController.emailController.text.trim()} please reset the Password",
          duration: Duration(seconds: 5));

      _formValidationController.clearTextField();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Reset Password Notification",
          "No user found for that email.",
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 5),
        );
      } else {
        return null;
      }
    } catch (error) {
      // Get.snackbar("Reset Password Screen", error.toString(),
      //     duration: Duration(seconds: 5));
      print(error);
    }
  }


// ==============================================================================
  // -------------- ===========    Sign out method   ========== --------------
  //         =========================================================================

  void logOut() async {
    FirebaseAuth.instance.signOut();
    // Get.off(() => LoginScreen());
    Get.back();
  }

}