import 'package:delivery_rider_app/RiderScreen/enroutePickup.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRequestDetailsPage extends StatefulWidget {
  const MapRequestDetailsPage({super.key});

  @override
  State<MapRequestDetailsPage> createState() => _MapRequestDetailsPageState();
}

class _MapRequestDetailsPageState extends State<MapRequestDetailsPage> {
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
                  bottom: 5.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      SizedBox(width: 20.w),
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
                ),
              ],
            ),
    );
  }
}
