/*
import 'dart:developer';
import 'package:delivery_rider_app/RiderScreen/booking.page.dart';
import 'package:delivery_rider_app/RiderScreen/earning.page.dart';
import 'package:delivery_rider_app/RiderScreen/enroutePickup.page.dart';
import 'package:delivery_rider_app/RiderScreen/profile.page.dart';
import 'package:delivery_rider_app/RiderScreen/requestDetails.page.dart';
import 'package:delivery_rider_app/RiderScreen/vihical.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/network/api.state.dart';
import '../config/utils/pretty.dio.dart';
import 'identityCard.page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = true;
  int selectIndex = 0;
  String firstName = '';
  String lastName = '';
  double balance = 0;

  @override
  void initState() {
    super.initState();
    getDriverProfile(); // Fetch profile when screen loads
  }

  /// ✅ Fetch driver profile from API
  Future<void> getDriverProfile() async {
    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.getDriverProfile();

      if (response.error == false && response.data != null) {
        setState(() {
          firstName = response.data!.firstName ?? '';
          lastName = response.data!.lastName ?? '';
          balance = response.data!.wallet!.balance!.toDouble() ?? 0;
        });
      } else {
        Fluttertoast.showToast(
            msg: response.message ?? "Failed to fetch profile");
      }
    } catch (e, st) {
      log("Get Driver Profile Error: $e\n$st");
      Fluttertoast.showToast(
          msg: "Something went wrong while fetching profile");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: selectIndex == 0
          ?

      Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 55.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Row
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
                          color: const Color(0xFF111111)),
                    ),
                    Text(
                      "$firstName $lastName",
                      style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF111111)),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications, size: 25.sp),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  width: 35.w,
                  height: 35.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFA8DADC),
                  ),
                  child: Center(
                    child: Text(
                      firstName.isNotEmpty ? firstName[0].toUpperCase() + lastName[0].toUpperCase() : "AS",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Wallet balance
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: const Color(0xFFD1E5E6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available balance",
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text(
                        isVisible ? "₹ $balance" : "****",
                        style: GoogleFonts.inter(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF111111),
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
                          color: const Color.fromARGB(178, 17, 17, 17),
                          size: 25.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            SizedBox(height: 10.h,),


            GestureDetector(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>IdentityCardPage())).then((_) {
                  getDriverProfile();
                });
              },
              child: Container(
                padding: EdgeInsets.all(10.sp),

                height: 91.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffFDF1F1)
                ),
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

                              SizedBox(height: 5.h,),
                              Text(
                                "Add your driving license, or any other means of  driving identification used in your country",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF111111),
                                ),
                              ),
                            ],),
                        ),


                        SvgPicture.asset(
                          "assets/SvgImage/Group.svg",
                          // color: Color(0xFFC0C5C2),
                        ),


                      ],)


                  ],),

              ),
            ),



            SizedBox(height: 10.h,),


            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VihicalPage())).then((_) {
                  getDriverProfile();
                });
              },
              child: Container(
                padding: EdgeInsets.all(10.sp),

                height: 91.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffFDF1F1)
                ),
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

                              SizedBox(height: 5.h,),
                              Text(
                                "Upload insurance and registration documents of the vehicle you intend to use.",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF111111),
                                ),
                              ),
                            ],),
                        ),


                        SvgPicture.asset(
                          "assets/SvgImage/Group.svg",
                          // color: Color(0xFFC0C5C2),
                        ),


                      ],)


                  ],),

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
                                builder: (context) =>
                                    RequestDetailsPage(),
                              ),
                            );
                          },
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35.w,
                                      height: 35.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(5.r),
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
                                                fontWeight:
                                                FontWeight.w400,
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
                                  borderRadius: BorderRadius.circular(
                                    8.r,
                                  ),
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
                                  borderRadius: BorderRadius.circular(
                                    8.r,
                                  ),
                                  side: BorderSide.none,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        EnroutePickupPage(),
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
            getDriverProfile();
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


}*/

//
// import 'dart:developer';
// import 'dart:async';
// import 'dart:convert';
// import 'package:delivery_rider_app/RiderScreen/booking.page.dart';
// import 'package:delivery_rider_app/RiderScreen/earning.page.dart';
// import 'package:delivery_rider_app/RiderScreen/enroutePickup.page.dart';
// import 'package:delivery_rider_app/RiderScreen/profile.page.dart';
// import 'package:delivery_rider_app/RiderScreen/requestDetails.page.dart';
// import 'package:delivery_rider_app/RiderScreen/vihical.page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:http/http.dart' as http;
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
//   List<DeliveryRequest> requests = [];
//   Map<String, dynamic> data = {};
//   bool isStatus = false;
//   late IO.Socket socket;
//   Timer? countdownTimer;
//   bool isSocketConnected = false; // Added to track socket connection status
//
//   @override
//   void initState() {
//     super.initState();
//     getDriverProfile(); // Fetch profile when screen loads
//   }
//
//   @override
//   void dispose() {
//     countdownTimer?.cancel();
//     socket.dispose();
//     super.dispose();
//   }
//
//   /// ✅ Fetch driver profile from API
//   Future<void> getDriverProfile() async {
//     try {
//       final dio = await callDio();
//       final service = APIStateNetwork(dio);
//       final response = await service.getDriverProfile();
//
//       if (response.error == false && response.data != null) {
//         setState(() {
//           firstName = response.data!.firstName ?? '';
//           status = response.data!.status ?? '';
//           lastName = response.data!.lastName ?? '';
//           balance = response.data!.wallet!.balance!.toDouble() ?? 0;
//           driverId = response.data!.id ?? ''; // Assuming the model has 'id' field for driver ID
//         });
//         if (driverId != null && driverId!.isNotEmpty) {
//           _connectSocket();
//         }
//       } else {
//         Fluttertoast.showToast(
//             msg: response.message ?? "Failed to fetch profile");
//       }
//     } catch (e, st) {
//       log("Get Driver Profile Error: $e\n$st");
//       Fluttertoast.showToast(
//           msg: "Something went wrong while fetching profile");
//     }
//   }
// /*
//   void _connectSocket() {
//     // TODO: Replace with your actual socket server URL (e.g., 'http://localhost:3000' for development, or production URL)
//     // The current URL 'https://weloads.com' returns 404 because the server is not configured for Socket.IO.
//     // Ensure your Node.js backend is running and serving Socket.IO at this endpoint.
//     // If using auth, add 'auth': {'token': token} to the options.
//     // Optionally append driverId: 'https://your-server.com?driverId=$driverId'
//     const socketUrl = 'http://192.168.1.43:4567'; // Change to your backend URL
//     socket = IO.io(socketUrl, <String, dynamic>{
//       'transports': ['websocket',], // Add polling as fallback
//       'autoConnect': false,
//     });
//     socket.connect();
//     socket.onConnect((_) {
//       print('Socket fully connected: ${socket.id}');
//       setState(() {
//         isSocketConnected = true;
//       });
//       socket.emit('register', {
//         'userId': driverId, // actual logged in driver ID from backend
//         'role': 'driver',
//           });
//       Fluttertoast.showToast(msg: "Socket Connected Successfully!");
//       socket.on('delivery:new_request', _handleNewRequest);
//       socket.on('delivery:assigned', _handleAssigned);
//     });
//     socket.onDisconnect((_) {
//       print('Socket disconnected');
//       setState(() {
//         isSocketConnected = false;
//       });
//       Fluttertoast.showToast(msg: "Socket Disconnected!");
//     });
//     // Also listen for connect_error for better debugging
//     socket.onConnectError((error) {
//       print('Socket connection error: $error');
//       setState(() {
//         isSocketConnected = false;
//       });
//       Fluttertoast.showToast(msg: "Socket Connection Error: $error");
//     });
//   }*/
//
//
//   void _connectSocket() {
//     const socketUrl = 'http://192.168.1.43:4567'; // ✅ Your backend URL
//
//     socket = IO.io(socketUrl, <String, dynamic>{
//       'transports': ['websocket', 'polling'], // ✅ Include polling as fallback
//       'autoConnect': false,
//     });
//
//     socket.connect();
//
//     socket.onConnect((_) {
//       print('✅ Socket fully connected: ${socket.id}');
//       setState(() => isSocketConnected = true);
//
//       // ✅ Ensure driverId is not null or empty before emitting
//       if (driverId != null && driverId!.isNotEmpty) {
//         socket.emit('register', {
//           'userId': driverId,
//           'role': 'driver',
//         });
//         print('📡 Register event emitted with driverId: $driverId');
//       } else {
//         print('⚠️ driverId is null or empty, register not emitted');
//       }
//
//       Fluttertoast.showToast(msg: "Socket Connected Successfully!");
//
//       // ✅ Listen to backend events
//       socket.on('delivery:new_request', _handleNewRequest);
//       socket.on('delivery:assigned', _handleAssigned);
//
//       // ✅ Optional: Listen to all events for debugging
//       socket.onAny((event, data) {
//         print('📩 Event received → $event : $data');
//       });
//
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
//       print('⚠️ General socket error: $error');
//     });
//   }
//
//   void _handleNewRequest(dynamic payload) {
//     print("🚚 New Delivery Request: $payload");
//     final requestData = Map<String, dynamic>.from(payload as Map);
//     final requestWithTimer = DeliveryRequest(
//       deliveryId: requestData['deliveryId'] as String,
//       category: requestData['category'] ?? 'Unknown Category', // Assuming fields; adjust as per payload
//       recipient: requestData['recipient'] ?? 'Unknown Recipient',
//       dropOffLocation: requestData['dropOffLocation'] ?? 'Unknown Location',
//       countdown:1000,
//     );
//     setState(() {
//       if (!requests.any((r) => r.deliveryId == requestData['deliveryId'])) {
//         requests.add(requestWithTimer);
//         _startCountdown();
//       }
//     });
//   }
//
//   Future<void> _handleAssigned(dynamic payload) async {
//     print("✅ Delivery Assigned: ${payload['deliveryId']}");
//     final token = await _getToken(); // Implement token retrieval
//     final deliveryId = payload['deliveryId'] as String;
//
//     try {
//       // TODO: Replace with your actual API URL
//       final response = await http.get(
//         Uri.parse('http://localhost:3000/driver/getDeliveryById?deliveryId=$deliveryId'), // Changed to match socket URL for dev
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final resData = json.decode(response.body);
//         setState(() {
//           requests.removeWhere((r) => r.deliveryId == deliveryId);
//           isStatus = true;
//           data = Map<String, dynamic>.from(resData['data'] as Map);
//         });
//         // Optionally navigate to EnroutePickupPage or show details
//         Navigator.push(
//           context,
//           CupertinoPageRoute(builder: (context) => EnroutePickupPage()),
//         );
//       } else {
//         print('Error fetching delivery: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error in handleAssigned: $e');
//     }
//   }
//
//   Future<String> _getToken() async {
//     // TODO: Implement token retrieval, e.g., from shared_preferences or flutter_secure_storage
//     // For example:
//     // final prefs = await SharedPreferences.getInstance();
//     // return prefs.getString('token') ?? '';
//     return 'your_token_here';
//   }
//
//   void _startCountdown() {
//     if (countdownTimer != null) return;
//     countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         for (int i = 0; i < requests.length; i++) {
//           requests[i] = requests[i].copyWith(countdown: requests[i].countdown - 1);
//         }
//         requests.removeWhere((r) => r.countdown <= 0);
//         if (requests.isEmpty) {
//           timer.cancel();
//           countdownTimer = null;
//         }
//       });
//       // Auto-skip logic moved here
//       for (final request in requests) {
//         if (request.countdown <= 0) {
//           _skipDelivery(request.deliveryId);
//           break;
//         }
//       }
//     });
//   }
//
//   void _acceptDelivery(String deliveryId) {
//     if (socket.connected) {
//       socket.emitWithAck('delivery:accept', {'deliveryId': deliveryId}, ack: (ackData) {
//         print('Accept ack: $ackData');
//       });
//       setState(() {
//         requests.removeWhere((r) => r.deliveryId == deliveryId);
//       });
//       // Optionally navigate immediately or wait for assigned event
//     } else {
//       print('Socket not connected');
//       Fluttertoast.showToast(msg: "Socket is not connected!");
//     }
//   }
//
//   void _skipDelivery(String deliveryId) {
//     if (socket.connected) {
//       socket.emitWithAck('delivery:skip', {'deliveryId': deliveryId}, ack: (ackData) {
//         print('Skip ack: $ackData');
//       });
//       setState(() {
//         requests.removeWhere((r) => r.deliveryId == deliveryId);
//       });
//     } else {
//       print('Socket not connected');
//       Fluttertoast.showToast(msg: "Socket is not connected!");
//     }
//   }
//
//   // Added method to manually check and log/print status
//   void checkSocketStatus() {
//     print('Socket Connected: ${socket.connected}');
//     print('Socket ID: ${socket.id}');
//     Fluttertoast.showToast(msg: "Socket Status: ${socket.connected ? 'Connected' : 'Disconnected'}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('requests: $requests');
//     print('Socket Connected: ${socket.connected}'); // Added for logging
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFFFFF),
//       body: selectIndex == 0
//           ? Padding(
//         padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 55.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Connection Status Indicator (Added)
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(8.sp),
//               decoration: BoxDecoration(
//                 color: isSocketConnected ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(4.r),
//                 border: Border.all(
//                   color: isSocketConnected ? Colors.green : Colors.red,
//                   width: 1,
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Socket Status: ${isSocketConnected ? 'Connected' : 'Disconnected'}",
//                     style: GoogleFonts.inter(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w500,
//                       color: isSocketConnected ? Colors.green : Colors.red,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: checkSocketStatus, // Button to manually check status
//                     icon: Icon(
//                       Icons.refresh,
//                       size: 16.sp,
//                       color: isSocketConnected ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8.h),
//             // Welcome Row
//             Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Welcome Back",
//                       style: GoogleFonts.inter(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400,
//                           color: const Color(0xFF111111)),
//                     ),
//                     Text(
//                       "$firstName $lastName",
//                       style: GoogleFonts.inter(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w400,
//                           color: const Color(0xFF111111)),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(Icons.notifications, size: 25.sp),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 5.w),
//                   width: 35.w,
//                   height: 35.h,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFFA8DADC),
//                   ),
//                   child: Center(
//                     child: Text(
//                       firstName.isNotEmpty
//                           ? firstName[0].toUpperCase() + lastName[0].toUpperCase()
//                           : "AS",
//                       style: GoogleFonts.inter(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                         color: const Color(0xFF4F4F4F),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.h),
//             // Wallet balance
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(4.r),
//                 color: const Color(0xFFD1E5E6),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Available balance",
//                     style: GoogleFonts.inter(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w400,
//                       color: const Color(0xFF111111),
//                     ),
//                   ),
//                   SizedBox(height: 3.h),
//                   Row(
//                     children: [
//                       Text(
//                         isVisible ? "₹ $balance" : "****",
//                         style: GoogleFonts.inter(
//                           fontSize: 32.sp,
//                           fontWeight: FontWeight.w500,
//                           color: const Color(0xFF111111),
//                         ),
//                       ),
//                       SizedBox(width: 10.w),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isVisible = !isVisible;
//                           });
//                         },
//                         icon: Icon(
//                           isVisible ? Icons.visibility : Icons.visibility_off,
//                           color: const Color.fromARGB(178, 17, 17, 17),
//                           size: 25.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10.h),
//             status != "pending"
//                 ? GestureDetector(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => IdentityCardPage()))
//                     .then((_) {
//                   getDriverProfile();
//                 });
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10.sp),
//                 height: 91.h,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Color(0xffFDF1F1),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Identity Verification",
//                                 style: GoogleFonts.inter(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF111111),
//                                 ),
//                               ),
//                               SizedBox(height: 5.h),
//                               Text(
//                                 "Add your driving license, or any other means of  driving identification used in your country",
//                                 style: GoogleFonts.inter(
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xFF111111),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SvgPicture.asset(
//                           "assets/SvgImage/Group.svg",
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//                 : SizedBox(),
//             SizedBox(height: 10.h),
//             status != "pending"
//                 ? GestureDetector(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => VihicalPage()))
//                     .then((_) {
//                   getDriverProfile();
//                 });
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10.sp),
//                 height: 91.h,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Color(0xffFDF1F1),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Add Vehicle",
//                                 style: GoogleFonts.inter(
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF111111),
//                                 ),
//                               ),
//                               SizedBox(height: 5.h),
//                               Text(
//                                 "Upload insurance and registration documents of the vehicle you intend to use.",
//                                 style: GoogleFonts.inter(
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xFF111111),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SvgPicture.asset(
//                           "assets/SvgImage/Group.svg",
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//                 : SizedBox(),
//             SizedBox(height: 15.h),
//             Divider(color: Color(0xFFE5E5E5)),
//             SizedBox(height: 15.h),
//             Text(
//               "Would you like to specify direction for deliveries?",
//               style: GoogleFonts.inter(
//                 fontSize: 13.sp,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xFF111111),
//               ),
//             ),
//             SizedBox(height: 4.h),
//             TextField(
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(
//                   left: 15.w,
//                   right: 15.w,
//                   top: 10.h,
//                   bottom: 10.h,
//                 ),
//                 filled: true,
//                 fillColor: Color(0xFFF0F5F5),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.r),
//                   borderSide: BorderSide.none,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.r),
//                   borderSide: BorderSide.none,
//                 ),
//                 hint: Text(
//                   "Where to?",
//                   style: GoogleFonts.inter(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xFFAFAFAF),
//                   ),
//                 ),
//                 prefixIcon: Icon(
//                   Icons.circle_outlined,
//                   color: Color(0xFF28B877),
//                   size: 18.sp,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.h),
//             Row(
//               children: [
//                 Text(
//                   "Available Requests",
//                   style: GoogleFonts.inter(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xFF111111),
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   "View all",
//                   style: GoogleFonts.inter(
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xFF006970),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20.h),
//             Expanded(
//               child: requests.isEmpty
//                   ? Center(
//                 child: Text(
//                   "No requests available",
//                   style: GoogleFonts.inter(
//                     fontSize: 16.sp,
//                     color: Color(0xFF545454),
//                   ),
//                 ),
//               )
//                   : ListView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: requests.length,
//                 itemBuilder: (context, index) {
//                   final req = requests[index];
//                   return Padding(
//                     padding: EdgeInsets.only(bottom: 16.h),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               CupertinoPageRoute(
//                                 builder: (context) => RequestDetailsPage(),
//                               ),
//                             );
//                           },
//                           child: SizedBox(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   req.category,
//                                   style: GoogleFonts.inter(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xFF0C341F),
//                                   ),
//                                 ),
//                                 Text(
//                                   "Recipient: ${req.recipient}",
//                                   style: GoogleFonts.inter(
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xFF545454),
//                                   ),
//                                 ),
//                                 SizedBox(height: 12.h),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: 35.w,
//                                       height: 35.h,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5.r),
//                                         color: Color(0xFFF7F7F7),
//                                       ),
//                                       child: Center(
//                                         child: SvgPicture.asset(
//                                           "assets/SvgImage/bikess.svg",
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(width: 10.w),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.location_on,
//                                               size: 16.sp,
//                                               color: Color(0xFF27794D),
//                                             ),
//                                             SizedBox(width: 5.w),
//                                             Text(
//                                               "Drop off",
//                                               style: GoogleFonts.inter(
//                                                 fontSize: 12.sp,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Color(0xFF545454),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                             left: 3.w,
//                                             top: 2.h,
//                                           ),
//                                           child: Text(
//                                             req.dropOffLocation,
//                                             style: GoogleFonts.inter(
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w400,
//                                               color: Color(0xFF0C341F),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 8.h),
//                                 // Countdown display
//                                 Text(
//                                   "Time left: ${req.countdown}s",
//                                   style: GoogleFonts.inter(
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.w500,
//                                     color: req.countdown <= 3 ? Colors.red : Color(0xFF006970),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 12.h),
//                         Row(
//                           children: [
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 minimumSize: Size(136.w, 44.h),
//                                 backgroundColor: Color(0xFFF3F7F5),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.r),
//                                   side: BorderSide.none,
//                                 ),
//                               ),
//                               onPressed: () => _skipDelivery(req.deliveryId),
//                               child: Text(
//                                 "Reject",
//                                 style: GoogleFonts.inter(
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xFF006970),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 16.w),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 minimumSize: Size(136.w, 44.h),
//                                 backgroundColor: Color(0xFF006970),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.r),
//                                   side: BorderSide.none,
//                                 ),
//                               ),
//                               onPressed: () => _acceptDelivery(req.deliveryId),
//                               child: Text(
//                                 "Accept",
//                                 style: GoogleFonts.inter(
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 15.h),
//                         Divider(color: Color(0xFFDCE8E9), thickness: 1.w),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             if (isStatus)
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Text('Assigned Delivery: ${data.toString()}'),
//                 ),
//               ),
//           ],
//         ),
//       )
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
// // Model for Delivery Request
// class DeliveryRequest {
//   final String deliveryId;
//   final String category;
//   final String recipient;
//   final String dropOffLocation;
//   int countdown;
//
//   DeliveryRequest({
//     required this.deliveryId,
//     required this.category,
//     required this.recipient,
//     required this.dropOffLocation,
//     required this.countdown,
//   });
//
//   DeliveryRequest copyWith({
//     String? deliveryId,
//     String? category,
//     String? recipient,
//     String? dropOffLocation,
//     int? countdown,
//   }) {
//     return DeliveryRequest(
//       deliveryId: deliveryId ?? this.deliveryId,
//       category: category ?? this.category,
//       recipient: recipient ?? this.recipient,
//       dropOffLocation: dropOffLocation ?? this.dropOffLocation,
//       countdown: countdown ?? this.countdown,
//     );
//   }
// }
/*

import 'dart:developer';
import 'dart:async';
import 'dart:convert';
import 'package:delivery_rider_app/RiderScreen/booking.page.dart';
import 'package:delivery_rider_app/RiderScreen/earning.page.dart';
import 'package:delivery_rider_app/RiderScreen/enroutePickup.page.dart';
import 'package:delivery_rider_app/RiderScreen/profile.page.dart';
import 'package:delivery_rider_app/RiderScreen/requestDetails.page.dart';
import 'package:delivery_rider_app/RiderScreen/vihical.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import '../config/network/api.state.dart';
import '../config/utils/pretty.dio.dart';
import 'identityCard.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = true;
  int selectIndex = 0;
  String firstName = '';
  String lastName = '';
  String status = '';
  double balance = 0;
  String? driverId;
  Map<String, dynamic> data = {};
  bool isStatus = false;
  late IO.Socket socket;
  bool isSocketConnected = false; // Added to track socket connection status

  @override
  void initState() {
    super.initState();
    getDriverProfile(); // Fetch profile when screen loads
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  /// ✅ Fetch driver profile from API
  Future<void> getDriverProfile() async {
    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.getDriverProfile();

      if (response.error == false && response.data != null) {
        setState(() {
          firstName = response.data!.firstName ?? '';
          status = response.data!.status ?? '';
          lastName = response.data!.lastName ?? '';
          balance = response.data!.wallet!.balance!.toDouble() ?? 0;
          driverId = response.data!.id ?? ''; // Assuming the model has 'id' field for driver ID
        });
        if (driverId != null && driverId!.isNotEmpty) {
          _connectSocket();
        }
      } else {
        Fluttertoast.showToast(
            msg: response.message ?? "Failed to fetch profile");
      }
    } catch (e, st) {
      log("Get Driver Profile Error: $e\n$st");
      Fluttertoast.showToast(
          msg: "Something went wrong while fetching profile");
    }
  }

  void _connectSocket() {
    const socketUrl = 'http://192.168.1.43:4567'; // ✅ Your backend URL

    socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket', 'polling'], // ✅ Include polling as fallback
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('✅ Socket fully connected: ${socket.id}');
      setState(() => isSocketConnected = true);

      // ✅ Ensure driverId is not null or empty before emitting
      if (driverId != null && driverId!.isNotEmpty) {
        socket.emit('register', {
          'userId': driverId,
          'role': 'driver',
        });
        print('📡 Register event emitted with driverId: $driverId');
      } else {
        print('⚠️ driverId is null or empty, register not emitted');
      }

      Fluttertoast.showToast(msg: "Socket Connected Successfully!");

      // ✅ Listen to backend events
      socket.on('delivery:new_request', _handleNewRequest);
      socket.on('delivery:assigned', _handleAssigned);

      // ✅ Optional: Listen to all events for debugging
      socket.onAny((event, data) {
        print('📩 Event received → $event : $data');
      });

    });

    socket.onDisconnect((_) {
      print('🔌 Socket disconnected');
      setState(() => isSocketConnected = false);
      Fluttertoast.showToast(msg: "Socket Disconnected!");
    });

    socket.onConnectError((error) {
      print('❌ Socket connection error: $error');
      setState(() => isSocketConnected = false);
      Fluttertoast.showToast(msg: "Socket Connection Error: $error");
    });

    socket.onError((error) {
      print('⚠️ General socket error: $error');
    });
  }

  void _handleNewRequest(dynamic payload) {
    print("🚚 New Delivery Request: $payload");
    final requestData = Map<String, dynamic>.from(payload as Map);
    final requestWithTimer = DeliveryRequest(
      deliveryId: requestData['deliveryId'] as String,
      category: requestData['category'] ?? 'Unknown Category', // Assuming fields; adjust as per payload
      recipient: requestData['recipient'] ?? 'Unknown Recipient',
      dropOffLocation: requestData['dropOffLocation'] ?? 'Unknown Location',
      countdown: 1000,
    );
    // ✅ Automatically open popup instead of adding to list
    _showRequestPopup(requestWithTimer);
  }

  Future<void> _handleAssigned(dynamic payload) async {
    print("✅ Delivery Assigned: ${payload['deliveryId']}");
    final token = await _getToken(); // Implement token retrieval
    final deliveryId = payload['deliveryId'] as String;

    try {
      // TODO: Replace with your actual API URL
      final response = await http.get(
        Uri.parse('http://localhost:3000/driver/getDeliveryById?deliveryId=$deliveryId'), // Changed to match socket URL for dev
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final resData = json.decode(response.body);
        setState(() {
          isStatus = true;
          data = Map<String, dynamic>.from(resData['data'] as Map);
        });
        // Optionally navigate to EnroutePickupPage or show details
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => EnroutePickupPage()),
        );
      } else {
        print('Error fetching delivery: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in handleAssigned: $e');
    }
  }

  Future<String> _getToken() async {
    // TODO: Implement token retrieval, e.g., from shared_preferences or flutter_secure_storage
    // For example:
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getString('token') ?? '';
    return 'your_token_here';
  }

  void _acceptDelivery(String deliveryId) {
    if (socket.connected) {
      socket.emitWithAck('delivery:accept', { deliveryId}, ack: (ackData) {
        print('Accept ack: $ackData');
      });
      Fluttertoast.showToast(msg: "Delivery Accepted!");
    } else {
      print('Socket not connected');
      Fluttertoast.showToast(msg: "Socket is not connected!");
    }
  }

  void _skipDelivery(String deliveryId) {
    if (socket.connected) {
      socket.emitWithAck('delivery:skip', {'deliveryId': deliveryId}, ack: (ackData) {
        print('Skip ack: $ackData');
      });
      Fluttertoast.showToast(msg: "Delivery Rejected!");
    } else {
      print('Socket not connected');
      Fluttertoast.showToast(msg: "Socket is not connected!");
    }
  }

  // ✅ New method to show request popup with all data and countdown
  void _showRequestPopup(DeliveryRequest req) {
    Timer? countdownTimer;
    int currentCountdown = req.countdown;

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext dialogContext) {
        countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted && dialogContext.mounted) {
            setState(() {
              currentCountdown--;
            });
            if (currentCountdown <= 0) {
              timer.cancel();
              _skipDelivery(req.deliveryId);
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
              Fluttertoast.showToast(msg: "Time expired! Delivery auto-rejected.");
            }
          }
        });

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(
                req.category,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Recipient: ${req.recipient}",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF545454),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: const Color(0xFFF7F7F7),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/SvgImage/bikess.svg",
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16.sp,
                                    color: const Color(0xFF27794D),
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "Drop off",
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF545454),
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
                                  req.dropOffLocation,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF0C341F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Countdown display
                    Text(
                      "Time left: ${currentCountdown}s",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: currentCountdown <= 3 ? Colors.red : const Color(0xFF006970),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120.w, 44.h),
                    backgroundColor: const Color(0xFFF3F7F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: const BorderSide(color: Color(0xFF006970)),
                    ),
                  ),
                  onPressed: () {
                    countdownTimer?.cancel();
                    Navigator.of(dialogContext).pop();
                    _skipDelivery(req.deliveryId);
                  },
                  child: Text(
                    "Reject",
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF006970),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120.w, 44.h),
                    backgroundColor: const Color(0xFF006970),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {
                    countdownTimer?.cancel();
                    Navigator.of(dialogContext).pop();
                    _acceptDelivery(req.deliveryId);
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
            );
          },
        );
      },
    ).then((_) {
      countdownTimer?.cancel();
    });
  }

  // Added method to manually check and log/print status
  void checkSocketStatus() {
    print('Socket Connected: ${socket.connected}');
    print('Socket ID: ${socket.id}');
    Fluttertoast.showToast(msg: "Socket Status: ${socket.connected ? 'Connected' : 'Disconnected'}");
  }

  @override
  Widget build(BuildContext context) {
    print('Socket Connected: ${socket.connected}'); // Added for logging

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: selectIndex == 0
          ? Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 55.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection Status Indicator (Added)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                color: isSocketConnected ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: isSocketConnected ? Colors.green : Colors.red,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Socket Status: ${isSocketConnected ? 'Connected' : 'Disconnected'}",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isSocketConnected ? Colors.green : Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: checkSocketStatus, // Button to manually check status
                    icon: Icon(
                      Icons.refresh,
                      size: 16.sp,
                      color: isSocketConnected ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            // Welcome Row
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
                          color: const Color(0xFF111111)),
                    ),
                    Text(
                      "$firstName $lastName",
                      style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF111111)),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications, size: 25.sp),
                ),
                Container(
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
                          ? firstName[0].toUpperCase() + lastName[0].toUpperCase()
                          : "AS",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Wallet balance
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: const Color(0xFFD1E5E6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available balance",
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text(
                        isVisible ? "₹ $balance" : "****",
                        style: GoogleFonts.inter(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF111111),
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
                          color: const Color.fromARGB(178, 17, 17, 17),
                          size: 25.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            status != "pending"
                ? GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => IdentityCardPage()))
                    .then((_) {
                  getDriverProfile();
                });
              },
              child: Container(
                padding: EdgeInsets.all(10.sp),
                height: 91.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffFDF1F1),
                ),
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
                                  color: const Color(0xFF111111),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "Add your driving license, or any other means of  driving identification used in your country",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF111111),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/SvgImage/Group.svg",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
                : const SizedBox(),
            SizedBox(height: 10.h),
            status != "pending"
                ? GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VihicalPage()))
                    .then((_) {
                  getDriverProfile();
                });
              },
              child: Container(
                padding: EdgeInsets.all(10.sp),
                height: 91.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffFDF1F1),
                ),
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
                                  color: const Color(0xFF111111),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "Upload insurance and registration documents of the vehicle you intend to use.",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF111111),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/SvgImage/Group.svg",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
                : const SizedBox(),
            SizedBox(height: 15.h),
            Divider(color: const Color(0xFFE5E5E5)),
            SizedBox(height: 15.h),
            Text(
              "Would you like to specify direction for deliveries?",
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF111111),
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
                fillColor: const Color(0xFFF0F5F5),
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
                    color: const Color(0xFFAFAFAF),
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.circle_outlined,
                  color: Color(0xFF28B877),
                  size: 18,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            // ✅ Waiting message instead of list
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delivery_dining,
                      size: 64.sp,
                      color: const Color(0xFFC0C5C2),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Waiting for new delivery requests...",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF545454),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Socket: ${isSocketConnected ? 'Connected' : 'Disconnected'}",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: isSocketConnected ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isStatus)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Assigned Delivery: ${data.toString()}'),
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
            getDriverProfile();
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

// Model for Delivery Request
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
}*/

/*

import 'dart:developer';
import 'dart:async';
import 'dart:convert';
import 'package:delivery_rider_app/RiderScreen/booking.page.dart';
import 'package:delivery_rider_app/RiderScreen/earning.page.dart';
import 'package:delivery_rider_app/RiderScreen/enroutePickup.page.dart';
import 'package:delivery_rider_app/RiderScreen/profile.page.dart';
import 'package:delivery_rider_app/RiderScreen/requestDetails.page.dart';
import 'package:delivery_rider_app/RiderScreen/vihical.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import '../config/network/api.state.dart';
import '../config/utils/pretty.dio.dart';
import 'identityCard.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = true;
  int selectIndex = 0;
  String firstName = '';
  String lastName = '';
  String status = '';
  double balance = 0;
  String? driverId;
  Map<String, dynamic> data = {};
  bool isStatus = false;
  late IO.Socket socket;
  bool isSocketConnected = false; // Added to track socket connection status

  @override
  void initState() {
    super.initState();
    getDriverProfile(); // Fetch profile when screen loads
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  /// ✅ Fetch driver profile from API
  Future<void> getDriverProfile() async {
    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.getDriverProfile();

      if (response.error == false && response.data != null) {
        setState(() {
          firstName = response.data!.firstName ?? '';
          status = response.data!.status ?? '';
          lastName = response.data!.lastName ?? '';
          balance = response.data!.wallet!.balance!.toDouble() ?? 0;
          driverId = response.data!.id ?? ''; // Assuming the model has 'id' field for driver ID
        });
        if (driverId != null && driverId!.isNotEmpty) {
          _connectSocket();
        }
      } else {
        Fluttertoast.showToast(
            msg: response.message ?? "Failed to fetch profile");
      }
    } catch (e, st) {
      log("Get Driver Profile Error: $e\n$st");
      Fluttertoast.showToast(
          msg: "Something went wrong while fetching profile");
    }
  }

  void _connectSocket() {
    const socketUrl = 'http://192.168.1.43:4567'; // ✅ Your backend URL

    socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket', 'polling'], // ✅ Include polling as fallback
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('✅ Socket fully connected: ${socket.id}');
      setState(() => isSocketConnected = true);

      // ✅ Ensure driverId is not null or empty before emitting
      if (driverId != null && driverId!.isNotEmpty) {
        socket.emit('register', {
          'userId': driverId,
          'role': 'driver',
        });
        print('📡 Register event emitted with driverId: $driverId');
      } else {
        print('⚠️ driverId is null or empty, register not emitted');
      }

      Fluttertoast.showToast(msg: "Socket Connected Successfully!");

      // ✅ Listen to backend events
      socket.on('delivery:new_request', _handleNewRequest);
      socket.on('delivery:you_assigned', _handleAssigned);
      updateUserLocation();
      // ✅ Optional: Listen to all events for debugging
      socket.onAny((event, data) {
        print('📩 Event received → $event : $data');
      });

    });

    socket.onDisconnect((_) {
      print('🔌 Socket disconnected');
      setState(() => isSocketConnected = false);
      Fluttertoast.showToast(msg: "Socket Disconnected!");
    });

    socket.onConnectError((error) {
      print('❌ Socket connection error: $error');
      setState(() => isSocketConnected = false);
      Fluttertoast.showToast(msg: "Socket Connection Error: $error");
    });

    socket.onError((error) {
      print('⚠️ General socket error: $error');
    });
  }


  void _handleNewRequest(dynamic payload) {
    print("🚚 New Delivery Request: $payload");
    final requestData = Map<String, dynamic>.from(payload as Map);
    final requestWithTimer = DeliveryRequest(
      deliveryId: requestData['deliveryId'] as String,
      category: requestData['category'] ?? 'Unknown Category', // Assuming fields; adjust as per payload
      recipient: requestData['recipient'] ?? 'Unknown Recipient',
      dropOffLocation: requestData['dropOffLocation'] ?? 'Unknown Location',
      countdown: 1000,
    );
    // ✅ Automatically open popup instead of adding to list
    _showRequestPopup(requestWithTimer);
  }

  Future<void> _handleAssigned(dynamic payload) async {
    print("✅ Delivery Assigned: ${payload['deliveryId']}");
    var box = Hive.box("userdata");
    var token = box.get("token");
    final deliveryId = payload['deliveryId'] as String;
    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.getDeliveryById(deliveryId);
      if (response.error == false && response.data != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestDetailsPage(deliveryData: response.data!),
          ),
        );
      } else {
        print('Error fetching delivery details: ${response.message}');
        Fluttertoast.showToast(msg: response.message ?? "Failed to fetch delivery details");
      }
    } catch (e) {
      print('Error in handleAssigned: $e');
      Fluttertoast.showToast(msg: "Something went wrong while fetching delivery details");
    }
  }

  void _acceptDelivery(String deliveryId) {
    if (socket.connected) {
      socket.emitWithAck('delivery:accept', {'deliveryId': deliveryId}, ack: (ackData) {
        print('Accept ack: $ackData');
      });
      Fluttertoast.showToast(msg: "Delivery Accepted!");
    } else {
      print('Socket not connected');
      Fluttertoast.showToast(msg: "Socket is not connected!");
    }
  }

  void _skipDelivery(String deliveryId) {
    if (socket.connected) {
      socket.emitWithAck('delivery:skip', {'deliveryId': deliveryId}, ack: (ackData) {
        print('Skip ack: $ackData');
      });
      Fluttertoast.showToast(msg: "Delivery Rejected!");
    } else {
      print('Socket not connected');
      Fluttertoast.showToast(msg: "Socket is not connected!");
    }
  }

  // ✅ New method to show request popup    all data and countdown
  void _showRequestPopup(DeliveryRequest req) {
    Timer? countdownTimer;
    int currentCountdown = req.countdown;
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext dialogContext) {
        countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted && dialogContext.mounted) {
            setState(() {
              currentCountdown--;
            });
            if (currentCountdown <= 0) {
              timer.cancel();
              _skipDelivery(req.deliveryId);
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
              Fluttertoast.showToast(msg: "Time expired! Delivery auto-rejected.");
            }
          }
        });

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(
                req.category,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF111111),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Recipient: ${req.recipient}",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF545454),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: const Color(0xFFF7F7F7),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/SvgImage/bikess.svg",
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16.sp,
                                    color: const Color(0xFF27794D),
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "Drop off",
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF545454),
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
                                  req.dropOffLocation,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF0C341F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Countdown display
                    Text(
                      "Time left: ${currentCountdown}s",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: currentCountdown <= 3 ? Colors.red : const Color(0xFF006970),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120.w, 44.h),
                    backgroundColor: const Color(0xFFF3F7F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: const BorderSide(color: Color(0xFF006970)),
                    ),
                  ),
                  onPressed: () {
                    countdownTimer?.cancel();
                    Navigator.of(dialogContext).pop();
                    _skipDelivery(req.deliveryId);
                  },
                  child: Text(
                    "Reject",
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF006970),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(120.w, 44.h),
                    backgroundColor: const Color(0xFF006970),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {
                    countdownTimer?.cancel();
                    Navigator.of(dialogContext).pop();
                    _acceptDelivery(req.deliveryId);
                    // ✅ Navigate to detail screen with socket data

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
            );
          },
        );
      },
    ).then((_) {
      countdownTimer?.cancel();
    });
  }

  // Added method to manually check and log/print status
  void checkSocketStatus() {
    print('Socket Connected: ${socket.connected}');
    print('Socket ID: ${socket.id}');
    Fluttertoast.showToast(msg: "Socket Status: ${socket.connected ? 'Connected' : 'Disconnected'}");
  }

  void updateUserLocation(double lat, double lon) {
    if (socket.connected && socket.id != null) {
      socket.emit('user:location_update', {
        'userId': id,
        'lat': lat,
        'lon': lon,
      });
      log('📤 Location sent → lat: $lat, lon: $lon');
    } else {
      log('⚠ Socket not connected or no ID!');
    }
  }
  @override
  Widget build(BuildContext context) {
    // print('Socket Connected: ${socket.connected}'); // Added for logging

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: selectIndex == 0
          ? Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 55.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection Status Indicator (Added)
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.all(8.sp),
            //   decoration: BoxDecoration(
            //     color: isSocketConnected ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(4.r),
            //     border: Border.all(
            //       color: isSocketConnected ? Colors.green : Colors.red,
            //       width: 1,
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "Socket Status: ${isSocketConnected ? 'Connected' : 'Disconnected'}",
            //         style: GoogleFonts.inter(
            //           fontSize: 12.sp,
            //           fontWeight: FontWeight.w500,
            //           color: isSocketConnected ? Colors.green : Colors.red,
            //         ),
            //       ),
            //       IconButton(
            //         onPressed: checkSocketStatus, // Button to manually check status
            //         icon: Icon(
            //           Icons.refresh,
            //           size: 16.sp,
            //           color: isSocketConnected ? Colors.green : Colors.red,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 8.h),
            // Welcome Row
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
                          color: const Color(0xFF111111)),
                    ),
                    Text(
                      "$firstName $lastName",
                      style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF111111)),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications, size: 25.sp),
                ),
                Container(
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
                          ? firstName[0].toUpperCase() + lastName[0].toUpperCase()
                          : "AS",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4F4F4F),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Wallet balance
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: const Color(0xFFD1E5E6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available balance",
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF111111),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text(
                        isVisible ? "₹ $balance" : "****",
                        style: GoogleFonts.inter(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF111111),
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
                          color: const Color.fromARGB(178, 17, 17, 17),
                          size: 25.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            status != "pending"
                ? GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => IdentityCardPage()))
                    .then((_) {
                  getDriverProfile();
                });
              },
              child: Container(
                padding: EdgeInsets.all(10.sp),
                height: 91.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffFDF1F1),
                ),
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
                                  color: const Color(0xFF111111),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "Add your driving license, or any other means of  driving identification used in your country",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF111111),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/SvgImage/Group.svg",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
                : const SizedBox(),
            SizedBox(height: 10.h),
            status != "pending"
                ? GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VihicalPage()))
                    .then((_) {
                  getDriverProfile();
                });
              },
              child: Container(
                padding: EdgeInsets.all(10.sp),
                height: 91.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffFDF1F1),
                ),
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
                                  color: const Color(0xFF111111),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "Upload insurance and registration documents of the vehicle you intend to use.",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF111111),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/SvgImage/Group.svg",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
                : const SizedBox(),
            SizedBox(height: 15.h),
            Divider(color: const Color(0xFFE5E5E5)),
            SizedBox(height: 15.h),
            Text(
              "Would you like to specify direction for deliveries?",
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF111111),
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
                fillColor: const Color(0xFFF0F5F5),
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
                    color: const Color(0xFFAFAFAF),
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.circle_outlined,
                  color: Color(0xFF28B877),
                  size: 18,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            // ✅ Waiting message instead of list
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delivery_dining,
                      size: 64.sp,
                      color: const Color(0xFFC0C5C2),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Waiting for new delivery requests...",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF545454),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Socket: ${isSocketConnected ? 'Connected' : 'Disconnected'}",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: isSocketConnected ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isStatus)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Assigned Delivery: ${data.toString()}'),
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
            getDriverProfile();
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

// Model for Delivery Request
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
}*/

import 'dart:developer';
import 'dart:async';
import 'package:delivery_rider_app/RiderScreen/booking.page.dart';
import 'package:delivery_rider_app/RiderScreen/earning.page.dart';
import 'package:delivery_rider_app/RiderScreen/profile.page.dart';
import 'package:delivery_rider_app/RiderScreen/requestDetails.page.dart';
import 'package:delivery_rider_app/RiderScreen/vihical.page.dart';
import 'package:flutter/cupertino.dart';
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
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = true;
  int selectIndex = 0;
  String firstName = '';
  String lastName = '';
  String status = '';
  double balance = 0;
  String? driverId;
  bool isStatus = false;
  late IO.Socket socket;
  bool isSocketConnected = false;
  @override
  void initState() {
    super.initState();
    getDriverProfile(); // Fetch profile when screen loads
  } 

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  /// Fetch driver profile
  Future<void> getDriverProfile() async {
    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.getDriverProfile();

      if (response.error == false && response.data != null) {
        setState(() {
          firstName = response.data!.firstName ?? '';
          lastName = response.data!.lastName ?? '';
          status = response.data!.status ?? '';
          balance = response.data!.wallet?.balance?.toDouble() ?? 0;
          driverId = response.data!.id ?? '';
        });

        if (driverId != null && driverId!.isNotEmpty) {
          _connectSocket();
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

  /// Connect Socket
  void _connectSocket() {
    const socketUrl = 'https://weloads.com'; // Your backend URL
    socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket', 'polling'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) async {
      print('✅ Socket connected: ${socket.id}');
      setState(() => isSocketConnected = true);

      if (driverId != null && driverId!.isNotEmpty) {
        socket.emit('register', {'userId': driverId, 'role': 'driver'});
        print('📡 Register event emitted with driverId: $driverId');
      }

      Fluttertoast.showToast(msg: "Socket Connected Successfully!");

      // Send current location immediately
      final position = await _getCurrentLocation();
      if (position != null) {
        socket.emit('user:location_update', {
          'userId': driverId,
          'lat': position.latitude,
          'lon': position.longitude,
        });
        print(
          '📤 Location sent → lat: ${position.latitude}, lon: ${position.longitude}',
        );
      }

      // Optional: periodic updates every 10 seconds
      Timer.periodic(Duration(seconds: 10), (timer) async {
        if (socket.connected && driverId != null) {
          final pos = await _getCurrentLocation();
          if (pos != null) {
            socket.emit('user:location_update', {
              'userId': driverId,
              'lat': pos.latitude,
              'lon': pos.longitude,
            });
            print(
              '📤 Periodic location → lat: ${pos.latitude}, lon: ${pos.longitude}',
            );
          }
        }
      });

      // Listen for backend events
      socket.on('delivery:new_request', _handleNewRequest);
      socket.on('delivery:you_assigned', _handleAssigned);

      socket.onAny((event, data) {
        print('📩 Event received → $event : $data');
      });
    });

    socket.onDisconnect((_) {
      print('🔌 Socket disconnected');
      setState(() => isSocketConnected = false);
      Fluttertoast.showToast(msg: "Socket Disconnected!");
    });

    socket.onConnectError((error) {
      print('❌ Socket connection error: $error');
      setState(() => isSocketConnected = false);
      Fluttertoast.showToast(msg: "Socket Connection Error: $error");
    });

    socket.onError((error) {
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

  /* void _handleNewRequest(dynamic payload) {
    print("🚚 New Delivery Request: $payload");
    final requestData = Map<String, dynamic>.from(payload as Map);
    final requestWithTimer = DeliveryRequest(
      deliveryId: requestData['deliveryId'] as String,
      category: requestData['category'] ?? 'Unknown Category',
      recipient: requestData['recipient'] ?? 'Unknown Recipient',
      dropOffLocation: requestData['dropOffLocation'] ?? 'Unknown Location',
      countdown: 1000,
    );
    _showRequestPopup(requestWithTimer);
  }
*/

  void _handleNewRequest(dynamic payload) {
    print("🚚 New Delivery Request: $payload");
    final requestData = Map<String, dynamic>.from(payload as Map);

    final dropoff = requestData['dropoff'] as Map<String, dynamic>? ?? {};
    final pickup =
        requestData['pickup'] as Map<String, dynamic>? ??
        {}; // Optional: for future use

    final expiresAt = requestData['expiresAt'] as int? ?? 0;
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final countdownMs = expiresAt - nowMs;
    final countdown = (countdownMs > 0 ? (countdownMs / 1000).round() : 0);

    if (countdown <= 0) {
      print("⚠️ Request expired before showing popup.");
      // Optional: Call _skipDelivery here if you want to auto-reject expired requests
      return;
    }

    final requestWithTimer = DeliveryRequest(
      deliveryId: requestData['deliveryId'] as String? ?? '',
      category:
          'Delivery', // Customize if needed, e.g., pickup['name'] ?? 'Unknown Category'
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
        );
      } else {
        Fluttertoast.showToast(
          msg: response.message ?? "Failed to fetch delivery details",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error fetching delivery details");
    }
  }

  void _acceptDelivery(String deliveryId) {
    if (socket.connected) {
      socket.emitWithAck(
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
    if (socket.connected) {
      socket.emitWithAck(
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
    Timer? countdownTimer;
    int currentCountdown = req.countdown;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted && dialogContext.mounted) {
            setState(() {
              currentCountdown--;
            });
            if (currentCountdown <= 0) {
              timer.cancel();
              _skipDelivery(req.deliveryId);
              if (dialogContext.mounted) Navigator.of(dialogContext).pop();
              Fluttertoast.showToast(
                msg: "Time expired! Delivery auto-rejected.",
              );
            }
          }
        });

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(req.category),

              // content: Column(
              //   mainAxisSize: MainAxisSize.min,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //
              //     Text("Recipient: ${req.recipient}"),
              //     SizedBox(height: 8.h),
              //     Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Icon(Icons.location_on, size: 16.sp, color: Colors.green),
              //         SizedBox(width: 5.w),
              //         Expanded(child: Text(req.dropOffLocation)),
              //       ],
              //     ),
              //     SizedBox(height: 8.h),
              //
              //     Text(
              //         "Time left: ${currentCountdown}s",
              //         style: TextStyle(color: currentCountdown <= 3 ? Colors.red : Colors.green)
              //     ),
              //
              //   ],
              // ),
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
                      // Expanded(child: Text("Pickup: ${req.pickupName ?? 'Unknown Pickup'}")), // You'd need to add pickupName to DeliveryRequest
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
                          selectIndex = 4;
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

                  status == "pending"
                      ? GestureDetector(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            "Add your driving license, or any other means of  driving identification used in your country",
                                            style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF111111),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // SvgPicture.asset(
                                    //   "assets/SvgImage/Group.svg",
                                    //   // color: Color(0xFFC0C5C2),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),

                  SizedBox(height: 10.h),

                  status == "pending"
                      ? GestureDetector(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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

                                    // SvgPicture.asset(
                                    //   "assets/SvgImage/Group.svg",
                                    //   // color: Color(0xFFC0C5C2),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),

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
                              onPressed: () =>
                                  setState(() => isVisible = !isVisible),
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
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
                          // Text("Socket: ${isSocketConnected ? 'Connected' : 'Disconnected'}",
                          //     style: TextStyle(color: isSocketConnected ? Colors.green : Colors.red)),
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
            getDriverProfile();
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
