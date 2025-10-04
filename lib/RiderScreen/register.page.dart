import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? selectedCity;

  final List<String> cities = [
    "Delhi",
    "Mumbai",
    "Kolkata",
    "Chennai",
    "Bangalore",
  ];
  bool isCheckt = false;
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
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let’s get Started",
                      style: GoogleFonts.inter(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Please input your information",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFD7D7D7),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
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
                                "First Name",
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 24.w),
                        Expanded(
                          child: TextFormField(
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
                                "Last Name",
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
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
                    SizedBox(height: 24.h),
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
                          "Phone Number",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
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
                          "Password",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    DropdownButtonFormField(
                      dropdownColor: Colors.black,
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
                        // hintText: "City",
                        // hintStyle: GoogleFonts.inter(
                        //   fontSize: 15.sp,
                        //   fontWeight: FontWeight.w400,
                        //   color: Color.fromARGB(255, 255, 255, 255),
                        // ),
                        hint: Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Text(
                            "City",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                      value: selectedCity,
                      items: cities.map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text(
                            city,
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                      // selectedItemBuilder: (BuildContext context) {
                      //   return cities.map((city) {
                      //     return Text(
                      //       city,
                      //       style: GoogleFonts.inter(
                      //         color: Colors.white,
                      //         fontSize: 14.sp,
                      //       ),
                      //     );
                      //   }).toList();
                      // },
                    ),
                    SizedBox(height: 24.h),
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
                          "Referral Code (Optional)",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
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
                              side: BorderSide(color: Colors.white),
                              value: isCheckt,
                              onChanged: (value) {
                                setState(() {
                                  isCheckt = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white, // Default color
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "By checking this box, you agree to our ",
                                ),
                                TextSpan(
                                  text:
                                      "Terms & Conditions", // Part to color red
                                  style: GoogleFonts.inter(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red, // Red color
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ". That all information provided is true and Snap or its representatives may contact me via any of the provided channels.",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                      onPressed: () {},
                      child: Text(
                        "Continue",
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
}
