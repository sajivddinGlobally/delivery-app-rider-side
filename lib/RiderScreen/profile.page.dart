import 'dart:developer';
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
import 'home.page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName = '';
  String lastName = '';
  String status = '';
  String driverId = '';
  double balance = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getDriverProfile();
  }

  /// Fetch driver profile from API
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
        Fluttertoast.showToast(
          msg: response.message ?? "Failed to fetch profile",
        );
        setState(() => isLoading = false);
      }
    } catch (e, st) {
      log("Get Driver Profile Error: $e\n$st");
      Fluttertoast.showToast(
        msg: "Something went wrong while fetching profile",
      );
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userdata");

    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70.h),

                // ✅ Profile Avatar with initials
                Center(
                  child: Container(
                    width: 72.w,
                    height: 72.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFA8DADC),
                    ),
                    child: Center(
                      child: Text(
                        "${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}"
                            .toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF4F4F4F),
                        ),
                      ),
                    ),
                  ),
                ),

                // ✅ Full Name
                Center(
                  child: Text(
                    "$firstName $lastName".trim().isNotEmpty
                        ? "$firstName $lastName"
                        : "User",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF111111),
                    ),
                  ),
                ),

                // ✅ Driver Balance
                if (driverId.isNotEmpty)
                  Center(
                    child: Text(
                      "Wallet: ₹${balance.toStringAsFixed(2)}",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),

                SizedBox(height: 20.h),
                const Divider(
                  color: Color(0xFFB0B0B0),
                  thickness: 1,
                  endIndent: 24,
                  indent: 24,
                ),

                buildProfile(Icons.payment, "Payment", () {}),
                buildProfile(Icons.insert_drive_file_sharp, "Document", () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const DocumentPage(),
                    ),
                  );
                }),
                buildProfile(Icons.directions_car, "Vehicle", () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const VihicalPage(),
                    ),
                  );
                }),
                buildProfile(Icons.history, "Delivery History", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(2)),
                  );
                }),
                buildProfile(Icons.settings, "Setting", () {}),
                buildProfile(Icons.contact_support, "Support/FAQ", () {}),
                buildProfile(
                  Icons.markunread_mailbox_rounded,
                  "Invite Friends",
                  () {},
                ),
                SizedBox(height: 50.h),

                // ✅ Logout with confirmation dialog
                InkWell(
                  onTap: () {
                    _showLogoutDialog(context, box);
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
    );
  }

  /// ✅ Logout Confirmation Dialog
  void _showLogoutDialog(BuildContext context, Box box) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context); // Close dialog only
              },
              child: const Text("No"),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context); // Close dialog
                box.clear();
                Fluttertoast.showToast(msg: "Logout Successful");
                Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Widget buildProfile(IconData icon, String name, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
