import 'package:delivery_rider_app/RiderScreen/vihicalDetails.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VihicalPage extends StatefulWidget {
  const VihicalPage({super.key});

  @override
  State<VihicalPage> createState() => _VihicalPageState();
}

class _VihicalPageState extends State<VihicalPage> {
  int select = 0;
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
            "Vehicles",
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
              icon: Icon(Icons.add),
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
          InkWell(
            onTap: () {
              setState(() {
                select = 0;
              });
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => VihicalDetailsPage()),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              padding: EdgeInsets.only(
                left: 14.w,
                right: 14.w,
                top: 14.h,
                bottom: 14.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Color(0xFFF3F7F5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/SvgImage/c1.svg",
                        width: 18.w,
                        height: 18.h,
                      ),
                      Spacer(),
                      select == 0
                          ? Icon(
                              Icons.check_circle,
                              color: Color(0xFF25BC15),
                              size: 20.sp,
                            )
                          : Icon(
                              Icons.circle_outlined,
                              color: Color(0xFF898A8D),
                              size: 20.sp,
                            ),
                    ],
                  ),
                  Text(
                    "Vehicle • Toyota Corolla 2007",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF545454),
                    ),
                  ),
                  Text(
                    "EPE 123 YT",
                    style: GoogleFonts.inter(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF545454),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          InkWell(
            onTap: () {
              setState(() {
                select = 1;
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              padding: EdgeInsets.only(
                left: 14.w,
                right: 14.w,
                top: 14.h,
                bottom: 14.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Color(0xFFF3F7F5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/SvgImage/c2.svg",
                        width: 20.w,
                        height: 20.h,
                      ),
                      Spacer(),
                      select == 1
                          ? Icon(
                              Icons.check_circle,
                              color: Color(0xFF25BC15),
                              size: 20.sp,
                            )
                          : Icon(
                              Icons.circle_outlined,
                              color: Color(0xFF898A8D),
                              size: 20.sp,
                            ),
                    ],
                  ),
                  Text(
                    "Bike • Suzuki 23S",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF545454),
                    ),
                  ),
                  Text(
                    "IKJ 631 YT",
                    style: GoogleFonts.inter(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF545454),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
