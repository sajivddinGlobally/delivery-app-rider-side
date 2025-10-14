import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IdentityCardPage extends StatefulWidget {
  const IdentityCardPage({super.key});

  @override
  State<IdentityCardPage> createState() => _IdentityCardPageState();
}

class _IdentityCardPageState extends State<IdentityCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFFFFF),
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
            style: IconButton.styleFrom(shape: CircleBorder()),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20.sp),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Text(
            "Identity Card (front)",
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF091425),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Divider(color: Color(0xFFCBCBCB), thickness: 1),
          SizedBox(height: 28.h),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Text(
              "Make sure the entire ID and all the details are VISIBLE",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4F4F4F),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 14.h),
            child: Text(
              "Take a Photo",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4F4F4F),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 13.h),
            child: Text(
              "Upload a Photo",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4F4F4F),
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Center(child: SvgPicture.asset("assets/SvgImage/card.svg")),
          SizedBox(height: 20.h),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(306.w, 45.h),
                backgroundColor: Color(0xFF006970),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Take Photo",
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
