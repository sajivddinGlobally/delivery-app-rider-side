import 'package:delivery_rider_app/RiderScreen/home.page.dart';
import 'package:delivery_rider_app/RiderScreen/pendingHome.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseViihicalPage extends StatefulWidget {
  const ChooseViihicalPage({super.key});

  @override
  State<ChooseViihicalPage> createState() => _ChooseViihicalPageState();
}

class _ChooseViihicalPageState extends State<ChooseViihicalPage> {
  int select = 0;
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
            SizedBox(height: 40.h),
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
              "Please select your preferred delivery channel",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFFD7D7D7),
              ),
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                chooseVihical(1, "assets/SvgImage/c1.svg", "Car"),
                SizedBox(width: 38.w),
                chooseVihical(2, "assets/SvgImage/c2.svg", "Bike"),
              ],
            ),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                chooseVihical(3, "assets/SvgImage/c3.svg", "Truck"),
                SizedBox(width: 38.w),
                chooseVihical(4, "assets/SvgImage/c4.svg", "More"),
              ],
            ),
            SizedBox(height: 60.h),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300.w, 48.h),
                  backgroundColor: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    side: BorderSide.none,
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   CupertinoPageRoute(builder: (context) => PendingHomePage()),
                  // );
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => HomePage(0)),
                  );
                },
                child: Text(
                  "Continue",
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF091425),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chooseVihical(int index, String image, String name) {
    final isSelect = index == select;
    return InkWell(
      onTap: () {
        setState(() {
          select = index;
        });
      },
      child: Container(
        width: 120.w,
        height: 120.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),

          border: Border.all(
            color: isSelect ? Colors.white : Color.fromARGB(102, 255, 255, 255),
            width: 2.w,
          ),
          color: isSelect ? Colors.white : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              color: isSelect ? Color(0xFF086E86) : Color(0xFFA8DADC),
            ),
            SizedBox(height: 16.h),
            Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: isSelect ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
