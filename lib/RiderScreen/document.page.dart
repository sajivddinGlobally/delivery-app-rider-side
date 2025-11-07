// import 'dart:developer';
// import 'dart:io';

// import 'package:delivery_rider_app/RiderScreen/identityCard.page.dart';
// import 'package:delivery_rider_app/config/network/api.state.dart';
// import 'package:delivery_rider_app/config/utils/pretty.dio.dart';
// import 'package:delivery_rider_app/data/model/driverUpdateProfileImageBodyModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class DocumentPage extends StatefulWidget {
//   const DocumentPage({super.key});

//   @override
//   State<DocumentPage> createState() => _DocumentPageState();
// }

// var box = Hive.box("userdata");

// class _DocumentPageState extends State<DocumentPage> {
//   File? _image;

//   final picker = ImagePicker();

//   Future pickImageFromGallery() async {
//     var status = await Permission.camera.request();
//     if (status.isGranted) {
//       final PickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (PickedFile != null) {
//         setState(() {
//           _image = File(PickedFile.path);
//         });
//         box.put('driver_photo_path', PickedFile.path);
//       }
//     } else {
//       log("Gallery Permission denied");
//     }
//   }

//   Future pickImageFromCamera() async {
//     var status = await Permission.camera.request();
//     if (status.isGranted) {
//       final PickedFile = await picker.pickImage(source: ImageSource.camera);
//       if (PickedFile != null) {
//         setState(() {
//           _image = File(PickedFile.path);
//         });
//         box.put('driver_photo_path', PickedFile.path);
//       }
//     } else {
//       log("Camera permission denied");
//     }
//   }

//   Future showImage() async {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) {
//         return CupertinoActionSheet(
//           actions: [
//             CupertinoActionSheetAction(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await pickImageFromGallery();
//                 if (_image != null) {
//                   // await uploadImage();
//                   await uploadDriverPhoto();
//                 }
//               },
//               child: Text("Gallery"),
//             ),
//             CupertinoActionSheetAction(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await pickImageFromCamera();
//                 if (_image != null) {
//                   // await uploadImage();
//                   await uploadDriverPhoto();
//                 }
//               },
//               child: Text("Camera"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> uploadDriverPhoto() async {
//     try {
//       final body = DriverUpdateProfileImageBodyModel(image: _image!.path);
//       final service = APIStateNetwork(callDio());
//       final response = await service.driverUpdateProfileImage(body);
//       if (response.code == 0) {
//         Fluttertoast.showToast(msg: response.message);
//         //Navigator.pop(context);
//       } else {
//         Fluttertoast.showToast(msg: response.message);
//       }
//     } catch (e, st) {
//       log(e.toString());
//       log(st.toString());
//       Fluttertoast.showToast(msg: "Something went wrong");
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loadImageFromHive();
//   }

//   Future<void> _loadImageFromHive() async {
//     box = Hive.box('userdata');
//     final path = box.get('driver_photo_path');
//     if (path != null && File(path).existsSync()) {
//       setState(() {
//         _image = File(path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFFFFF),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Color(0xFFFFFFFF),
//         leading: Padding(
//           padding: EdgeInsets.only(left: 20.w),
//           child: IconButton(
//             style: IconButton.styleFrom(shape: CircleBorder()),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back_ios, size: 20.sp),
//           ),
//         ),
//         title: Padding(
//           padding: EdgeInsets.only(left: 15.w),
//           child: Text(
//             "Documents",
//             style: GoogleFonts.inter(
//               fontSize: 15.sp,
//               fontWeight: FontWeight.w400,
//               color: Color(0xFF091425),
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 10.h),
//           Divider(color: Color(0xFFCBCBCB), thickness: 1),
//           SizedBox(height: 28.h),
//           InkWell(
//             onTap: () async {
//               await showImage();
//             },
//             child: driverUploadPhoto(_image, "Driver's Photo"),
//           ),
//           SizedBox(height: 24.h),
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 CupertinoPageRoute(builder: (context) => IdentityCardPage()),
//               );
//             },
//             child: VerifyWidget("assets/id-card.png", "Identity Card (front)"),
//           ),
//           SizedBox(height: 24.h),
//           // VerifyWidget("assets/id.png", "Identity Card (back)"),
//         ],
//       ),
//     );
//   }

//   Widget driverUploadPhoto(File? selectedImage, String name) {
//     return Container(
//       margin: EdgeInsets.only(left: 24.w, right: 24.w),
//       padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5.r),
//         color: const Color(0xFFF0F5F5),
//       ),
//       child: Row(
//         children: [
//           // ✅ If user selected image, show it; otherwise show default asset
//           ClipRRect(
//             borderRadius: BorderRadius.circular(6.r),
//             child: selectedImage != null
//                 ? Image.file(
//                     selectedImage,
//                     width: 40.w,
//                     height: 40.h,
//                     fit: BoxFit.cover,
//                   )
//                 : Image.asset(
//                     "assets/photo.jpg",
//                     width: 40.w,
//                     height: 40.h,
//                     fit: BoxFit.cover,
//                   ),
//           ),
//           SizedBox(width: 30.w),
//           Text(
//             name,
//             style: GoogleFonts.inter(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               color: const Color(0xFF4F4F4F),
//             ),
//           ),
//           const Spacer(),
//           const Icon(Icons.warning_amber_rounded, color: Colors.red),
//         ],
//       ),
//     );
//   }

//   Widget VerifyWidget(String image, String name) {
//     return Container(
//       margin: EdgeInsets.only(left: 24.w, right: 24.w),
//       padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5.r),
//         color: Color(0xFFF0F5F5),
//       ),
//       child: Row(
//         children: [
//           Image.asset(image, width: 40.w, height: 40.h, fit: BoxFit.cover),
//           SizedBox(width: 30.w),
//           Text(
//             name,
//             style: GoogleFonts.inter(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               color: Color(0xFF4F4F4F),
//             ),
//           ),
//           Spacer(),
//           Icon(Icons.warning_amber_rounded, color: Colors.red),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:delivery_rider_app/RiderScreen/identityCard.page.dart';
import 'package:delivery_rider_app/config/network/api.state.dart';
import 'package:delivery_rider_app/config/utils/pretty.dio.dart';
import 'package:delivery_rider_app/data/controller/getProfileController.dart';
import 'package:delivery_rider_app/data/model/driverUpdateProfileImageBodyModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentPage extends ConsumerStatefulWidget {
  const DocumentPage({super.key});

  @override
  ConsumerState<DocumentPage> createState() => _DocumentPageState();
}

var box = Hive.box("userdata");

class _DocumentPageState extends ConsumerState<DocumentPage> {
  File? _image;
  final picker = ImagePicker();

  Future pickImageFromGallery() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        box.put('driver_photo_path', pickedFile.path);
      }
    } else {
      log("Gallery permission denied");
      Fluttertoast.showToast(msg: "Gallery permission denied");
    }
  }

  Future pickImageFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        box.put('driver_photo_path', pickedFile.path);
      }
    } else {
      log("Camera permission denied");
      Fluttertoast.showToast(msg: "Camera permission denied");
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
                  // await uploadDriverPhoto();
                  await uploadDriverImage();
                }
              },
              child: const Text("Gallery"),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                await pickImageFromCamera();
                if (_image != null) {
                  //await uploadDriverPhoto();
                  await uploadDriverImage();
                }
              },
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );
  }

  // /// ✅ FIXED: Proper Multipart Upload
  // Future<void> uploadDriverPhoto() async {
  //   try {
  //     if (_image == null) {
  //       Fluttertoast.showToast(msg: "Please select an image first");
  //       return;
  //     }

  //     final multipartFile = await MultipartFile.fromFile(
  //       _image!.path,
  //       filename: _image!.path.split('/').last,
  //     );

  //     final body = DriverUpdateProfileImageBodyModel(image: multipartFile);
  //     final service = APIStateNetwork(callDio());
  //     final response = await service.driverUpdateProfileImage(multipartFile);

  //     if (response.code == 0) {
  //       Fluttertoast.showToast(msg: response.message);
  //       log("✅ Image uploaded successfully to server");
  //       ref.invalidate(profileController);
  //       print(response);
  //     } else {
  //       Fluttertoast.showToast(msg: response.message);
  //       log("⚠️ Upload failed: ${response.message}");
  //     }
  //   } catch (e, st) {
  //     log("❌ Upload error: $e");
  //     log(st.toString());
  //     Fluttertoast.showToast(msg: "Something went wrong");
  //   }
  // }

  Future<void> uploadDriverImage() async {
    try {
      final body = DriverUpdateProfileImageBodyModel(image: _image!.path);
      final service = APIStateNetwork(callDio());
      final response = await service.driverUpdateProfileImage(body);
      if (response.code == 0) {
        Fluttertoast.showToast(msg: response.message);
        //Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: response.message);
      }
    } catch (e, st) {
      log(e.toString());
      log(st.toString());
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadImageFromHive();
  }

  Future<void> _loadImageFromHive() async {
    box = Hive.box('userdata');
    final path = box.get('driver_photo_path');
    if (path != null && File(path).existsSync()) {
      setState(() {
        _image = File(path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFFFFFF),
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
            style: IconButton.styleFrom(shape: const CircleBorder()),
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
              color: const Color(0xFF091425),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Divider(color: const Color(0xFFCBCBCB), thickness: 1),
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
                CupertinoPageRoute(
                  builder: (context) => const IdentityCardPage(),
                ),
              );
            },
            child: VerifyWidget("assets/id-card.png", "Identity Card (front)"),
          ),
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
        color: const Color(0xFFF0F5F5),
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
              color: const Color(0xFF4F4F4F),
            ),
          ),
          const Spacer(),
          const Icon(Icons.warning_amber_rounded, color: Colors.red),
        ],
      ),
    );
  }
}
