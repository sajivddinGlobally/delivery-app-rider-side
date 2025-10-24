import 'package:delivery_rider_app/RiderScreen/document.page.dart';
import 'package:delivery_rider_app/RiderScreen/login.page.dart';
import 'package:delivery_rider_app/RiderScreen/vihical.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userdata");
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 70.h),
          Center(
            child: Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA8DADC),
              ),
              child: Center(
                child: Text(
                  "AS",
                  style: GoogleFonts.inter(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              "Allan Smith",
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF111111),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Divider(
            color: Color(0xFFB0B0B0),
            thickness: 1,
            endIndent: 24,
            indent: 24,
          ),
          buildProfile(Icons.payment, "Payment", () {}),
          buildProfile(Icons.insert_drive_file_sharp, "Document", () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => DocumentPage()),
            );
          }),
          buildProfile(Icons.directions_car, "Vehicle", () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => VihicalPage()),
            );
          }),
          buildProfile(Icons.history, "Delivery History", () {}),
          buildProfile(Icons.settings, "Setting", () {}),
          buildProfile(Icons.contact_support, "Support/FAQ", () {}),
          buildProfile(
            Icons.markunread_mailbox_rounded,
            "Invite Friends",
            () {},
          ),
          SizedBox(height: 50.h),
          InkWell(
            onTap: () {
              box.clear();
              Fluttertoast.showToast(msg: "Logout Successfull");
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 24.w),
                SvgPicture.asset("assets/SvgImage/signout.svg"),
                SizedBox(width: 10.w),
                Text(
                  "Sign out",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(186, 29, 53, 87),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfile(IconData icon, String name, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(left: 24.w, top: 25.h),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFFB0B0B0)),
            SizedBox(width: 10.w),
            Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(186, 29, 53, 87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
