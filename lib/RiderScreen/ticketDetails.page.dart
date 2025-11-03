import 'dart:developer';

import 'package:delivery_rider_app/config/network/api.state.dart';
import 'package:delivery_rider_app/config/utils/pretty.dio.dart';
import 'package:delivery_rider_app/data/controller/getTicketListController.dart';
import 'package:delivery_rider_app/data/model/ticketReplyBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const TicketDetailsPage({super.key, required this.id});

  @override
  ConsumerState<TicketDetailsPage> createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends ConsumerState<TicketDetailsPage> {
  final messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  /// ✅ Send message API
  Future<void> _handleSendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    // UI update first
    setState(() {
      _messages.add({'text': text, 'isSender': true});
    });
    messageController.clear();

    try {
      final body = TicketReplyBodyModel(
        message: text, // ✅ send the typed message
        ticketId: widget.id, // ✅ fixed: using widget.id
      );

      final service = APIStateNetwork(callDio());
      final response = await service.ticketReply(body);

      if (response.code == 0) {
        Fluttertoast.showToast(msg: "Message sent successfully!");
      } else {
        Fluttertoast.showToast(msg: response.message);
      }
    } catch (e, st) {
      log("Error sending message: $e\n$st");
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticketDetailsProvider = ref.watch(ticketDetailsController(widget.id));
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFFFFFF),
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
            style: IconButton.styleFrom(shape: CircleBorder()),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20.sp),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Text(
            "Support/Faq Details",
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF091425),
            ),
          ),
        ),
      ),
      body: ticketDetailsProvider.when(
        data: (snap) {
          return Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Color(0xFFCBCBCB), thickness: 1),
                SizedBox(height: 28.h),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),
                      topRight: Radius.circular(10.r),
                    ),
                    color: Color(0xFFF0F5F5),
                  ),
                  child: Text(
                    snap.data.ticket!.subject,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final isSender = msg['isSender'] ?? false;
                      return Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Align(
                          alignment: isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: isSender
                                  ? const Color(0xFF008080)
                                  : const Color(0xFFF0F5F5),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                                topRight: Radius.circular(10.r),
                                bottomLeft: Radius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              msg['text'] ?? '',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 70.h),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          log(stackTrace.toString());
          return Center(child: Text(error.toString()));
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
      bottomSheet: MessageInput(
        controller: messageController,
        onSend: _handleSendMessage,
      ),
    );
  }
}

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
              child: TextField(
                controller: controller,
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
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.grey, width: 1.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: Color(0xFF006970),
                      width: 1.w,
                    ),
                  ),
                  hintText: "Type a message ...",
                  helperStyle: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFAFAFAF),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 55.w,
              height: 54.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF008080),
              ),
              child: Center(
                child: Icon(Icons.send_sharp, color: Colors.white, size: 28.sp),
              ),
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
    );
  }
}
