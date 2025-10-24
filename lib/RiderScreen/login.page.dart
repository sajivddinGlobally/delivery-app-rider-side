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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

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
            SizedBox(height: 25.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: SvgPicture.asset("assets/SvgImage/login.svg")),
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
                        color: const Color(0xFFD7D7D7),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    _buildTextField(
                      controller: emailController,
                      hint: "Email Address",
                      obscure: false,
                    ),
                    SizedBox(height: 25.h),
                    _buildTextField(
                      controller: passwordController,
                      hint: "Password",
                      obscure: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const ForgatPasswordPage(),
                          ),
                        ),
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(320.w, 48.h),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      onPressed: isLoading ? null : login,
                      child: isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.black,
                      )
                          : Text(
                        "Sign In",
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF091425),
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

  /// ✅ Reusable text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
  }) {
    return

      TextFormField(
      controller: controller,
      obscureText: obscure,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(12, 255, 255, 255),
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          const BorderSide(color: Color.fromARGB(153, 255, 255, 255)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          const BorderSide(color: Color.fromARGB(153, 255, 255, 255)),
        ),
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  /// ✅ API Call
  Future<void> login() async {

    if (emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your email");
      return;
    }

    if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your password");
      return;
    }

    setState(() => isLoading = true);

    final body = LoginBodyModel(
      loginType: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.login(body);

      if (response.code == 0) {
        final token = response.data?.token ?? '';
        if (token.isEmpty) {
          Fluttertoast.showToast(msg: "Something went wrong: Missing token");
          return;
        }

        Fluttertoast.showToast(msg: response.message ?? "Login successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OtpPage(false, token),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: response.message ?? "Login failed");
      }
    } catch (e, st) {
      debugPrint("Login Error: $e\n$st");
      Fluttertoast.showToast(msg: "Something went wrong. Please try again.");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
