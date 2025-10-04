import 'package:delivery_rider_app/RiderScreen/enroutePickup.page.dart';
import 'package:delivery_rider_app/RiderScreen/mapRequestDetails.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestDetailsPage extends StatefulWidget {
  const RequestDetailsPage({super.key});

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        leading: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(left: 15.w),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Color(0xFF111111)),
          ),
        ),
        title: Text(
          "Delivery details",
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFF111111),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFA8DADC),
                  ),
                  child: Center(
                    child: Text(
                      "DE",
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Davidson Edgar",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF111111),
                      ),
                    ),
                    Text(
                      "20 Deliveries",
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i <= 4; i++)
                          Icon(Icons.star, color: Colors.yellow, size: 16.sp),
                        SizedBox(width: 5.w),
                        Text(
                          "4.1",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4F4F4F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  width: 35.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: Color(0xFFF7F7F7),
                  ),
                  child: Center(
                    child: SvgPicture.asset("assets/SvgImage/bikess.svg"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFFDE4B65),
                      size: 22.sp,
                    ),
                    SizedBox(height: 6.h),
                    CircleAvatar(
                      backgroundColor: Color(0xFF28B877),
                      radius: 2.r,
                    ),
                    SizedBox(height: 5.h),
                    CircleAvatar(
                      backgroundColor: Color(0xFF28B877),
                      radius: 2.r,
                    ),
                    SizedBox(height: 5.h),
                    CircleAvatar(
                      backgroundColor: Color(0xFF28B877),
                      radius: 2.r,
                    ),
                    SizedBox(height: 6.h),
                    Icon(
                      Icons.circle_outlined,
                      color: Color(0xFF28B877),
                      size: 17.sp,
                      fontWeight: FontWeight.bold,
                      weight: 20,
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pickup Location",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF77869E),
                      ),
                    ),
                    Text(
                      "32 Samwell Sq, Chevron",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111111),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      "Delivery Location",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF77869E),
                      ),
                    ),
                    Text(
                      "21b, Karimu Kotun Street, Victoria Island",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111111),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                buildAddress("What you are sending", "Electronics/Gadgets"),
                SizedBox(width: 40.w),
                buildAddress("Receipient", "Donald Duck"),
              ],
            ),
            SizedBox(height: 16.h),
            buildAddress("Receipient contact number", "08123456789"),
            SizedBox(height: 16.h),
            Row(
              children: [
                buildAddress("Payment", "Card"),
                SizedBox(width: 130.w),
                buildAddress("Fee:", "\$150"),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              "Pickup image(s)",
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF77869E),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64.w,
                  height: 64.h,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  width: 64.w,
                  height: 64.h,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => MapRequestDetailsPage(),
                    ),
                  );
                },
                child: Text(
                  "View Map Route",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF006970),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF006970),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(136.w, 44.h),
                    backgroundColor: Color(0xFFF3F7F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Reject",
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF006970),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(136.w, 44.h),
                    backgroundColor: Color(0xFF006970),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => EnroutePickupPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Accept",
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget buildAddress(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFF77869E),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF111111),
          ),
        ),
      ],
    );
  }
}
