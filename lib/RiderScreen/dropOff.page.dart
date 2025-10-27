import 'package:delivery_rider_app/RiderScreen/processDropOff.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DropOffPage extends StatefulWidget {
  const DropOffPage({super.key});

  @override
  State<DropOffPage> createState() => _DropOffPageState();
}

class _DropOffPageState extends State<DropOffPage> {
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;

  Future<void> _getCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Location permission permanently denied. Please enable it from settings.",
          ),
        ),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLatLng = LatLng(position.latitude, position.longitude);
    });
    _mapController?.animateCamera(CameraUpdate.newLatLng(_currentLatLng!));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFFFFF),
        shape: CircleBorder(),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Color(0xFF1D3557)),
      ),
      body: _currentLatLng == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLatLng!,
                    zoom: 15,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
                Positioned(
                  bottom: 15.h,
                  child: Container(
                    margin: EdgeInsets.only(left: 18.w, right: 18.w),
                    width: 340.w,
                    height: 242.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 20,
                          spreadRadius: 0,
                          color: Color.fromARGB(114, 0, 0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 10.h),
                              width: 33.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(127, 203, 205, 204),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "5 minutes to delivery",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000),
                            ),
                          ),
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
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 16.sp,
                                        ),
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
                            ],
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Call Recipient",
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(306.w, 45.h),
                              backgroundColor: Color(0xFF006970),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r),
                                side: BorderSide.none,
                              ),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   CupertinoPageRoute(
                              //     builder: (context) => ProcessDropOffPage(txtid: '',),
                              //   ),
                              // );
                            },
                            child: Text(
                              "Start Drop off process",
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
