import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'getRatingController.dart'; // your provider file

class RatingListPage extends ConsumerWidget {
  const RatingListPage({super.key});

  // Convert timestamp to readable date
  String _formatDate(int? timestamp) {
    if (timestamp == null) return "N/A";
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratingsAsync = ref.watch(ratingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: Text(
          "Ratings & Reviews",
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ratingsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.orange),
        ),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 50, color: Colors.red.shade300),
              SizedBox(height: 16.h),
              Text("Oops! $err", style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 12.h),
              ElevatedButton.icon(
                onPressed: () => ref.refresh(ratingProvider),
                icon: const Icon(Icons.refresh),
                label: const Text("Retry"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
              ),
            ],
          ),
        ),
        data: (response) {
          final ratings = response.data?.list ?? [];

          if (ratings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.rate_review_outlined, size: 60, color: Colors.grey),
                  SizedBox(height: 16.h),
                  Text(
                    "No ratings yet",
                    style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: ratings.length,
            itemBuilder: (context, index) {
              final item = ratings[index];
              final fullName = "${item.userId?.firstName ?? ''} ${item.userId?.lastName ?? ''}".trim();
              final initials = fullName.isNotEmpty ? fullName[0].toUpperCase() : "?";

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                margin: EdgeInsets.only(bottom: 12.h),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.orange.shade100,
                        child: Text(
                          initials,
                          style: TextStyle(
                            color:Color(0xFF006970),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                              fullName.isEmpty ? "Anonymous" : fullName,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),

                            // Date
                            Text(
                              _formatDate(item.date),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 8.h),

                            // Comment
                            if (item.comment != null && item.comment!.isNotEmpty)
                              Text(
                                item.comment!,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            SizedBox(height: 8.h),

                            // Stars
                            Row(
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < (item.rating ?? 0)
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Color(0xFF006970),
                                  size: 18.sp,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}