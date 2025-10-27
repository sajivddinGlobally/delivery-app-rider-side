/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:delivery_rider_app/config/utils/pretty.dio.dart'; // Assuming this provides callDio()
import 'package:delivery_rider_app/config/network/api.state.dart'; // For APIStateNetwork
import 'package:delivery_rider_app/data/model/DeliveryHistoryResponseModel.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/model/DeliveryHistoryDataModel.dart'; // For request model

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<Delivery> deliveryHistory = []; // List of Delivery models
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDeliveryHistory();
  }

  Future<void> _fetchDeliveryHistory() async {
    try {
      setState(() => isLoading = true);
      final dio = await callDio();
      final service = APIStateNetwork(dio);

      final requestBody = DeliveryHistoryRequestModel(
        page: 1,
        limit: 10,
        key: "",
      );

      final response = await service.getDeliveryHistory(requestBody);

      print("Response code: ${response.code}, error: ${response.error}, data: ${response.data != null}");

      if (response.code == 0 && !response.error && response.data != null) {
        setState(() {
          deliveryHistory = response.data.deliveries; // Access the deliveries list from Data
        });
        print("Loaded ${deliveryHistory.length} deliveries");
      } else {
        Fluttertoast.showToast(msg: "Failed to load delivery history");
      }
    } catch (e) {
      print("Error fetching delivery history: $e");
      Fluttertoast.showToast(msg: "Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking History")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : deliveryHistory.isEmpty
          ? const Center(child: Text("No bookings available"))
          : ListView.builder(
        itemCount: deliveryHistory.length,
        itemBuilder: (context, index) {
          final item = deliveryHistory[index];
          return

          //   Card(
          //   margin: const EdgeInsets.all(8.0),
          //   child: ListTile(
          //     leading: CircleAvatar(
          //       child: Text(item.status.substring(0, 1).toUpperCase()),
          //     ),
          //     title: Text("Delivery ID: ${item.txId}"),
          //     subtitle: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text("Customer: ${item.name}"), // Use 'name' for customer name instead of ID
          //         Text("Status: ${item.status}"),
          //         Text("Distance: ${item.distance} km"),
          //         Text("Payment: ${item.paymentMethod}"),
          //         if (item.cancellationReason != null)
          //           Text("Cancelled: ${item.cancellationReason}", style: const TextStyle(color: Colors.red)),
          //       ],
          //     ),
          //     trailing: Icon(
          //       item.status == 'completed' ? Icons.check_circle : Icons.schedule,
          //       color: item.status == 'completed' ? Colors.green : Colors.orange,
          //     ),
          //     onTap: () {
          //       // Navigate to details page or show dialog with more info
          //       _showDeliveryDetails(item);
          //     },
          //   ),
          // );
            Padding(
              padding: EdgeInsets.only(
                bottom: 15.h,
                left: 25.w,
                right: 25.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ORDB1234",
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
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
                        ],
                      ),
                      Spacer(),
                      if (index == 0)
                        Container(
                          padding: EdgeInsets.only(
                            left: 6.w,
                            right: 6.w,
                            top: 2.h,
                            bottom: 2.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.r),
                            color: Color(0xFFFFF4C7),
                          ),
                          child: Center(
                            child: Text(
                              "In progress",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF7E6604),
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: EdgeInsets.only(
                            left: 6.w,
                            right: 6.w,
                            top: 2.h,
                            bottom: 2.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.r),
                            color: Color(0xFF27794D),
                          ),
                          child: Center(
                            child: Text(
                              "Complete",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 35.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            padding: EdgeInsets.only(left: 3.w, top: 2.h),
                            child: Text(
                              "21b, Karimu Kotun Street, Victoria Island",
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0C341F),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "12 January 2020, 2:43pm",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF545454),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Divider(color: Color(0xFFDCE8E9)),
                ],
              ),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchDeliveryHistory, // Refresh button
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _showDeliveryDetails(Delivery delivery) {
    // Helper to format timestamp to readable date (assuming timestamps in ms)
    String formatDate(int timestampMs) {
      final date = DateTime.fromMillisecondsSinceEpoch(timestampMs);
      return "${date.day}/${date.month}/${date.year}";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delivery Details - ${delivery.txId}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Pickup: ${delivery.pickup.name} (${delivery.pickup.lat}, ${delivery.pickup.long})"),
              Text("Dropoff: ${delivery.dropoff.name} (${delivery.dropoff.lat}, ${delivery.dropoff.long})"),
              Text("Package: ${delivery.packageDetails.fragile ? 'Fragile' : 'Standard'}"),
              Text("Amount: \$${delivery.userPayAmount}"),
              Text("Date: ${formatDate(delivery.createdAt)}"), // Use createdAt for actual date
              if (delivery.image != null) Text("Image: ${delivery.image}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}*/



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:delivery_rider_app/config/utils/pretty.dio.dart'; // Assuming this provides callDio()
import 'package:delivery_rider_app/config/network/api.state.dart'; // For APIStateNetwork
import 'package:delivery_rider_app/data/model/DeliveryHistoryResponseModel.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/model/DeliveryHistoryDataModel.dart';
import 'mapRequestDetails.page.dart'; // For request model

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<Delivery> deliveryHistory = []; // List of Delivery models
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDeliveryHistory();
  }

  Future<void> _fetchDeliveryHistory() async {
    try {
      setState(() => isLoading = true);
      final dio = await callDio();
      final service = APIStateNetwork(dio);

      final requestBody = DeliveryHistoryRequestModel(
        page: 1,
        limit: 10,
        key: "",
      );

      final response = await service.getDeliveryHistory(requestBody);

      print("Response code: ${response.code}, error: ${response.error}, data: ${response.data != null}");

      if (response.code == 0 && !response.error && response.data != null) {
        setState(() {
          deliveryHistory = response.data.deliveries; // Access the deliveries list from Data
        });
        print("Loaded ${deliveryHistory.length} deliveries");
      } else {
        Fluttertoast.showToast(msg: "Failed to load delivery history");
      }
    } catch (e) {
      print("Error fetching delivery history: $e");
      Fluttertoast.showToast(msg: "Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'ongoing':
        return "Ongoing";
      case 'assigned':
        return "Assigned";
      case 'completed':
        return "Complete";
      default:
        return status;
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'ongoing':
        return const Color(0xFFDF2940);
      case 'assigned':
        return const Color(0xFFFFF4C7);
      case 'completed':
        return const Color(0xFF27794D);
      default:
        return const Color(0xFF27794D);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'ongoing':
        return const Color(0xFFFFFFFF);
      case 'assigned':
        return const Color(0xFF7E6604);
      case 'completed':
        return const Color(0xFFFFFFFF);
      default:
        return const Color(0xFFFFFFFF);
    }
  }

  String _formatDate(int timestampMs) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestampMs);
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'pm' : 'am'}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking History")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : deliveryHistory.isEmpty
          ? const Center(child: Text("No bookings available"))
          : ListView.builder(
        itemCount: deliveryHistory.length,
        itemBuilder: (context, index) {
          final item = deliveryHistory[index];
          return GestureDetector(
            onTap: () {
              // item.status=="assigned"?
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>
              //
              //         MapRequestDetailsPage(
              //           pickupLat: item.pickup.lat,
              //           pickupLong: item.pickup.long,
              //           dropLat:item.dropoff.lat,
              //           droplong: item.dropoff.long,
              //           txtid:item.txId,
              //
              //         ))):

              // Navigate to details page or show dialog with more info
              // _showDeliveryDetails(item);
            },
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 15.h,
                left: 25.w,
                right: 25.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.txId,
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0C341F),
                            ),
                          ),
                          Text(
                            "Recipient: ${item.name}",
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF545454),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.only(
                          left: 6.w,
                          right: 6.w,
                          top: 2.h,
                          bottom: 2.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.r),
                          color: _getStatusBgColor(item.status),
                        ),
                        child: Center(
                          child: Text(
                            _getStatusText(item.status),
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: _getStatusTextColor(item.status),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
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
                      Column(
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
                            padding: EdgeInsets.only(left: 3.w, top: 2.h),
                            child: Text(
                              item.dropoff.name,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF0C341F),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            _formatDate(item.createdAt),
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF545454),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Divider(color: const Color(0xFFDCE8E9)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchDeliveryHistory, // Refresh button
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _showDeliveryDetails(Delivery delivery) {
    // Helper to format timestamp to readable date (assuming timestamps in ms)
    String formatDate(int timestampMs) {
      final date = DateTime.fromMillisecondsSinceEpoch(timestampMs);
      return "${date.day}/${date.month}/${date.year}";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delivery Details - ${delivery.txId}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Pickup: ${delivery.pickup.name} (${delivery.pickup.lat}, ${delivery.pickup.long})"),
              Text("Dropoff: ${delivery.dropoff.name} (${delivery.dropoff.lat}, ${delivery.dropoff.long})"),
              Text("Package: ${delivery.packageDetails.fragile ? 'Fragile' : 'Standard'}"),
              Text("Amount: \$${delivery.userPayAmount}"),
              Text("Date: ${formatDate(delivery.createdAt)}"), // Use createdAt for actual date
              if (delivery.image != null) Text("Image: ${delivery.image}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}