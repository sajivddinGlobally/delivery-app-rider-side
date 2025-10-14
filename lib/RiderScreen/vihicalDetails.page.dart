import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VihicalDetailsPage extends StatefulWidget {
  const VihicalDetailsPage({super.key});

  @override
  State<VihicalDetailsPage> createState() => _VihicalDetailsPageState();
}

class _VihicalDetailsPageState extends State<VihicalDetailsPage> {
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
            "EPE 123 YT",
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF091425),
            ),
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(),
            margin: EdgeInsets.only(right: 10.w),
            child: IconButton(
              style: IconButton.styleFrom(backgroundColor: Color(0xFFF0F5F5)),
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Divider(color: Color(0xFFCBCBCB), thickness: 1),
          SizedBox(height: 28.h),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                type("Type", "Brand"),
                SizedBox(height: 3.h),
                name("Car", "Toyota"),
                SizedBox(height: 20.h),
                type("Model", "Year"),
                SizedBox(height: 3.h),
                name("Corolla", "2007"),
                SizedBox(height: 20.h),
                type("Color", "Registration"),
                SizedBox(height: 3.h),
                name("Red", "EPE 123 YT"),
                SizedBox(height: 38.h),
                Text(
                  "Documents",
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111111),
                  ),
                ),
                SizedBox(height: 12.h),
                document("assets/SvgImage/do.svg", "Registration"),
                SizedBox(height: 10.h),
                document("assets/SvgImage/do.svg", "Insurance Policy"),
                SizedBox(height: 10.h),
                document("assets/SvgImage/do.svg", "Road Worthiness"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget type(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF77869E),
          ),
        ),
        Text(
          right,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF77869E),
          ),
        ),
      ],
    );
  }

  Widget name(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF111111),
          ),
        ),
        Text(
          right,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF111111),
          ),
        ),
      ],
    );
  }

  Widget document(String image, String name) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 10.h,
        bottom: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Color(0xFFF0F5F5),
      ),
      child: Row(
        children: [
          SvgPicture.asset(image, width: 35.w, height: 35.h, fit: BoxFit.cover),
          SizedBox(width: 30.w),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4F4F4F),
            ),
          ),
          Spacer(),
          Icon(Icons.warning_amber_rounded, color: Colors.red),
        ],
      ),
    );
  }
}
