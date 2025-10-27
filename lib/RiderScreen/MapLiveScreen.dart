//
//
// import 'dart:developer';
// import 'package:delivery_rider_app/RiderScreen/enroutePickup.page.dart';
// import 'package:delivery_rider_app/config/utils/pretty.dio.dart';
// import 'package:delivery_rider_app/data/model/deliveryOnGoingBodyModel.dart';
// import 'package:delivery_rider_app/data/model/deliveryPickedReachedBodyModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import '../config/network/api.state.dart';
// import '../data/model/DeliveryResponseModel.dart';
// import 'dropOff.page.dart';
//
// class MapLiveScreen extends StatefulWidget {
//   final Data deliveryData;
//   final double? pickupLat;
//   final double? pickupLong;
//   final double? dropLat;
//   final double? droplong;
//   final String txtid;
//   const MapLiveScreen( {
//     this.pickupLat,
//     this.pickupLong,
//     this.dropLat,
//     this.droplong,
//     super.key,
//     required this.deliveryData,
//     required this.txtid,
//   });
//
//   @override
//   State<MapLiveScreen> createState() => _MapLiveScreenState();
// }
//
// class _MapLiveScreenState extends State<MapLiveScreen> {
//   GoogleMapController? _mapController;
//   LatLng? _currentLatLng;
//   final Set<Marker> _markers = {};
//   final Set<Polyline> _polylines = {};
//   List<LatLng> _routePoints = [];
//   bool _routeFetched = false;
//   String? toPickupDistance;
//   String? toPickupDuration;
//   String? pickupToDropDistance;
//   String? pickupToDropDuration;
//   String? totalDistance;
//   String? totalDuration;
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Location permission denied")),
//           );
//         }
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               "Location permission permanently denied. Please enable it from settings.",
//             ),
//           ),
//         );
//       }
//       return;
//     }
//
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     if (mounted) {
//       setState(() {
//         _currentLatLng = LatLng(position.latitude, position.longitude);
//       });
//       _addMarkers();
//     }
//   }
//
//   void _addMarkers() {
//     _markers.clear(); // Clear previous markers to avoid duplicates
//     if (_currentLatLng != null) {
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('current'),
//           position: _currentLatLng!,
//           infoWindow: const InfoWindow(title: 'Current Location'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(
//             BitmapDescriptor.hueGreen,
//           ),
//         ),
//       );
//     }
//     if (widget.pickupLat != null && widget.pickupLong != null) {
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('pickup'),
//           position: LatLng(widget.pickupLat!, widget.pickupLong!),
//           infoWindow: const InfoWindow(title: 'Pickup Location'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         ),
//       );
//     }
//     if (widget.dropLat != null && widget.droplong != null) {
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('drop'),
//           position: LatLng(widget.dropLat!, widget.droplong!),
//           infoWindow: const InfoWindow(title: 'Drop Location'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(
//             BitmapDescriptor.hueOrange,
//           ),
//         ),
//       );
//     }
//     setState(() {});
//   }
//
//
//   Future<void> _fetchRoute() async {
//     if (_currentLatLng == null) {
//       print('Error: Current location is null');
//       return;
//     }
//     if (widget.pickupLat == null || widget.pickupLong == null) {
//       print('Error: Pickup location is null');
//       return;
//     }
//
//     // Temporary Mock: Fake data for testing (remove this block when using real API)
//     List<LatLng> points1 = [];
//     double dist1 = 2.5; // Fake distance to pickup
//     int time1 = 10; // Fake duration to pickup
//     // Generate simple straight-line points from current to pickup (for demo)
//     if (_currentLatLng != null &&
//         widget.pickupLat != null &&
//         widget.pickupLong != null) {
//       points1 = _generateMockPolyline(
//         _currentLatLng!,
//         LatLng(widget.pickupLat!, widget.pickupLong!),
//         20,
//       ); // 20 points for smooth line
//     }
//
//     List<LatLng> points2 = [];
//     double dist2 = 3.2; // Fake distance from pickup to drop
//     int time2 = 15; // Fake duration from pickup to drop
//     if (widget.dropLat != null && widget.droplong != null) {
//       points2 = _generateMockPolyline(
//         LatLng(widget.pickupLat!, widget.pickupLong!),
//         LatLng(widget.dropLat!, widget.droplong!),
//         25,
//       );
//     }
//
//     List<LatLng> allPoints = [...points1, ...points2];
//
//     setState(() {
//       _polylines.clear();
//       if (points1.isNotEmpty) {
//         _polylines.add(
//           Polyline(
//             polylineId: const PolylineId('toPickup'),
//             points: points1,
//             color: Colors.green,
//             width: 5,
//           ),
//         );
//         toPickupDistance = '${dist1.toStringAsFixed(1)} km';
//         toPickupDuration = '${time1.toStringAsFixed(0)} min';
//       }
//       if (points2.isNotEmpty) {
//         _polylines.add(
//           Polyline(
//             polylineId: const PolylineId('toDrop'),
//             points: points2,
//             color: Colors.blue,
//             width: 5,
//           ),
//         );
//         pickupToDropDistance = '${dist2.toStringAsFixed(1)} km';
//         pickupToDropDuration = '${time2.toStringAsFixed(0)} min';
//       }
//       totalDistance = '${(dist1 + dist2).toStringAsFixed(1)} km';
//       totalDuration = '${(time1 + time2).toStringAsFixed(0)} min';
//       _routePoints = allPoints;
//     });
//
//     // Animate camera to fit the route
//     if (_mapController != null && allPoints.isNotEmpty) {
//       LatLngBounds bounds = _calculateBounds(allPoints);
//       _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
//     }
//
//     print(
//       'Mock route loaded: ${points1.length} points to pickup, ${points2.length} to drop',
//     ); // Debug
//   }
//
//   List<LatLng> _generateMockPolyline(LatLng start, LatLng end, int numPoints) {
//     List<LatLng> points = [];
//     double latStep = (end.latitude - start.latitude) / numPoints;
//     double lngStep = (end.longitude - start.longitude) / numPoints;
//     for (int i = 0; i <= numPoints; i++) {
//       double lat = start.latitude + (latStep * i);
//       double lng = start.longitude + (lngStep * i);
//       points.add(LatLng(lat, lng));
//     }
//     return points;
//   }
//
//   LatLngBounds _calculateBounds(List<LatLng> points) {
//     if (points.isEmpty) {
//       return LatLngBounds(
//         southwest: _currentLatLng!,
//         northeast: _currentLatLng!,
//       );
//     }
//     double minLat = points[0].latitude;
//     double maxLat = points[0].latitude;
//     double minLng = points[0].longitude;
//     double maxLng = points[0].longitude;
//
//     for (LatLng point in points) {
//       if (point.latitude < minLat) minLat = point.latitude;
//       if (point.latitude > maxLat) maxLat = point.latitude;
//       if (point.longitude < minLng) minLng = point.longitude;
//       if (point.longitude > maxLng) maxLng = point.longitude;
//     }
//
//     // Include pickup and drop if not in points
//     if (widget.pickupLat != null && widget.pickupLong != null) {
//       LatLng pickup = LatLng(widget.pickupLat!, widget.pickupLong!);
//       if (pickup.latitude < minLat) minLat = pickup.latitude;
//       if (pickup.latitude > maxLat) maxLat = pickup.latitude;
//       if (pickup.longitude < minLng) minLng = pickup.longitude;
//       if (pickup.longitude > maxLng) maxLng = pickup.longitude;
//     }
//     if (widget.dropLat != null && widget.droplong != null) {
//       LatLng drop = LatLng(widget.dropLat!, widget.droplong!);
//       if (drop.latitude < minLat) minLat = drop.latitude;
//       if (drop.latitude > maxLat) maxLat = drop.latitude;
//       if (drop.longitude < minLng) minLng = drop.longitude;
//       if (drop.longitude > maxLng) maxLng = drop.longitude;
//     }
//
//     return LatLngBounds(
//       southwest: LatLng(minLat, minLng),
//       northeast: LatLng(maxLat, maxLng),
//     );
//   }
//
//   List<LatLng> _decodePolyline(String encoded) {
//     List<LatLng> points = <LatLng>[];
//     int index = 0;
//     final int len = encoded.length;
//     int lat = 0;
//     int lng = 0;
//
//     while (index < len) {
//       int b;
//       int shift = 0;
//       int result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       final int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;
//
//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       final int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;
//
//       points.add(LatLng(lat / 1E5, lng / 1E5));
//     }
//
//     return points;
//   }
//
//   void _showOTPDialog() {
//     TextEditingController otpController = TextEditingController();
//     bool isVerifying = false;
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             return AlertDialog(
//               title: Text('Enter OTP'),
//               content: TextField(
//                 controller: otpController,
//                 keyboardType: TextInputType.number,
//                 maxLength: 4,
//                 decoration: InputDecoration(
//                   labelText: 'OTP',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     String otp = otpController.text;
//                     if (otp.length != 4) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text("Please enter 4 digit valid OTP"),
//                         ),
//                       );
//                       return;
//                     }
//
//                     // ✅ Local dialog state update
//                     setDialogState(() {
//                       isVerifying = true;
//                     });
//
//                     try {
//                       final body = DeliveryOnGoingBodyModel(
//                         txId: widget.txtid,
//                         otp: otp,
//                       );
//                       final service = APIStateNetwork(callDio());
//                       final response = await service.deliveryOnGoing(body);
//
//                       if (response.code == 0) {
//                         Fluttertoast.showToast(msg: response.message);
//                         Navigator.of(context).pop();
//                         Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) => DropOffPage(),
//                           ),
//                         );
//                       } else {
//                         Fluttertoast.showToast(msg: response.message);
//                       }
//                     } catch (e, st) {
//                       log(e.toString());
//                       log(st.toString());
//                       Fluttertoast.showToast(msg: e.toString());
//                     } finally {
//                       // ✅ Stop loading
//                       setDialogState(() {
//                         isVerifying = false;
//                       });
//                       otpController.clear();
//                     }
//                   },
//                   child: isVerifying
//                       ? SizedBox(
//                     width: 20.w,
//                     height: 20.h,
//                     child: CircularProgressIndicator(strokeWidth: 2),
//                   )
//                       : Text('Verify'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   bool isLoading = false;
//
//   Future<void> _makePhoneCall(String phoneNumber) async {
//     final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
//     await launchUrl(launchUri);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final customer = widget.deliveryData.customer;
//     final pickup = widget.deliveryData.pickup;
//     final dropoff = widget.deliveryData.dropoff;
//     final packageDetails = widget.deliveryData.packageDetails;
//     final senderName = customer != null
//         ? '${customer.firstName ?? ''} ${customer.lastName ?? ''}'
//         : 'Unknown Sender';
//     final deliveries = customer?.completedOrderCount ?? 0;
//     final rating = customer?.averageRating ?? 0;
//     final phone = customer?.phone ?? '';
//     final packageType = packageDetails?.fragile == true
//         ? 'Fragile Item'
//         : 'Electronics/Gadgets';
//     final pickupLocation = pickup?.name ?? 'Unknown Pickup';
//     final dropLocation = dropoff?.name ?? 'Unknown Drop';
//
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xFFFFFFFF),
//         shape: const CircleBorder(),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         child: const Icon(Icons.arrow_back, color: Color(0xFF1D3557)),
//       ),
//       body: _currentLatLng == null
//           ? const Center(child: CircularProgressIndicator())
//           : Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: _currentLatLng!,
//               zoom: 15,
//             ),
//             onMapCreated: (controller) {
//               _mapController = controller;
//               if (_currentLatLng != null) {
//                 _mapController!.animateCamera(
//                   CameraUpdate.newLatLng(_currentLatLng!),
//                 );
//               }
//               if (!_routeFetched &&
//                   (widget.pickupLat != null || widget.dropLat != null)) {
//                 _routeFetched = true;
//                 _fetchRoute();
//               }
//             },
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//             markers: _markers,
//             polylines: _polylines,
//           ),
//
//           if (toPickupDistance != null || pickupToDropDistance != null)
//             Positioned(
//               bottom: 70.h,
//               left: 16.w,
//               right: 16.w,
//               child: Container(
//                 padding: EdgeInsets.all(12.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (toPickupDistance != null)
//                       Text(
//                         'To Pickup: $toPickupDistance | $toPickupDuration',
//                         style: GoogleFonts.inter(fontSize: 14.sp),
//                       ),
//                     if (pickupToDropDistance != null)
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 4.h),
//                         child: Text(
//                           'To Drop: $pickupToDropDistance | $pickupToDropDuration',
//                           style: GoogleFonts.inter(fontSize: 14.sp),
//                         ),
//                       ),
//                     Text(
//                       'Total: $totalDistance | $totalDuration',
//                       style: GoogleFonts.inter(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//           Positioned(
//             bottom: 15.h,
//             child: Container(
//               margin: EdgeInsets.only(left: 18.w, right: 18.w),
//               width: 340.w,
//               height:
//               300.h, // Increased height to accommodate more content
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15.r),
//                 color: Color(0xFFFFFFFF),
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 4),
//                     blurRadius: 20,
//                     spreadRadius: 0,
//                     color: Color.fromARGB(114, 0, 0, 0),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 20.w, right: 20.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Container(
//                         margin: EdgeInsets.only(top: 15.h),
//                         width: 33.w,
//                         height: 4.h,
//                         decoration: BoxDecoration(
//                           color: Color.fromARGB(127, 203, 205, 204),
//                           borderRadius: BorderRadius.circular(10.r),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                     Row(
//                       children: [
//                         Container(
//                           width: 56.w,
//                           height: 56.h,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color(0xFFA8DADC),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "${senderName.substring(0, 2).toUpperCase()}",
//                               style: GoogleFonts.inter(
//                                 fontSize: 24.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xFF4F4F4F),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.w),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 senderName,
//                                 style: GoogleFonts.inter(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xFF111111),
//                                 ),
//                               ),
//                               Text(
//                                 "$deliveries Deliveries",
//                                 style: GoogleFonts.inter(
//                                   fontSize: 13.sp,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xFF4F4F4F),
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   for (int i = 0; i < 5; i++)
//                                     Icon(
//                                       Icons.star,
//                                       color: i < rating
//                                           ? Colors.yellow
//                                           : Colors.grey,
//                                       size: 16.sp,
//                                     ),
//                                   SizedBox(width: 5.w),
//                                   Text(
//                                     "$rating",
//                                     style: GoogleFonts.inter(
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xFF4F4F4F),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       packageType,
//                       style: GoogleFonts.inter(
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF00122E),
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       "Pickup: $pickupLocation",
//                       style: GoogleFonts.inter(
//                         fontSize: 13.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF545454),
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       "Drop: $dropLocation",
//                       style: GoogleFonts.inter(
//                         fontSize: 13.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF545454),
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     GestureDetector(
//                       onTap: () => _makePhoneCall(phone),
//                       child: Text.rich(
//                         TextSpan(
//                           children: [
//                             TextSpan(
//                               text:
//                               "Recipient: ${dropoff?.name ?? 'Unknown'}",
//                               style: GoogleFonts.inter(
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xFF545454),
//                               ),
//                             ),
//                             TextSpan(
//                               text: "    $phone",
//                               style: GoogleFonts.inter(
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xFF0945DE),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(306.w, 45.h),
//                         backgroundColor: Color(0xFF006970),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(3.r),
//                           side: BorderSide.none,
//                         ),
//                       ),
//                       onPressed: () async {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         try {
//                           final body = DeliveryPickedReachedBodyModel(
//                             txId: widget.txtid,
//                           );
//                           final service = APIStateNetwork(callDio());
//
//                           final response = await service
//                               .pickedOrReachedDelivery(body);
//                           if (response.code == 0) {
//                             Fluttertoast.showToast(msg: response.message);
//                             _showOTPDialog();
//                             setState(() {
//                               isLoading = false;
//                             });
//                           } else {
//                             Fluttertoast.showToast(msg: response.message);
//                             setState(() {
//                               isLoading = false;
//                             });
//                           }
//                         } catch (e, st) {
//                           log(e.toString());
//                           log(st.toString());
//                           Fluttertoast.showToast(msg: e.toString());
//                           setState(() {
//                             isLoading = false;
//                           });
//                         }
//                       },
//                       child: isLoading
//                           ? Center(
//                         child: SizedBox(
//                           width: 20.w,
//                           height: 20.h,
//
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2.w,
//                           ),
//                         ),
//                       )
//                           : Text(
//                         "Pickup",
//                         style: GoogleFonts.inter(
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }


import 'dart:developer';
import 'package:delivery_rider_app/RiderScreen/enroutePickup.page.dart';
import 'package:delivery_rider_app/RiderScreen/processDropOff.page.dart';
import 'package:delivery_rider_app/config/utils/pretty.dio.dart';
import 'package:delivery_rider_app/data/model/deliveryOnGoingBodyModel.dart';
import 'package:delivery_rider_app/data/model/deliveryPickedReachedBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../config/network/api.state.dart';
import '../data/model/DeliveryResponseModel.dart';
import 'dropOff.page.dart';

class MapLiveScreen extends StatefulWidget {
  final Data deliveryData;
  final double? pickupLat;
  final double? pickupLong;
  final double? dropLat;
  final double? droplong;
  final String txtid;
  const MapLiveScreen({
    this.pickupLat,
    this.pickupLong,
    this.dropLat,
    this.droplong,
    super.key,
    required this.deliveryData,
    required this.txtid,
  });

  @override
  State<MapLiveScreen> createState() => _MapLiveScreenState();
}

class _MapLiveScreenState extends State<MapLiveScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> _routePoints = [];
  bool _routeFetched = false;
  String? toPickupDistance;
  String? toPickupDuration;
  String? pickupToDropDistance;
  String? pickupToDropDuration;
  String? totalDistance;
  String? totalDuration;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permission denied")),
          );
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Location permission permanently denied. Please enable it from settings.",
            ),
          ),
        );
      }
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (mounted) {
      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
      });
      _addMarkers();
    }
  }

  void _addMarkers() {
    _markers.clear(); // Clear previous markers to avoid duplicates
    if (_currentLatLng != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current'),
          position: _currentLatLng!,
          infoWindow: const InfoWindow(title: 'Current Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        ),
      );
    }
    if (widget.pickupLat != null && widget.pickupLong != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: LatLng(widget.pickupLat!, widget.pickupLong!),
          infoWindow: const InfoWindow(title: 'Pickup Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
    if (widget.dropLat != null && widget.droplong != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('drop'),
          position: LatLng(widget.dropLat!, widget.droplong!),
          infoWindow: const InfoWindow(title: 'Drop Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
        ),
      );
    }
    setState(() {});
  }

  Future<void> _fetchRoute() async {
    if (_currentLatLng == null) {
      print('Error: Current location is null');
      return;
    }
    if (widget.pickupLat == null || widget.pickupLong == null) {
      print('Error: Pickup location is null');
      return;
    }

    // Temporary Mock: Fake data for testing (remove this block when using real API)
    List<LatLng> points1 = [];
    double dist1 = 2.5; // Fake distance to pickup
    int time1 = 10; // Fake duration to pickup
    // Generate simple straight-line points from current to pickup (for demo)
    if (_currentLatLng != null &&
        widget.pickupLat != null &&
        widget.pickupLong != null) {
      points1 = _generateMockPolyline(
        _currentLatLng!,
        LatLng(widget.pickupLat!, widget.pickupLong!),
        20,
      ); // 20 points for smooth line
    }

    List<LatLng> points2 = [];
    double dist2 = 3.2; // Fake distance from pickup to drop
    int time2 = 15; // Fake duration from pickup to drop
    if (widget.dropLat != null && widget.droplong != null) {
      points2 = _generateMockPolyline(
        LatLng(widget.pickupLat!, widget.pickupLong!),
        LatLng(widget.dropLat!, widget.droplong!),
        25,
      );
    }

    List<LatLng> allPoints = [...points1, ...points2];

    setState(() {
      _polylines.clear();
      if (points1.isNotEmpty) {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('toPickup'),
            points: points1,
            color: Colors.green,
            width: 5,
          ),
        );
        toPickupDistance = '${dist1.toStringAsFixed(1)} km';
        toPickupDuration = '${time1.toStringAsFixed(0)} min';
      }
      if (points2.isNotEmpty) {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('toDrop'),
            points: points2,
            color: Colors.blue,
            width: 5,
          ),
        );
        pickupToDropDistance = '${dist2.toStringAsFixed(1)} km';
        pickupToDropDuration = '${time2.toStringAsFixed(0)} min';
      }
      totalDistance = '${(dist1 + dist2).toStringAsFixed(1)} km';
      totalDuration = '${(time1 + time2).toStringAsFixed(0)} min';
      _routePoints = allPoints;
    });

    // Animate camera to fit the route
    if (_mapController != null && allPoints.isNotEmpty) {
      LatLngBounds bounds = _calculateBounds(allPoints);
      _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }

    print(
      'Mock route loaded: ${points1.length} points to pickup, ${points2.length} to drop',
    ); // Debug
  }

  List<LatLng> _generateMockPolyline(LatLng start, LatLng end, int numPoints) {
    List<LatLng> points = [];
    double latStep = (end.latitude - start.latitude) / numPoints;
    double lngStep = (end.longitude - start.longitude) / numPoints;
    for (int i = 0; i <= numPoints; i++) {
      double lat = start.latitude + (latStep * i);
      double lng = start.longitude + (lngStep * i);
      points.add(LatLng(lat, lng));
    }
    return points;
  }

  LatLngBounds _calculateBounds(List<LatLng> points) {
    if (points.isEmpty) {
      return LatLngBounds(
        southwest: _currentLatLng!,
        northeast: _currentLatLng!,
      );
    }
    double minLat = points[0].latitude;
    double maxLat = points[0].latitude;
    double minLng = points[0].longitude;
    double maxLng = points[0].longitude;

    for (LatLng point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    // Include pickup and drop if not in points
    if (widget.pickupLat != null && widget.pickupLong != null) {
      LatLng pickup = LatLng(widget.pickupLat!, widget.pickupLong!);
      if (pickup.latitude < minLat) minLat = pickup.latitude;
      if (pickup.latitude > maxLat) maxLat = pickup.latitude;
      if (pickup.longitude < minLng) minLng = pickup.longitude;
      if (pickup.longitude > maxLng) maxLng = pickup.longitude;
    }
    if (widget.dropLat != null && widget.droplong != null) {
      LatLng drop = LatLng(widget.dropLat!, widget.droplong!);
      if (drop.latitude < minLat) minLat = drop.latitude;
      if (drop.latitude > maxLat) maxLat = drop.latitude;
      if (drop.longitude < minLng) minLng = drop.longitude;
      if (drop.longitude > maxLng) maxLng = drop.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = <LatLng>[];
    int index = 0;
    final int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      final int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      final int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  bool isLoading = false;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    final customer = widget.deliveryData.customer;
    final pickup = widget.deliveryData.pickup;
    final dropoff = widget.deliveryData.dropoff;
    final packageDetails = widget.deliveryData.packageDetails;
    final senderName = customer != null
        ? '${customer.firstName ?? ''} ${customer.lastName ?? ''}'
        : 'Unknown Sender';
    final deliveries = customer?.completedOrderCount ?? 0;
    final rating = customer?.averageRating ?? 0;
    final phone = customer?.phone ?? '';
    final packageType = packageDetails?.fragile == true
        ? 'Fragile Item'
        : 'Electronics/Gadgets';
    final pickupLocation = pickup?.name ?? 'Unknown Pickup';
    final dropLocation = dropoff?.name ?? 'Unknown Drop';

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFFFFF),
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back, color: Color(0xFF1D3557)),
      ),
      body: _currentLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLatLng!,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
              if (_currentLatLng != null) {
                _mapController!.animateCamera(
                  CameraUpdate.newLatLng(_currentLatLng!),
                );
              }
              if (!_routeFetched &&
                  (widget.pickupLat != null || widget.dropLat != null)) {
                _routeFetched = true;
                _fetchRoute();
              }
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
            polylines: _polylines,
          ),

          if (toPickupDistance != null || pickupToDropDistance != null)
            Positioned(
              bottom: 70.h,
              left: 16.w,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (toPickupDistance != null)
                      Text(
                        'To Pickup: $toPickupDistance | $toPickupDuration',
                        style: GoogleFonts.inter(fontSize: 14.sp),
                      ),
                    if (pickupToDropDistance != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Text(
                          'To Drop: $pickupToDropDistance | $pickupToDropDuration',
                          style: GoogleFonts.inter(fontSize: 14.sp),
                        ),
                      ),
                    Text(
                      'Total: $totalDistance | $totalDuration',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Positioned(
            bottom: 15.h,
            child: Container(
              margin: EdgeInsets.only(left: 18.w, right: 18.w),
              width: 340.w,
              height:
              300.h, // Increased height to accommodate more content
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
                        margin: EdgeInsets.only(top: 15.h),
                        width: 33.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(127, 203, 205, 204),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
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
                              "${senderName.substring(0, 2).toUpperCase()}",
                              style: GoogleFonts.inter(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4F4F4F),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                senderName,
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF111111),
                                ),
                              ),
                              Text(
                                "$deliveries Deliveries",
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4F4F4F),
                                ),
                              ),
                              Row(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    Icon(
                                      Icons.star,
                                      color: i < rating
                                          ? Colors.yellow
                                          : Colors.grey,
                                      size: 16.sp,
                                    ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "$rating",
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
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      packageType,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF00122E),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Pickup: $pickupLocation",
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF545454),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Drop: $dropLocation",
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF545454),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => _makePhoneCall(phone),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                              "Recipient: ${dropoff?.name ?? 'Unknown'}",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF545454),
                              ),
                            ),
                            TextSpan(
                              text: "   $phone",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0945DE),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
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
                            builder: (context) =>
                                ProcessDropOffPage(txtid: widget.txtid),
                          ),
                        );
                      },
                      child: isLoading
                          ? Center(
                        child: SizedBox(
                          width: 20.w,
                          height: 20.h,

                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.w,
                          ),
                        ),
                      )
                          : Text(
                        "complete",
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