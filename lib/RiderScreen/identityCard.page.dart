import 'dart:convert';
import 'dart:io';
import 'package:delivery_rider_app/RiderScreen/home.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../config/network/api.state.dart';
import '../config/utils/pretty.dio.dart';
import '../data/model/saveDriverBodyModel.dart';

class IdentityCardPage extends StatefulWidget {
  const IdentityCardPage({super.key});

  @override
  State<IdentityCardPage> createState() => _IdentityCardPageState();
}
class _IdentityCardPageState extends State<IdentityCardPage> {
  File? frontImage;
  File? backImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false; // <-- loader state

  // Pick image from Camera or Gallery
  Future<void> pickImage(bool isFront, ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          frontImage = File(pickedFile.path);
        } else {
          backImage = File(pickedFile.path);
        }
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No image selected')));
    }
  }

  // Image Picker Widget (same as before)
  Widget buildImagePicker({required File? imageFile, required String label, required bool isFront}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            label,
            style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF4F4F4F)),
          ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: imageFile != null
              ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              border: Border.all(color: Colors.black),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.sp),
              child: Image.file(
                imageFile,
                width: 306.w,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
          )
              : ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(306.w, 45.h),
              backgroundColor: const Color(0xFF006970),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
            onPressed: () => showImageSourceSheet(isFront),
            child: Text(
              "Select $label",
              style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // Show BottomSheet for selecting Camera or Gallery (same as before)
  void showImageSourceSheet(bool isFront) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(isFront, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(isFront, ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Upload Image to server (same as before)
  Future<String?> uploadImage(File image) async {
    try {
      if (!await image.exists()) throw Exception('Image file does not exist at path: ${image.path}');

      var request = http.MultipartRequest('POST', Uri.parse('https://weloads.com/api/v1/uploadImage'));
      request.files.add(await http.MultipartFile.fromPath('file', image.path, filename: 'profile.jpg'));

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);
      final responseData = jsonDecode(responseBody.body) as Map<String, dynamic>;

      if (response.statusCode == 200 &&
          responseData['error'] == false &&
          responseData['data'] != null &&
          responseData['data']['imageUrl'] != null) {
        return responseData['data']['imageUrl'] as String;
      } else {
        throw Exception('Invalid response format: $responseData');
      }
    } catch (e) {
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

  // Submit images with loader
  Future<void> submitImages() async {
    if (frontImage == null || backImage == null) {
      Fluttertoast.showToast(
        msg: "Please select both front and back images",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 12.sp,
      );
      return;
    }

    setState(() => isLoading = true); // show loader

    try {
      final frontImageUrl = await uploadImage(frontImage!);
      if (frontImageUrl == null || frontImageUrl.isEmpty) throw Exception("Failed to upload front image");

      final backImageUrl = await uploadImage(backImage!);
      if (backImageUrl == null || backImageUrl.isEmpty) throw Exception("Failed to upload back image");

      final body = SaveDriverBodyModel(identityFront: frontImageUrl, identityBack: backImageUrl);

      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.saveDriverDocuments(body);

      Fluttertoast.showToast(
        msg: response.message ?? "Profile updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 12.sp,
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  HomePage()));
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.sp,
      );
    } finally {
      setState(() => isLoading = false); // hide loader
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
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, size: 20.sp),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Text(
            "Identity Card",
            style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w400, color: const Color(0xFF091425)),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    "Make sure the entire ID and all the details are VISIBLE",
                    style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF4F4F4F)),
                  ),
                ),
                SizedBox(height: 20.h),
                buildImagePicker(imageFile: frontImage, label: "Front Photo", isFront: true),
                SizedBox(height: 30.h),
                buildImagePicker(imageFile: backImage, label: "Back Photo", isFront: false),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(306.w, 45.h),
                        backgroundColor: const Color(0xFF006970),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                      ),
                      onPressed: submitImages,
                      child: Text(
                        "Submit",
                        style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),

          // Centered Loader
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: CircularProgressIndicator(
                  color: const Color(0xFF006970),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

