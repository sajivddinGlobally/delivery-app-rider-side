import 'package:delivery_rider_app/RiderScreen/startDeliver.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EnroutePickupPage extends StatefulWidget {
  const EnroutePickupPage({super.key});

  @override
  State<EnroutePickupPage> createState() => _EnroutePickupPageState();
}

class _EnroutePickupPageState extends State<EnroutePickupPage> {
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
                    height: 195.h,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16.h),
                          width: 33.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(127, 203, 205, 204),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          textAlign: TextAlign.center,
                          "You are Enroute Pick Up Location",
                          style: GoogleFonts.inter(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF091425),
                            height: 1.1,
                          ),
                        ),
                        SizedBox(height: 14.h),
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
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => StartDeliverPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Arrive",
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
              ],
            ),
    );
  }
}
