import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/model/driverProfileModel.dart'; // Import the model to use VehicleDetails type

class VihicalDetailsPage extends StatefulWidget {
  final dynamic vehicle; // Use the actual model type if available, e.g., VehicleDetails
  const VihicalDetailsPage({super.key, required this.vehicle});

  @override
  State<VihicalDetailsPage> createState() => _VihicalDetailsPageState();
}

class _VihicalDetailsPageState extends State<VihicalDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final vehicleName = widget.vehicle.vehicle?.name ?? 'Unknown Vehicle';
    final model = widget.vehicle.model ?? 'Unknown Model';
    final numberPlate = widget.vehicle.numberPlate ?? 'Unknown Plate';

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFFFFFF),
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
            style: IconButton.styleFrom(shape: const CircleBorder()),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, size: 20),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Text(
            numberPlate,
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF091425),
            ),
          ),
        ),
        actions: [
          Container(
            decoration: const BoxDecoration(),
            margin: EdgeInsets.only(right: 10.w),
            child: IconButton(
              style: IconButton.styleFrom(backgroundColor: const Color(0xFFF0F5F5)),
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          const Divider(color: Color(0xFFCBCBCB), thickness: 1),
          SizedBox(height: 28.h),
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [




                type("Type", "Brand"),
                SizedBox(height: 3.h),
                name(vehicleName, ""),
                SizedBox(height: 20.h),
                type("Model", "Year"),
                SizedBox(height: 3.h),


                name(model, ""),
                SizedBox(height: 20.h),
                type("Color", "Registration"),
                SizedBox(height: 3.h),
                name("", numberPlate),
                SizedBox(height: 38.h),





                Text(
                  "Documents",
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF111111),
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
        if (left.isNotEmpty)
          Text(
            left,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF77869E),
            ),
          ),
        if (right.isNotEmpty)
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
        if (left.isNotEmpty)
          Text(
            left,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF111111),
            ),
          ),
        if (right.isNotEmpty)
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
        color: const Color(0xFFF0F5F5),
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
              color: const Color(0xFF4F4F4F),
            ),
          ),
          const Spacer(),
          const Icon(Icons.warning_amber_rounded, color: Colors.red),
        ],
      ),
    );
  }
}