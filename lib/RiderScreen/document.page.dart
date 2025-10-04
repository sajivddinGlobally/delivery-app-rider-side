import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
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
            "Documents",
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF091425),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Divider(color: Color(0xFFCBCBCB), thickness: 1),
          SizedBox(height: 28.h),
          Container(
            margin: EdgeInsets.only(left: 24.w, right: 24.w),
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 10.h,
              bottom: 10.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: Color(0xFFF0F5F5),
            ),
            child: Row(
              children: [
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
