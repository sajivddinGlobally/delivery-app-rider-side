import 'package:delivery_rider_app/RiderScreen/enroutePickup.page.dart';
import 'package:delivery_rider_app/RiderScreen/requestDetails.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double balance = 0;
  bool isVisible = true;
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 55.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF111111),
                      ),
                    ),
                    Text(
                      "Allan Smith",
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF111111),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications, size: 25.sp),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  width: 35.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFA8DADC),
                  ),
                  child: Center(
                    child: Text(
                      "AS",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: Color(0xFFD1E5E6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available balance",
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF111111),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text(
                        isVisible ? "₹ ${balance}" : "****",
                        style: GoogleFonts.inter(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111111),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                          color: Color.fromARGB(178, 17, 17, 17),
                          size: 25.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Divider(color: Color(0xFFE5E5E5)),
            SizedBox(height: 15.h),
            Text(
              "Would you like to specify direction for deliveries?",
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF111111),
              ),
            ),
            SizedBox(height: 4.h),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  top: 10.h,
                  bottom: 10.h,
                ),
                filled: true,
                fillColor: Color(0xFFF0F5F5),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide.none,
                ),
                hint: Text(
                  "Where to?",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFAFAFAF),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.circle_outlined,
                  color: Color(0xFF28B877),
                  size: 18.sp,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  "Available Requests",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111111),
                  ),
                ),
                Spacer(),
                Text(
                  "View all",
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF006970),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => RequestDetailsPage(),
                              ),
                            );
                          },
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Electronics/Gadgets",
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF0C341F),
                                  ),
                                ),
                                Text(
                                  "Receipient: Paul Pogba",
                                  style: GoogleFonts.inter(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF545454),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          5.r,
                                        ),
                                        color: Color(0xFFF7F7F7),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/SvgImage/bikess.svg",
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16.sp,
                                              color: Color(0xFF27794D),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              "Drop off",
                                              style: GoogleFonts.inter(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF545454),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 3.w,
                                            top: 2.h,
                                          ),
                                          child: Text(
                                            "Maryland bustop, Anthony Ikeja",
                                            style: GoogleFonts.inter(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF0C341F),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
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
                        SizedBox(height: 15.h),
                        Divider(color: Color(0xFFDCE8E9), thickness: 1.w),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 30,
              spreadRadius: 0,
              color: Color.fromARGB(17, 0, 0, 0),
            ),
          ],
        ),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectIndex = value;
            });
          },
          backgroundColor: Color(0xFFFFFFFF),
          currentIndex: selectIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF006970),
          unselectedItemColor: Color(0xFFC0C5C2),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFFC0C5C2),
          ),
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFF006970),
          ),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/SvgImage/iconhome.svg",
                color: Color(0xFFC0C5C2),
              ),
              activeIcon: SvgPicture.asset(
                "assets/SvgImage/iconhome.svg",
                color: Color(0xFF006970),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/SvgImage/iconearning.svg",
                color: Color(0xFFC0C5C2),
              ),
              activeIcon: SvgPicture.asset(
                "assets/SvgImage/iconearning.svg",
                color: Color(0xFF006970),
              ),
              label: "Earning",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/SvgImage/iconbooking.svg",
                color: Color(0xFFC0C5C2),
              ),
              activeIcon: SvgPicture.asset(
                "assets/SvgImage/iconbooking.svg",
                color: Color(0xFF006970),
              ),
              label: "Booking",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/SvgImage/iconProfile.svg",
                color: Color(0xFFC0C5C2),
              ),
              activeIcon: SvgPicture.asset(
                "assets/SvgImage/iconProfile.svg",
                color: Color(0xFF006970),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
