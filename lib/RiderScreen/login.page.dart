import 'dart:developer';

import 'package:delivery_rider_app/RiderScreen/chooseViihical.page.dart';
import 'package:delivery_rider_app/RiderScreen/forgatPassword.page.dart';
import 'package:delivery_rider_app/data/model/loginBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/network/api.state.dart';
import '../config/utils/pretty.dio.dart';
import 'otp.page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController =  TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      backgroundColor: Color(0xFF092325),
      body:

      Padding(
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
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SvgPicture.asset("assets/SvgImage/login.svg"),
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      "Welcome Back",
                      style: GoogleFonts.inter(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 7.h),
                    Text(
                      "Please input your information",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFD7D7D7),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    TextFormField(
                      controller: emailController,
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
                    SizedBox(height: 25.h),
                    TextFormField(
                      controller: passwordController,
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
                          "Password",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ForgatPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
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
                        // Navigator.push(
                        //   context,
                        //   CupertinoPageRoute(
                        //     builder: (context) => ChooseViihicalPage(),
                        //   ),
                        // );

                        login();
                      },

                      child: Text(
                        "Sign In",
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF091425),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void login() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
      return;
    }

    // setState(() => isLoading = true);

    final body = LoginBodyModel(
      loginType: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.login(body);

      // ✅ Check if API call was successful
      if (response.data['code']  == 0) {
        Fluttertoast.showToast(msg: response.data['message'] ?? "OTP sent successfully");

        // if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OtpPage(
                false, // 👈 Pass true if from login, false if from register
                '',
              ),
            ),
          );
        // }
        final token = response.data?['token'] ?? '';

        if (token.isEmpty) {
          Fluttertoast.showToast(msg: "Something went wrong: Missing token");
          return;
        }

        // ✅ Navigate to OTP Page with token and data flag

      } else {
        Fluttertoast.showToast(msg: response.data['message'] ?? "Login failed");
      }
    } catch (e, st) {
      debugPrint("Login Error: $e\n$st");
      Fluttertoast.showToast(msg: "Something went wrong. Please try again.");
    } finally {
      // if (mounted) setState(() => isLoading = false);
    }
  }


}
