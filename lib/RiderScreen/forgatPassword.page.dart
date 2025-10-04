import 'package:delivery_rider_app/RiderScreen/otp.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgatPasswordPage extends StatefulWidget {
  const ForgatPasswordPage({super.key});

  @override
  State<ForgatPasswordPage> createState() => _ForgatPasswordPageState();
}

class _ForgatPasswordPageState extends State<ForgatPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF092325),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 55.h),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              "Forgot Password?",
              style: GoogleFonts.inter(
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              "Don't worry! It occurs. Please enter the email address linked with your account.",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFFD7D7D7),
              ),
            ),
            SizedBox(height: 40.h),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(12, 255, 255, 255),
                contentPadding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 15.h,
                  bottom: 15.h,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color.fromARGB(153, 255, 255, 255),
                    width: 1.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color.fromARGB(153, 255, 255, 255),
                    width: 1.w,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color.fromARGB(153, 255, 255, 255),
                    width: 1.w,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color.fromARGB(153, 255, 255, 255),
                    width: 1.w,
                  ),
                ),
                hint: Text(
                  "Email Address",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(320.w, 48.h),
                backgroundColor: Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  side: BorderSide.none,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => OtpPage()),
                );
              },
              child: Text(
                "Send OTP",
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF091425),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
