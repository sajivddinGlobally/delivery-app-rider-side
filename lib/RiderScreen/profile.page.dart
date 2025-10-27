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

import '../config/network/api.state.dart';
import '../config/utils/pretty.dio.dart';
import '../data/model/driverProfileModel.dart'; // Import the DriverProfileModel

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = '';
  String lastName = '';
  String status = '';
  double balance = 0.0;
  String driverId = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getDriverProfile();
  }

  /// Fetch driver profile
  Future<void> getDriverProfile() async {
    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.getDriverProfile();

      if (response.error == false && response.data != null) {
        if (mounted) {
          setState(() {
            firstName = response.data!.firstName ?? '';
            lastName = response.data!.lastName ?? '';
            status = response.data!.status ?? '';
            balance = response.data!.wallet?.balance?.toDouble() ?? 0;
            driverId = response.data!.id ?? '';
            isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() => isLoading = false);
        }
        Fluttertoast.showToast(
          msg: response.message ?? "Failed to fetch profile",
        );
      }
    } catch (e, st) {
      print("Error fetching profile: $e\n$st"); // Optional: Log for debugging
      if (mounted) {
        setState(() => isLoading = false);
      }
      Fluttertoast.showToast(
        msg: "Something went wrong while fetching profile",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userdata");
    final fullName = '$firstName $lastName'.trim();
    final initials = (firstName.isNotEmpty ? firstName[0].toUpperCase() : '') +
        (lastName.isNotEmpty ? lastName[0].toUpperCase() : '');

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView( // Added to prevent overflow if needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70.h),
            Center(
              child: Container(
                width: 72.w,
                height: 72.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFA8DADC),
                ),
                child: Center(
                  child: Text(
                    initials.isNotEmpty ? initials : "DP", // Default to "DP" if no name
                    style: GoogleFonts.inter(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF4F4F4F),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                fullName.isNotEmpty ? fullName : "Driver Profile", // Fallback text
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF111111),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Divider(
              color: const Color(0xFFB0B0B0),
              thickness: 1,
              endIndent: 24,
              indent: 24,
            ),
            buildProfile(Icons.payment, "Payment", () {}),
            buildProfile(Icons.insert_drive_file_sharp, "Document", () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const DocumentPage()),
              );
            }),
            buildProfile(Icons.directions_car, "Vehicle", () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const VihicalPage()),
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
                Fluttertoast.showToast(msg: "Logout Successful");
                Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => const LoginPage()),
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
                      color: const Color.fromARGB(186, 29, 53, 87),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
            Icon(icon, color: const Color(0xFFB0B0B0)),
            SizedBox(width: 10.w),
            Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(186, 29, 53, 87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}