import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:delivery_rider_app/RiderScreen/identityCard.page.dart';
import 'package:delivery_rider_app/config/network/api.state.dart';
import 'package:delivery_rider_app/config/utils/pretty.dio.dart';
import 'package:delivery_rider_app/data/model/driverUpdateProfileImageBodyModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

var box = Hive.box("userdata");

class _DocumentPageState extends State<DocumentPage> {
  File? _image;

  final picker = ImagePicker();

  Future pickImageFromGallery() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final PickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (PickedFile != null) {
        setState(() {
          _image = File(PickedFile.path);
        });
        box.put('driver_photo_path', PickedFile.path);
      }
    } else {
      log("Gallery Permission denied");
    }
  }

  Future pickImageFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final PickedFile = await picker.pickImage(source: ImageSource.camera);
      if (PickedFile != null) {
        setState(() {
          _image = File(PickedFile.path);
        });
        box.put('driver_photo_path', PickedFile.path);
      }
    } else {
      log("Camera permission denied");
    }
  }

  Future showImage() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                await pickImageFromGallery();
                if (_image != null) {
                  await uploadImage();
                }
              },
              child: Text("Gallery"),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                await pickImageFromCamera();
                if (_image != null) {
                  await uploadImage();
                }
              },
              child: Text("Camera"),
            ),
          ],
        );
      },
    );
  }

  // Future<void> uploadDriverPhoto() async {
  //   try {
  //     final body = DriverUpdateProfileImageBodyModel(image: _image!.path);
  //     final service = APIStateNetwork(callDio());
  //     final response = await service.driverUpdateProfileImage(body);
  //     if (response.code == 0) {
  //       Fluttertoast.showToast(msg: response.message);
  //       //Navigator.pop(context);
  //     } else {
  //       Fluttertoast.showToast(msg: response.message);
  //     }
  //   } catch (e, st) {
  //     log(e.toString());
  //     log(st.toString());
  //     Fluttertoast.showToast(msg: "Something went wrong");
  //   }
  // }

  Future<String?> uploadImage() async {
    try {
      if (_image == null || !await _image!.exists()) {
        throw Exception('Image file does not exist at path: ${_image?.path}');
      }

      // 🧠 Get token from Hive
      var token = box.get('token'); // e.g. your login token

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://weloads.com/api/v1/driver/updateProfileImage'),
      );

      // ✅ Add Authorization header
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          _image!.path,
          filename: 'profile.jpg',
        ),
      );

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);
      final responseData =
          jsonDecode(responseBody.body) as Map<String, dynamic>;

      // if (response.statusCode == 200 &&
      //     responseData['error'] == false &&
      //     responseData['data'] != null &&
      //     responseData['data']['imageUrl'] != null) {

      //   Fluttertoast.showToast(msg: "image upload ");
      //   box.put('driver_photo_path', responseData['data']['imageUrl']);
      //   return responseData['data']['imageUrl'] as String;
      // } else {
      //   throw Exception('Invalid response format: $responseData');
      // }
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "image upload");
        box.put('driver_photo_path', responseData['data']['imageUrl']);
        return responseData['data']['imageUrl'] as String;
      } else {
        log("error");
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(
        msg: "Failed to upload image: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.sp,
      );
      return null;
    }
  }

  // Future<void> uploadDriverPhoto() async {
  //   try {
  //     final dio = await callDio();
  //     final service = APIStateNetwork(dio);

  //     final file = await MultipartFile.fromFile(
  //       _image!.path,
  //       filename: _image!.path.split('/').last,
  //     );

  //     final body = DriverUpdateProfileImageBodyModel(image: file);

  //     final response = await service.driverUpdateProfileImage(
  //       body.toFormData(),
  //     );

  //     if (response.code == 0) {
  //       Fluttertoast.showToast(msg: response.message);
  //     } else {
  //       Fluttertoast.showToast(msg: response.message);
  //     }
  //   } catch (e, st) {
  //     log(e.toString());
  //     log(st.toString());
  //     Fluttertoast.showToast(msg: "Something went wrong");
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _loadImageFromHive();
  // }

  // Future<void> _loadImageFromHive() async {
  //   box = Hive.box('userdata');
  //   final path = box.get('driver_photo_path');
  //   if (path != null && File(path).existsSync()) {
  //     setState(() {
  //       _image = File(path);
  //     });
  //   }
  // }

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
          InkWell(
            onTap: () async {
              await showImage();
            },
            child: driverUploadPhoto(_image, "Driver's Photo"),
          ),
          SizedBox(height: 24.h),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => IdentityCardPage()),
              );
            },
            child: VerifyWidget("assets/id-card.png", "Identity Card (front)"),
          ),
          SizedBox(height: 24.h),
          // VerifyWidget("assets/id.png", "Identity Card (back)"),
        ],
      ),
    );
  }

  Widget driverUploadPhoto(File? selectedImage, String name) {
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: const Color(0xFFF0F5F5),
      ),
      child: Row(
        children: [
          // ✅ If user selected image, show it; otherwise show default asset
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: selectedImage != null
                ? Image.file(
                    selectedImage,
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/photo.jpg",
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(width: 30.w),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF4F4F4F),
            ),
          ),
          const Spacer(),
          const Icon(Icons.warning_amber_rounded, color: Colors.red),
        ],
      ),
    );
  }

  Widget VerifyWidget(String image, String name) {
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: Color(0xFFF0F5F5),
      ),
      child: Row(
        children: [
          Image.asset(image, width: 40.w, height: 40.h, fit: BoxFit.cover),
          SizedBox(width: 30.w),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4F4F4F),
            ),
          ),
          Spacer(),
          Icon(Icons.warning_amber_rounded, color: Colors.red),
        ],
      ),
    );
  }
}
