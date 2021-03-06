import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_store/constants/constant.dart';

//                        ================================
//      ======================= Common Text ======================
//                        ================================
Widget commonText({String title, double fontSize, Color color, FontWeight fontWidget}) {
  return Text(title , style: GoogleFonts.roboto(textStyle: TextStyle(
      fontSize: fontSize,color: color,fontWeight: fontWidget
  )),);
}

//                        ================================
//      ======================= Custom TextFormField ======================
//                        ================================
Widget commonTextFormField({Function onSaved, Function validator,
  bool obscureText = false,TextEditingController controller , String hintText, Function onTap,
  bool readOnly = false, String initialValue, Widget prefixIcon
}) {
  return TextFormField(

    // style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintStyle: TextStyle(color: Colors.black),
        hintText: hintText,
        filled: true,
        fillColor: Colors.black12,
                      
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.r),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.r),
            borderSide: BorderSide(
              color: Colors.transparent,))
    ),
    initialValue: initialValue,
    readOnly: readOnly,
    controller: controller,
    obscureText: obscureText,
    onSaved: onSaved,
    validator: validator,
    onTap: onTap,
  );
}

// ------- common button -------
Widget commonButton({Function onTap,String buttonName,}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(60.r),
      ),
      height: 125.h,
      child: Align(
          alignment: Alignment.center,
          child: commonText(title: buttonName, fontWidget: FontWeight.bold,fontSize: 55.sp)),
    ),
  );
}