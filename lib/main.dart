import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medical_store/view/screen/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAWnXnxe5grkQLNrE8eo1ecLcndGTOedWs", // Your apiKey
      appId: "1:555000510828:web:17f3a3cf9b3bc03d555b49",// Your appId
      messagingSenderId: "555000510828", // Your messagingSenderId
      projectId: "hassan-ms",// Your projectId
      authDomain: "hassan-ms.firebaseapp.com",
      // projectId: "hassan-ms",
      storageBucket: "hassan-ms.appspot.com",
      // measurementId: "G-DQ3P4YB0EY"
    ),
  );
  // ----- to hide top bar from all screens ---
  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1080, 1920),
        builder: () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   visualDensity: VisualDensity.adaptivePlatformDensity
            // ),
            home: LoginScreen()
        )
    );
  }
}
