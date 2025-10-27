//
// import 'dart:developer';
// import 'dart:async';
// import 'package:delivery_rider_app/RiderScreen/booking.page.dart';
// import 'package:delivery_rider_app/RiderScreen/earning.page.dart';
// import 'package:delivery_rider_app/RiderScreen/profile.page.dart';
// import 'package:delivery_rider_app/RiderScreen/requestDetails.page.dart';
// import 'package:delivery_rider_app/RiderScreen/vihical.page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:geolocator/geolocator.dart';
// import '../config/network/api.state.dart';
// import '../config/utils/pretty.dio.dart';
// import 'identityCard.page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   bool isVisible = true;
//   int selectIndex = 0;
//   String firstName = '';
//   String lastName = '';
//   String status = '';
//   double balance = 0;
//   String? driverId;
//   bool isStatus = false;
//   late IO.Socket socket;
//   bool isSocketConnected = false;
//   @override
//   void initState() {
//     super.initState();
//     getDriverProfile(); // Fetch profile when screen loads
//   }
//
//   @override
//   void dispose() {
//     socket.dispose();
//     super.dispose();
//   }
//
//   /// Fetch driver profile
//   Future<void> getDriverProfile() async {
//     try {
//       final dio = await callDio();
//       final service = APIStateNetwork(dio);
//       final response = await service.getDriverProfile();
//
//       if (response.error == false && response.data != null) {
//         setState(() {
//           firstName = response.data!.firstName ?? '';
//           lastName = response.data!.lastName ?? '';
//           status = response.data!.status ?? '';
//           balance = response.data!.wallet?.balance?.toDouble() ?? 0;
//           driverId = response.data!.id ?? '';
//         });
//
//         if (driverId != null && driverId!.isNotEmpty) {
//           _connectSocket();
//         }
//       } else {
//         Fluttertoast.showToast(
//           msg: response.message ?? "Failed to fetch profile",
//         );
//       }
//     } catch (e, st) {
//       log("Get Driver Profile Error: $e\n$st");
//       Fluttertoast.showToast(
//         msg: "Something went wrong while fetching profile",
//       );
//     }
//   }
//
//   /// Connect Socket
//   void _connectSocket() {
//     // const socketUrl = 'https://weloads.com'; // Your backend URL
//     const socketUrl = 'http://192.168.1.43:4567'; // Your backend URL
//     socket = IO.io(socketUrl, <String, dynamic>{
//       'transports': ['websocket', 'polling'],
//       'autoConnect': false,
//     });
//
//     socket.connect();
//
//     socket.onConnect((_) async {
//       print('✅ Socket connected: ${socket.id}');
//       setState(() => isSocketConnected = true);
//
//       if (driverId != null && driverId!.isNotEmpty) {
//         socket.emit('register', {'userId': driverId, 'role': 'driver'});
//         print('📡 Register event emitted with driverId: $driverId');
//       }
//
//       Fluttertoast.showToast(msg: "Socket Connected Successfully!");
//
//       // Send current location immediately
//       final position = await _getCurrentLocation();
//       if (position != null) {
//         socket.emit('user:location_update', {
//           'userId': driverId,
//           'lat': position.latitude,
//           'lon': position.longitude,
//         });
//         print(
//           '📤 Location sent → lat: ${position.latitude}, lon: ${position.longitude}',
//         );
//       }
//
//       // Optional: periodic updates every 10 seconds
//       Timer.periodic(Duration(seconds: 10), (timer) async {
//         if (socket.connected && driverId != null) {
//           final pos = await _getCurrentLocation();
//           if (pos != null) {
//             socket.emit('user:location_update', {
//               'userId': driverId,
//               'lat': pos.latitude,
//               'lon': pos.longitude,
//             });
//             print(
//               '📤 Periodic location → lat: ${pos.latitude}, lon: ${pos.longitude}',
//             );
//           }
//         }
//       });
//
//       // Listen for backend events
//       socket.on('delivery:new_request', _handleNewRequest);
//       socket.on('delivery:you_assigned', _handleAssigned);
//
//       socket.onAny((event, data) {
//         print('📩 Event received → $event : $data');
//       });
//     });
//
//     socket.onDisconnect((_) {
//       print('🔌 Socket disconnected');
//       setState(() => isSocketConnected = false);
//       Fluttertoast.showToast(msg: "Socket Disconnected!");
//     });
//
//     socket.onConnectError((error) {
//       print('❌ Socket connection error: $error');
//       setState(() => isSocketConnected = false);
//       Fluttertoast.showToast(msg: "Socket Connection Error: $error");
//     });
//
//     socket.onError((error) {
//       print('⚠️ Socket error: $error');
//     });
//   }
//
//   /// Get Current Location
//   Future<Position?> _getCurrentLocation() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         Fluttertoast.showToast(msg: "Please enable location services");
//         return null;
//       }
//
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           Fluttertoast.showToast(msg: "Location permission denied");
//           return null;
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         Fluttertoast.showToast(msg: "Location permission permanently denied");
//         return null;
//       }
//
//       return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//     } catch (e) {
//       log("Error getting location: $e");
//       return null;
//     }
//   }
//
//   /* void _handleNewRequest(dynamic payload) {
//     print("🚚 New Delivery Request: $payload");
//     final requestData = Map<String, dynamic>.from(payload as Map);
//     final requestWithTimer = DeliveryRequest(
//       deliveryId: requestData['deliveryId'] as String,
//       category: requestData['category'] ?? 'Unknown Category',
//       recipient: requestData['recipient'] ?? 'Unknown Recipient',
//       dropOffLocation: requestData['dropOffLocation'] ?? 'Unknown Location',
//       countdown: 1000,
//     );
//     _showRequestPopup(requestWithTimer);
//   }
// */
//
//   void _handleNewRequest(dynamic payload) {
//     print("🚚 New Delivery Request: $payload");
//     final requestData = Map<String, dynamic>.from(payload as Map);
//
//     final dropoff = requestData['dropoff'] as Map<String, dynamic>? ?? {};
//     final pickup =
//         requestData['pickup'] as Map<String, dynamic>? ??
//         {}; // Optional: for future use
//
//     final expiresAt = requestData['expiresAt'] as int? ?? 0;
//     final nowMs = DateTime.now().millisecondsSinceEpoch;
//     final countdownMs = expiresAt - nowMs;
//     final countdown = (countdownMs > 0 ? (countdownMs / 1000).round() : 0);
//
//     if (countdown <= 0) {
//       print("⚠️ Request expired before showing popup.");
//       // Optional: Call _skipDelivery here if you want to auto-reject expired requests
//       return;
//     }
//
//     final requestWithTimer = DeliveryRequest(
//       deliveryId: requestData['deliveryId'] as String? ?? '',
//       category:
//           'Delivery', // Customize if needed, e.g., pickup['name'] ?? 'Unknown Category'
//       recipient: dropoff['name'] ?? 'Unknown Recipient',
//       dropOffLocation: dropoff['name'] ?? 'Unknown Location',
//       countdown: countdown,
//     );
//
//     _showRequestPopup(requestWithTimer);
//   }
//
//   Future<void> _handleAssigned(dynamic payload) async {
//     print("✅ Delivery Assigned: ${payload['deliveryId']}");
//     final deliveryId = payload['deliveryId'] as String;
//     try {
//       final dio = await callDio();
//       final service = APIStateNetwork(dio);
//       final response = await service.getDeliveryById(deliveryId);
//       if (response.error == false && response.data != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => RequestDetailsPage(
//               deliveryData: response.data!,
//               txtID: response.data!.txId.toString(),
//             ),
//           ),
//         ).then((_) {
//           print('🔙 Back from details | Skipping delivery to free for new requests');
//           getDriverProfile(); // Existing refresh
//           });
//
//
//       } else {
//         Fluttertoast.showToast(
//           msg: response.message ?? "Failed to fetch delivery details",
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error fetching delivery details");
//     }
//   }
//
//   void _acceptDelivery(String deliveryId) {
//     if (socket.connected) {
//       socket.emitWithAck(
//         'delivery:accept',
//         {'deliveryId': deliveryId},
//         ack: (ackData) {
//           print('Accept ack: $ackData');
//         },
//       );
//       Fluttertoast.showToast(msg: "Delivery Accepted!");
//     } else {
//       Fluttertoast.showToast(msg: "Socket not connected!");
//     }
//   }
//
//   void _skipDelivery(String deliveryId) {
//     if (socket.connected) {
//       socket.emitWithAck(
//         'delivery:skip',
//         {'deliveryId': deliveryId},
//         ack: (ackData) {
//           print('Skip ack: $ackData');
//         },
//       );
//       Fluttertoast.showToast(msg: "Delivery Rejected!");
//     } else {
//       Fluttertoast.showToast(msg: "Socket not connected!");
//     }
//   }
//
//   void _showRequestPopup(DeliveryRequest req) {
//     Timer? countdownTimer;
//     int currentCountdown = req.countdown;
//
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//           if (mounted && dialogContext.mounted) {
//             setState(() {
//               currentCountdown--;
//             });
//             if (currentCountdown <= 0) {
//               timer.cancel();
//               // _skipDelivery(req.deliveryId);
//               // if (dialogContext.mounted) Navigator.of(dialogContext).pop();
//               // Fluttertoast.showToast(
//               //   msg: "Time expired! Delivery auto-rejected.",
//               // );
//             }
//           }
//         });
//
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setDialogState) {
//             return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//               ),
//               title: Text(req.category),
//
//               // content: Column(
//               //   mainAxisSize: MainAxisSize.min,
//               //   crossAxisAlignment: CrossAxisAlignment.start,
//               //   children: [
//               //
//               //     Text("Recipient: ${req.recipient}"),
//               //     SizedBox(height: 8.h),
//               //     Row(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         Icon(Icons.location_on, size: 16.sp, color: Colors.green),
//               //         SizedBox(width: 5.w),
//               //         Expanded(child: Text(req.dropOffLocation)),
//               //       ],
//               //     ),
//               //     SizedBox(height: 8.h),
//               //
//               //     Text(
//               //         "Time left: ${currentCountdown}s",
//               //         style: TextStyle(color: currentCountdown <= 3 ? Colors.red : Colors.green)
//               //     ),
//               //
//               //   ],
//               // ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(req.category),
//                   SizedBox(height: 8.h),
//                   // Add pickup row
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Icon(Icons.location_on, size: 16.sp, color: Colors.blue),
//                       SizedBox(width: 5.w),
//                       // Expanded(child: Text("Pickup: ${req.pickupName ?? 'Unknown Pickup'}")), // You'd need to add pickupName to DeliveryRequest
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Text("Recipient: ${req.recipient}"),
//                   SizedBox(height: 8.h),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Icon(Icons.location_on, size: 16.sp, color: Colors.green),
//                       SizedBox(width: 5.w),
//                       Expanded(child: Text(req.dropOffLocation)),
//                     ],
//                   ),
//                   SizedBox(height: 8.h),
//                   Text(
//                     "Time left: ${currentCountdown}s",
//                     style: TextStyle(
//                       color: currentCountdown <= 3 ? Colors.red : Colors.green,
//                     ),
//                   ),
//                 ],
//               ),
//
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     countdownTimer?.cancel();
//                     Navigator.of(dialogContext).pop();
//                     _skipDelivery(req.deliveryId);
//                   },
//                   child: const Text("Reject"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     countdownTimer?.cancel();
//                     Navigator.of(dialogContext).pop();
//                     _acceptDelivery(req.deliveryId);
//                   },
//                   child: const Text("Accept"),
//                 ),
//               ],
//
//             );
//           },
//         );
//       },
//     ).then((_) => countdownTimer?.cancel());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: selectIndex == 0
//           ? Padding(
//               padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 55.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Welcome Back"),
//                           Text("$firstName $lastName"),
//                         ],
//                       ),
//                       const Spacer(),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(Icons.notifications),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           selectIndex = 4;
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(left: 5.w),
//                           width: 35.w,
//                           height: 35.h,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color(0xFFA8DADC),
//                           ),
//                           child: Center(
//                             child: Text(
//                               firstName.isNotEmpty
//                                   ? "${firstName[0]}${lastName[0]}"
//                                   : "AS",
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16.h),
//
//                   status == "pending"
//                       ? GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => IdentityCardPage(),
//                               ),
//                             ).then((_) {
//                               getDriverProfile();
//                             });
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(10.sp),
//
//                             height: 91.h,
//                             width: double.infinity,
//                             decoration: BoxDecoration(color: Color(0xffFDF1F1)),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Identity Verification",
//                                             style: GoogleFonts.inter(
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w600,
//                                               color: Color(0xFF111111),
//                                             ),
//                                           ),
//
//                                           SizedBox(height: 5.h),
//                                           Text(
//                                             "Add your driving license, or any other means of  driving identification used in your country",
//                                             style: GoogleFonts.inter(
//                                               fontSize: 12.sp,
//                                               fontWeight: FontWeight.w400,
//                                               color: Color(0xFF111111),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//
//                                     // SvgPicture.asset(
//                                     //   "assets/SvgImage/Group.svg",
//                                     //   // color: Color(0xFFC0C5C2),
//                                     // ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : SizedBox(),
//
//                   SizedBox(height: 10.h),
//
//                   status == "pending"
//                       ? GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => VihicalPage(),
//                               ),
//                             ).then((_) {
//                               getDriverProfile();
//                             });
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(10.sp),
//
//                             height: 91.h,
//                             width: double.infinity,
//                             decoration: BoxDecoration(color: Color(0xffFDF1F1)),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Add Vehicle",
//                                             style: GoogleFonts.inter(
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w600,
//                                               color: Color(0xFF111111),
//                                             ),
//                                           ),
//
//                                           SizedBox(height: 5.h),
//                                           Text(
//                                             "Upload insurance and registration documents of the vehicle you intend to use.",
//                                             style: GoogleFonts.inter(
//                                               fontSize: 12.sp,
//                                               fontWeight: FontWeight.w400,
//                                               color: Color(0xFF111111),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//
//                                     // SvgPicture.asset(
//                                     //   "assets/SvgImage/Group.svg",
//                                     //   // color: Color(0xFFC0C5C2),
//                                     // ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : SizedBox(),
//
//                   SizedBox(height: 20.h),
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4.r),
//                       color: const Color(0xFFD1E5E6),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Available balance"),
//                         SizedBox(height: 3.h),
//                         Row(
//                           children: [
//                             Text(isVisible ? "₹ $balance" : "****"),
//                             IconButton(
//                               onPressed: () =>
//                                   setState(() => isVisible = !isVisible),
//                               icon: Icon(
//                                 isVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Divider(color: Color(0xFFE5E5E5)),
//                   SizedBox(height: 15.h),
//                   Text(
//                     "Would you like to specify direction for deliveries?",
//                     style: GoogleFonts.inter(
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xFF111111),
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   TextField(
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(
//                         left: 15.w,
//                         right: 15.w,
//                         top: 10.h,
//                         bottom: 10.h,
//                       ),
//                       filled: true,
//                       fillColor: Color(0xFFF0F5F5),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.r),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.r),
//                         borderSide: BorderSide.none,
//                       ),
//                       hint: Text(
//                         "Where to?",
//                         style: GoogleFonts.inter(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFFAFAFAF),
//                         ),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.circle_outlined,
//                         color: Color(0xFF28B877),
//                         size: 18.sp,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//                   Row(
//                     children: [
//                       Text(
//                         "Available Requests",
//                         style: GoogleFonts.inter(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF111111),
//                         ),
//                       ),
//                       Spacer(),
//                       Text(
//                         "View all",
//                         style: GoogleFonts.inter(
//                           fontSize: 13.sp,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF006970),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.delivery_dining,
//                             size: 64.sp,
//                             color: Colors.grey,
//                           ),
//                           SizedBox(height: 16.h),
//                           Text("Waiting for new delivery requests..."),
//                           SizedBox(height: 8.h),
//                           // Text("Socket: ${isSocketConnected ? 'Connected' : 'Disconnected'}",
//                           //     style: TextStyle(color: isSocketConnected ? Colors.green : Colors.red)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : selectIndex == 1
//           ? EarningPage()
//           : selectIndex == 2
//           ? BookingPage()
//           : ProfilePage(),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//     );
//   }
//
//   Widget _buildBottomNavigationBar() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10.r),
//           topRight: Radius.circular(10.r),
//         ),
//         color: const Color(0xFFFFFFFF),
//         boxShadow: [
//           BoxShadow(
//             offset: const Offset(0, -2),
//             blurRadius: 30,
//             spreadRadius: 0,
//             color: const Color.fromARGB(17, 0, 0, 0),
//           ),
//         ],
//       ),
//       child: BottomNavigationBar(
//         onTap: (value) {
//           setState(() {
//             selectIndex = value;
//           });
//           if (value == 0) {
//             getDriverProfile();
//           }
//         },
//         backgroundColor: const Color(0xFFFFFFFF),
//         currentIndex: selectIndex,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: const Color(0xFF006970),
//         unselectedItemColor: const Color(0xFFC0C5C2),
//         unselectedLabelStyle: GoogleFonts.inter(
//           fontSize: 10.sp,
//           fontWeight: FontWeight.w400,
//           color: const Color(0xFFC0C5C2),
//         ),
//         selectedLabelStyle: GoogleFonts.inter(
//           fontSize: 12.sp,
//           fontWeight: FontWeight.w400,
//           color: const Color(0xFF006970),
//         ),
//         items: [
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               "assets/SvgImage/iconhome.svg",
//               color: const Color(0xFFC0C5C2),
//             ),
//             activeIcon: SvgPicture.asset(
//               "assets/SvgImage/iconhome.svg",
//               color: const Color(0xFF006970),
//             ),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               "assets/SvgImage/iconearning.svg",
//               color: const Color(0xFFC0C5C2),
//             ),
//             activeIcon: SvgPicture.asset(
//               "assets/SvgImage/iconearning.svg",
//               color: const Color(0xFF006970),
//             ),
//             label: "Earning",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               "assets/SvgImage/iconbooking.svg",
//               color: const Color(0xFFC0C5C2),
//             ),
//             activeIcon: SvgPicture.asset(
//               "assets/SvgImage/iconbooking.svg",
//               color: const Color(0xFF006970),
//             ),
//             label: "Booking",
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               "assets/SvgImage/iconProfile.svg",
//               color: const Color(0xFFC0C5C2),
//             ),
//             activeIcon: SvgPicture.asset(
//               "assets/SvgImage/iconProfile.svg",
//               color: const Color(0xFF006970),
//             ),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DeliveryRequest {
//   final String deliveryId;
//   final String category;
//   final String recipient;
//   final String dropOffLocation;
//   final int countdown;
//
//   DeliveryRequest({
//     required this.deliveryId,
//     required this.category,
//     required this.recipient,
//     required this.dropOffLocation,
//     required this.countdown,
//   });
// }

import 'dart:developer';
import 'dart:async';
import 'package:delivery_rider_app/RiderScreen/booking.page.dart';
import 'package:delivery_rider_app/RiderScreen/earning.page.dart';
import 'package:delivery_rider_app/RiderScreen/profile.page.dart';
import 'package:delivery_rider_app/RiderScreen/requestDetails.page.dart';
import 'package:delivery_rider_app/RiderScreen/vihical.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:geolocator/geolocator.dart';
import '../config/network/api.state.dart';
import '../config/utils/pretty.dio.dart';
import 'identityCard.page.dart';

class HomePage extends StatefulWidget {
  int? selectIndex;
   HomePage(this.selectIndex,{super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool isVisible = true;
  int selectIndex = 0;
  String firstName = '';
  String lastName = '';
  String status = '';
  double balance = 0;
  String? driverId;
  bool isStatus = false;
  IO.Socket? socket;  // Changed to nullable for safe handling
  bool isSocketConnected = false;
  Timer? _locationTimer;

  @override
  void initState() {
    super.initState();
    selectIndex=widget.selectIndex!;
    WidgetsBinding.instance.addObserver(this);
    getDriverProfile(); // Fetch profile when screen loads
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _locationTimer?.cancel();
    _disconnectSocket();  // Safe disconnect on dispose
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('📱 App lifecycle changed to: $state');
    if (state == AppLifecycleState.resumed) {
      print('📱 App resumed - ensuring socket connection...');
      Future.delayed(const Duration(seconds: 1), () {  // Small delay for full resume
        if (mounted) {
          _ensureSocketConnected();
        }
      });
    } else if (state == AppLifecycleState.paused) {
      print('📱 App paused - socket may disconnect');
      _locationTimer?.cancel();
    }
  }

  /// Ensure socket is connected: Force disconnect old and connect new if needed
  void _ensureSocketConnected() {
    if (driverId != null && driverId!.isNotEmpty) {
      _disconnectSocket();  // Always force fresh connection on enter/resume
      _connectSocket();
    }
  }

  /// Disconnect and clean up old socket
  void _disconnectSocket() {
    if (socket != null) {
      if (socket!.connected) {
        socket!.disconnect();
      }
      socket!.clearListeners();  // Remove all listeners to prevent duplicates
      socket!.dispose();
      socket = null;
    }
    _locationTimer?.cancel();
    if (mounted) {
      setState(() => isSocketConnected = false);
    }
    print('🔌 Old socket disconnected and cleaned');
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
          });
        }

        if (driverId != null && driverId!.isNotEmpty) {
          _ensureSocketConnected();  // Use ensure to force fresh on profile load
        }
      } else {
        Fluttertoast.showToast(
          msg: response.message ?? "Failed to fetch profile",
        );
      }
    } catch (e, st) {
      log("Get Driver Profile Error: $e\n$st");
      Fluttertoast.showToast(
        msg: "Something went wrong while fetching profile",
      );
    }
  }

  /// Connect Socket (fresh instance)
  void _connectSocket() {
    // const socketUrl = 'http://192.168.1.43:4567'; // Your backend URL
    const socketUrl = 'https://weloads.com'; // Your backend URL
    socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket', 'polling'],
      'autoConnect': false,
    });
    socket!.connect();
    socket!.onConnect((_) async {
      print('✅ New socket connected: ${socket!.id}');
      if (mounted) {setState(() => isSocketConnected = true);}
      if (driverId != null && driverId!.isNotEmpty) {socket!.emit('register', {'userId': driverId, 'role': 'driver'});print('📡 Register event emitted with driverId: $driverId');}
      Fluttertoast.showToast(msg: "Socket Connected Successfully!");
      // Send current location immediately
      final position = await _getCurrentLocation();
      if (position != null) {
        socket!.emit('user:location_update', {
          'userId': driverId,
          'lat': position.latitude,
          'lon': position.longitude,
        });
        print('📤 Location sent → lat: ${position.latitude}, lon: ${position.longitude}');
      }
      // Periodic updates
      _locationTimer?.cancel();
      _locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
        if (socket!.connected && driverId != null) {
          final pos = await _getCurrentLocation();
          if (pos != null) {
            socket!.emit('user:location_update', {
              'userId': driverId,
              'lat': pos.latitude,
              'lon': pos.longitude,
            });
            print('📤 Periodic location → lat: ${pos.latitude}, lon: ${pos.longitude}');
          }
        } else {
          print('⚠️ Socket not connected, cancelling timer');
          timer.cancel();
        }
      });
      // Listen for backend events

      socket!.on('delivery:new_request', _handleNewRequest);
      socket!.on('delivery:you_assigned', _handleAssigned);
      socket!.on('booking:request', _acceptRequest);
      socket!.onAny((event, data) {print('📩 Event received → $event : $data');});

    });

    socket!.onDisconnect((_) {
      print('🔌 Socket disconnected');
      if (mounted) {
        setState(() => isSocketConnected = false);
      }
      _locationTimer?.cancel();
      Fluttertoast.showToast(msg: "Socket Disconnected!");
    });

    socket!.onConnectError((error) {
      print('❌ Socket connection error: $error');
      if (mounted) {
        setState(() => isSocketConnected = false);
      }
      _locationTimer?.cancel();
      Fluttertoast.showToast(msg: "Socket Connection Error: $error");
    });

    socket!.onError((error) {
      print('⚠️ Socket error: $error');
    });
  }
  /// Get Current Location
  Future<Position?> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Fluttertoast.showToast(msg: "Please enable location services");
        return null;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(msg: "Location permission denied");
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: "Location permission permanently denied");
        return null;
      }
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      log("Error getting location: $e");
      return null;
    }
  }

  void _handleNewRequest(dynamic payload) {
    print("🚚 New Delivery Request: $payload");
    final requestData = Map<String, dynamic>.from(payload as Map);

    final dropoff = requestData['dropoff'] as Map<String, dynamic>? ?? {};
    final pickup = requestData['pickup'] as Map<String, dynamic>? ?? {}; // Optional: for future use

    final expiresAt = requestData['expiresAt'] as int? ?? 0;
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final countdownMs = expiresAt - nowMs;
    final countdown = (countdownMs > 0 ? (countdownMs / 1000).round() : 0);

    if (countdown <= 0) {
      print("⚠️ Request expired before showing popup.");
      return;
    }

    final requestWithTimer = DeliveryRequest(
      deliveryId: requestData['deliveryId'] as String? ?? '',
      category: 'Delivery', // Customize if needed, e.g., pickup['name'] ?? 'Unknown Category'
      recipient: dropoff['name'] ?? 'Unknown Recipient',
      dropOffLocation: dropoff['name'] ?? 'Unknown Location',
      countdown: countdown,
    );

    _showRequestPopup(requestWithTimer);
  }

  Future<void> _handleAssigned(dynamic payload) async {
    print("✅ Delivery Assigned: ${payload['deliveryId']}");
    final deliveryId = payload['deliveryId'] as String;
    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.getDeliveryById(deliveryId);
      if (response.error == false && response.data != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestDetailsPage(
              deliveryData: response.data!,
              txtID: response.data!.txId.toString(),
            ),
          ),
        ).then((_) {
          print('🔙 Back from details | Refreshing profile');
          getDriverProfile(); // Existing refresh
        });
      } else {
        Fluttertoast.showToast(
          msg: response.message ?? "Failed to fetch delivery details",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching delivery details");
    }
  }

  Future<void> _acceptRequest(dynamic payload) async {
    print("✅ Delivery Assigned: ${payload['deliveryId']}");
    final deliveryId = payload['deliveryId'] as String;

  }


  void _acceptDelivery(String deliveryId) {
    if (socket != null && socket!.connected) {
      socket!.emitWithAck(
        'delivery:accept',
        {'deliveryId': deliveryId},
        ack: (ackData) {
          print('Accept ack: $ackData');
        },
      );
      Fluttertoast.showToast(msg: "Delivery Accepted!");
    } else {
      Fluttertoast.showToast(msg: "Socket not connected!");
    }
  }

  void _skipDelivery(String deliveryId) {
    if (socket != null && socket!.connected) {
      socket!.emitWithAck(
        'delivery:skip',
        {'deliveryId': deliveryId},
        ack: (ackData) {
          print('Skip ack: $ackData');
        },
      );
      Fluttertoast.showToast(msg: "Delivery Rejected!");
    } else {
      Fluttertoast.showToast(msg: "Socket not connected!");
    }
  }

  void _showRequestPopup(DeliveryRequest req) {
    int currentCountdown = req.countdown;  // Local copy
    Timer? countdownTimer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          // if (dialogContext.mounted) {
          //   setDialogState(() {  // Fixed: Use setDialogState to update dialog UI
          //     currentCountdown--;
          //   });
          //   if (currentCountdown <= 0) {
          //     timer.cancel();
          //     // Optional auto-reject
          //     // _skipDelivery(req.deliveryId);
          //     // if (dialogContext.mounted) Navigator.of(dialogContext).pop();
          //     // Fluttertoast.showToast(msg: "Time expired! Delivery auto-rejected.");
          //   }
          // }
        });

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(req.category),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(req.category),
                  SizedBox(height: 8.h),
                  // Add pickup row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 16.sp, color: Colors.blue),
                      SizedBox(width: 5.w),
                      // Expanded(child: Text("Pickup: ${req.pickupName ?? 'Unknown Pickup'}")),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text("Recipient: ${req.recipient}"),
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 16.sp, color: Colors.green),
                      SizedBox(width: 5.w),
                      Expanded(child: Text(req.dropOffLocation)),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Time left: ${currentCountdown}s",
                    style: TextStyle(
                      color: currentCountdown <= 3 ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    countdownTimer?.cancel();
                    Navigator.of(dialogContext).pop();
                    _skipDelivery(req.deliveryId);
                  },
                  child: const Text("Reject"),
                ),
                ElevatedButton(
                  onPressed: () {
                    countdownTimer?.cancel();
                    Navigator.of(dialogContext).pop();
                    _acceptDelivery(req.deliveryId);
                  },
                  child: const Text("Accept"),
                ),
              ],
            );
          },
        );
      },
    ).then((_) => countdownTimer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: selectIndex == 0
          ? Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 55.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Back"),
                    Text("$firstName $lastName"),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                ),
                InkWell(
                  onTap: () {
                    selectIndex = 3;  // Fixed: Profile is index 3
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5.w),
                    width: 35.w,
                    height: 35.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFA8DADC),
                    ),
                    child: Center(
                      child: Text(
                        firstName.isNotEmpty
                            ? "${firstName[0]}${lastName[0]}"
                            : "AS",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            if (status == "pending")
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IdentityCardPage(),
                    ),
                  ).then((_) {
                    getDriverProfile();
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10.sp),
                  height: 91.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xffFDF1F1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Identity Verification",
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Add your driving license, or any other means of driving identification used in your country",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 10.h),

            if (status == "pending")
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VihicalPage(),
                    ),
                  ).then((_) {
                    getDriverProfile();
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10.sp),
                  height: 91.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xffFDF1F1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add Vehicle",
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Upload insurance and registration documents of the vehicle you intend to use.",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 20.h),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: const Color(0xFFD1E5E6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Available balance"),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text(isVisible ? "₹ $balance" : "****"),
                      IconButton(
                        onPressed: () => setState(() => isVisible = !isVisible),
                        icon: Icon(
                          isVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delivery_dining,
                      size: 64.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16.h),
                    Text("Waiting for new delivery requests..."),
                    SizedBox(height: 8.h),
                    Text(  // Uncommented for debugging
                      "Socket: ${isSocketConnected ? 'Connected' : 'Disconnected'}",
                      style: TextStyle(
                        color: isSocketConnected ? Colors.green : Colors.red,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
          : selectIndex == 1
          ? EarningPage()
          : selectIndex == 2
          ? BookingPage()
          : ProfilePage(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        color: const Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 30,
            spreadRadius: 0,
            color: const Color.fromARGB(17, 0, 0, 0),
          ),
        ],
      ),
      child: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selectIndex = value;
          });
          if (value == 0) {
            print('🏠 Nav to Home - ensuring fresh socket...');
            _ensureSocketConnected();  // Force fresh socket on home enter
          }
        },
        backgroundColor: const Color(0xFFFFFFFF),
        currentIndex: selectIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF006970),
        unselectedItemColor: const Color(0xFFC0C5C2),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFFC0C5C2),
        ),
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF006970),
        ),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/SvgImage/iconhome.svg",
              color: const Color(0xFFC0C5C2),
            ),
            activeIcon: SvgPicture.asset(
              "assets/SvgImage/iconhome.svg",
              color: const Color(0xFF006970),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/SvgImage/iconearning.svg",
              color: const Color(0xFFC0C5C2),
            ),
            activeIcon: SvgPicture.asset(
              "assets/SvgImage/iconearning.svg",
              color: const Color(0xFF006970),
            ),
            label: "Earning",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/SvgImage/iconbooking.svg",
              color: const Color(0xFFC0C5C2),
            ),
            activeIcon: SvgPicture.asset(
              "assets/SvgImage/iconbooking.svg",
              color: const Color(0xFF006970),
            ),
            label: "Booking",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/SvgImage/iconProfile.svg",
              color: const Color(0xFFC0C5C2),
            ),
            activeIcon: SvgPicture.asset(
              "assets/SvgImage/iconProfile.svg",
              color: const Color(0xFF006970),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class DeliveryRequest {
  final String deliveryId;
  final String category;
  final String recipient;
  final String dropOffLocation;
  final int countdown;

  DeliveryRequest({
    required this.deliveryId,
    required this.category,
    required this.recipient,
    required this.dropOffLocation,
    required this.countdown,
  });
}