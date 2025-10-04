import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
              "OTP Verification",
              style: GoogleFonts.inter(
                fontSize: 25.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              "Please input verification code  sent your email address",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFFD7D7D7),
              ),
            ),
            SizedBox(height: 40.h),
            OtpPinField(
              cursorColor: Colors.white,
              maxLength: 4,
              fieldWidth: 64.w,
              fieldHeight: 71.h,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              otpPinFieldDecoration:
                  OtpPinFieldDecoration.defaultPinBoxDecoration,
              otpPinFieldStyle: OtpPinFieldStyle(
                textStyle: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                ),
                activeFieldBackgroundColor: Color.fromARGB(12, 255, 255, 255),
                defaultFieldBorderColor: Color.fromARGB(153, 255, 255, 255),
                activeFieldBorderColor: Color.fromARGB(255, 255, 255, 255),
              ),
              onSubmit: (text) {},
              onChange: (text) {},
            ),
            SizedBox(height: 50.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(320.w, 50.h),
                backgroundColor: Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  side: BorderSide.none,
                ),
              ),
              onPressed: () {},
              child: Text(
                "Verify",
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
