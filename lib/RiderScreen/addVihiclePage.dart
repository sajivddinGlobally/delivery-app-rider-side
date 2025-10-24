import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/network/api.state.dart';
import '../config/utils/pretty.dio.dart';
import '../data/model/AddBodyVihileModel.dart';
import '../data/model/VihicleResponseModel.dart'; // corrected import to match API

class AddVihiclePage extends StatefulWidget {
  const AddVihiclePage({super.key});
  @override
  State<AddVihiclePage> createState() => _AddVihiclePageState();
}

class _AddVihiclePageState extends State<AddVihiclePage> {
  List<Datum>? vehicleList = <Datum>[];
  Datum? selectedVehicle;

  final numberPlateController = TextEditingController();
  final modelController = TextEditingController();
  final capacityWeightController = TextEditingController();
  final capacityVolumeController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getVehicleType();
  }

  Future<void> getVehicleType() async {
    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);
      final response = await service.getVehicleType(); // Returns VihicleResponseModel

      setState(() {
        vehicleList = response.data ?? <Datum>[];
      });
    } catch (e) {
      print("Error fetching vehicle types: $e");
    }
  }

  Future<void> submitVehicle() async {
    if (selectedVehicle == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please select a vehicle type')));
      return;
    }

    if (numberPlateController.text.isEmpty ||
        modelController.text.isEmpty ||
        capacityWeightController.text.isEmpty ||
        capacityVolumeController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final dio = await callDio();
      final service = APIStateNetwork(dio);

      final body = AddVihicleBodyModel(
        vehicle: selectedVehicle!.id.toString(),
        numberPlate: numberPlateController.text,
        model: modelController.text,
        capacityWeight: 1,
        capacityVolume: 2,
      );

      final response = await service.addNewVehicle(body);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message?? "Vehicle added successfully")));

      // Clear inputs or navigate back
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
            "Add Vehicle",
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF091425),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Select Vehicle Type",
                style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.black),
              ),

              SizedBox(height: 10.h),


              vehicleList!.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  :

              Container(
                decoration: BoxDecoration(color: Color(0xffF3F7F5)),
                child: DropdownButtonFormField<Datum>(
                  value: selectedVehicle,
                  items:
                  vehicleList!.map((vehicle) {
                    return
                      DropdownMenuItem<Datum>(
                      value: vehicle,
                      child: Text(vehicle.name ?? "Unknown",
                        style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVehicle = value;
                    });
                  },
                  decoration: InputDecoration(
                    hint:
                    Text(
                      "Select Vehicle Type",
                      style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                  ),
                ),
              ),


              SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(color: Color(0xffF3F7F5)),
            child:
              buildTextField("Number Plate", numberPlateController),),
              SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(color: Color(0xffF3F7F5)),
            child:
              buildTextField("Model", modelController),),
              SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(color: Color(0xffF3F7F5)),
            child:
              buildTextField("Capacity Weight", capacityWeightController),),
              SizedBox(height: 20.h),

          Container(
            decoration: BoxDecoration(color: Color(0xffF3F7F5)),
            child:  buildTextField("Capacity Volume", capacityVolumeController),),

              
              SizedBox(height: 30.h),
              // Center(
              //   child: isLoading
              //       ? const CircularProgressIndicator()
              //       : ElevatedButton(
              //     onPressed: submitVehicle,
              //     child: const Text("Submit Vehicle"),
              //   ),
              // ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(420.w, 48.h),
                  backgroundColor: Color(0xff006970),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
                onPressed: isLoading ? null : submitVehicle,
                child: isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.black,
                )
                    : Text(
                  "Submit",
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
    );
  }

  Widget buildTextField(String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        filled: true,
        fillColor: const Color.fromARGB(12, 255, 255, 255),
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}