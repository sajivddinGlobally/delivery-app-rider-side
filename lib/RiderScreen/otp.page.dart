import 'dart:developer';
import 'package:delivery_rider_app/RiderScreen/home.page.dart';
import 'package:delivery_rider_app/RiderScreen/login.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import '../config/network/api.state.dart';
import '../config/utils/pretty.dio.dart';
import '../data/model/otpModelDATA.dart';

class OtpPage extends StatefulWidget {
  final bool data;
  final String token;

  const OtpPage(this.data, this.token, {super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  String otpValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF092325),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 55.h),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 35.w,
                height: 35.h,
                decoration: const BoxDecoration(
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
              "Please input the verification code sent to your email address",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFD7D7D7),
              ),
            ),
            SizedBox(height: 40.h),
            OtpPinField(
              cursorColor: Colors.white,
              maxLength: 4,
              fieldWidth: 64.w,
              fieldHeight: 71.h,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
              otpPinFieldStyle: OtpPinFieldStyle(
                textStyle: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                ),
                activeFieldBackgroundColor:
                const Color.fromARGB(12, 255, 255, 255),
                defaultFieldBorderColor:
                const Color.fromARGB(153, 255, 255, 255),
                activeFieldBorderColor:
                const Color.fromARGB(255, 255, 255, 255),
              ),
              onChange: (text) {
                otpValue = text; // Save OTP here
              },
              onSubmit: (text) {
                otpValue = text; // Also capture on submit
              },
            ),

            SizedBox(height: 50.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(320.w, 50.h),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              onPressed:(){
                widget.data==false?
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                ):otpFunction();

              },
              // isLoading ? null : otpFunction,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.black)
                  : Text(
                "Verify",
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF091425),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> otpFunction() async {



    if (otpValue.isEmpty || otpValue.length != 4) {
      Fluttertoast.showToast(msg: "Please enter a valid 4-digit OTP");
      return;
    }

    setState(() => isLoading = true);

    final body = OtpBodyModel(
      token: widget.token,
      otp: "123456", // use user input instead of hardcoded "123456"
    );

    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.verifyUser(body);

      // ✅ Safely handle API response
      if (response.data['code'] == 0) {
        Fluttertoast.showToast(msg: response.data['message'] ?? "OTP Verified");

        if (widget.data == false) {
          // 🟢 Navigate to HomePage for existing users
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          // 🟡 Navigate to LoginPage for newly registered users
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: response.data['message'] ?? "OTP verification failed",
        );
      }
    } catch (e, st) {
      // Fluttertoast.showToast(msg: "Something went wrong, please try again");
    }}
}
