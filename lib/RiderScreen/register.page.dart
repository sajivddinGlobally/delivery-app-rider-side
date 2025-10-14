
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:delivery_rider_app/RiderScreen/otp.page.dart';
import 'package:delivery_rider_app/config/network/api.state.dart';
import 'package:delivery_rider_app/config/utils/pretty.dio.dart';
import 'package:delivery_rider_app/data/controller/getCityController.dart';
import 'package:delivery_rider_app/data/model/registerBodyModel.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/model/getCityResModel.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});
  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  Datum? selectedCityObj;
  final registerformKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final codeController = TextEditingController();
  bool isCheckt = false;
  bool isLoading = false;
  static const Color _fillColor = Color(0x0AFFFFFF);
  static const Color _borderColor = Color(0x99FFFFFF);
  static const TextStyle _textStyle = TextStyle(color: Colors.white);

  InputDecoration _getInputDecoration(String hint, {bool showCounter = false}) {
    return InputDecoration(
      filled: true,
      fillColor: _fillColor,
      contentPadding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h, bottom: 15.h),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: _borderColor, width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: _borderColor, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: _borderColor, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: _borderColor, width: 1.w),
      ),
      hint: Text(hint, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.white)),
      counterText: showCounter ? null : "",
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    int? maxLength,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      style: _textStyle,
      obscureText: obscureText,
      maxLength: maxLength,
      decoration: _getInputDecoration(hint, showCounter: maxLength != null),
      validator: validator,
    );
  }

  Future<String> _getDeviceToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      return token ?? "unknown_device";
    } catch (e) {
      log("Error getting device token: $e");
      return "unknown_device";
    }
  }
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void register(String cityId, String deviceId) async {
    final deviceToken = await _getDeviceToken(); // Get device token automatically
    if (firstNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
      Text('Please Enter First Name')));
      return;
    }
    if (lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
      Text('Please Enter Last Name')));
      return;
    }
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
      Text('Please Enter Email')));
      return;
    }
    if (phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
      Text('Please Enter Phone Number')));
      return;
    }

    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:
      Text('Please Enter Password ')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    final body = RegisterBodyModel(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phone: phoneNumberController.text,
      cityId: cityId,
      deviceId: deviceToken, // Send device token here
      refByCode: codeController.text,
      password: passwordController.text,
    );

    try {
      final service = APIStateNetwork(callDio());
      final response = await service.register(body);
      if (response.error == false) {
        Fluttertoast.showToast(msg: response.message);
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) =>  OtpPage(

                true, response.data['token'],)),
                (route) => false,
          );
        }
      } else {
        Fluttertoast.showToast(msg: response.message);
      }
    }

    catch (e, st) {
      log("${e.toString()} / ${st.toString()}");
    }
    finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<String> _getDeviceId() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'unknown_device';
      } else {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id ?? 'unknown_device';
      }
    } catch (e) {
      log('Error getting device ID: $e');
      return 'unknown_device';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getCityControlelr).when(
      data: (cityList) {
        // Filter and remove duplicates
        final filteredCities = cityList.data!.where((city) => city.city != null && city.city!.isNotEmpty).toList();
        final uniqueCities = <Datum>{...filteredCities}.toList();

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
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Let’s get Started", style: GoogleFonts.inter(fontSize: 25.sp, fontWeight: FontWeight.w400, color: Colors.white)),
                        SizedBox(height: 4.h),
                        Text("Please input your information", style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFFD7D7D7))),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextFormField(
                                controller: firstNameController,
                                hint: "First Name",
                                validator: (value) => (value == null || value.isEmpty) ? "First Name is required" : null,
                              ),
                            ),
                            SizedBox(width: 24.w),
                            Expanded(
                              child: _buildTextFormField(
                                controller: lastNameController,
                                hint: "Last Name",
                                validator: (value) => (value == null || value.isEmpty) ? "Last Name is required" : null,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        _buildTextFormField(
                          controller: emailController,
                          hint: "Email Address",
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Email is required";
                            final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                            if (!RegExp(pattern).hasMatch(value.trim())) return "Enter a valid email";
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),
                        _buildTextFormField(
                          controller: phoneNumberController,
                          hint: "Phone Number",
                          maxLength: 10,
                          validator: (value) => (value == null || value.isEmpty) ? "Phone Number is required" : null,
                        ),
                        SizedBox(height: 24.h),
                        _buildTextFormField(
                          controller: passwordController,
                          hint: "Password",
                          obscureText: true,
                          validator: (value) => (value == null || value.isEmpty) ? "Password is required" : null,
                        ),
                        SizedBox(height: 24.h),

                        // Updated city dropdown
                        DropdownButtonFormField<Datum>(
                          value: selectedCityObj,
                          dropdownColor: Colors.black,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: _fillColor,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                            enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: _borderColor, width: 1)),
                            focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: _borderColor, width: 1)),
                            hint: Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Text("City", style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp)),
                            ),
                          ),
                          items: uniqueCities.map((city) => DropdownMenuItem<Datum>(
                            value: city,
                            child: Text(city.city!, style: GoogleFonts.inter(fontSize: 15.sp, color: Colors.white)),
                          )).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCityObj = value;
                            });
                          },
                          validator: (value) => value == null ? "City is required" : null,
                        ),

                        SizedBox(height: 24.h),
                        _buildTextFormField(controller: codeController, hint: "Referral Code (Optional)"),
                        SizedBox(height: 26.h),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30.w,
                              height: 30.h,
                              child: Transform.scale(
                                scale: 1,
                                child: Checkbox(
                                  side: const BorderSide(color: Colors.white),
                                  value: isCheckt,
                                  onChanged: (value) => setState(() => isCheckt = value!),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                                  children: const [
                                    TextSpan(text: "By checking this box, you agree to our "),
                                    TextSpan(text: "Terms & Conditions", style: TextStyle(color: Colors.red)),
                                    TextSpan(text: ". That all information provided is true and Snap or its representatives may contact me via any of the provided channels."),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(minimumSize: Size(320.w, 48.h), backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r), side: BorderSide.none)),
                            onPressed: isLoading
                                ? null
                                : () async {
                              if (selectedCityObj == null || selectedCityObj!.id == null) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a valid city')));
                                return;
                              }
                              final deviceId = await _getDeviceId();
                              register(selectedCityObj!.id.toString(), deviceId);
                            },
                            child: Text("Continue", style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w500, color: const Color(0xFF091425))),
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
      },
      error: (error, stackTrace) {
        log(stackTrace.toString());
        return Center(child: Text(error.toString(), style: GoogleFonts.inter(color: Colors.white)));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
