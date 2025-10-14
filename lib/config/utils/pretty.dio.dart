import 'dart:developer';

import 'package:delivery_rider_app/RiderScreen/login.page.dart';
import 'package:delivery_rider_app/config/utils/navigatorKey.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio callDio() {
  final dio = Dio();
  dio.interceptors.add(
    PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        var box = Hive.box("folder");
        var token = box.get("token");
        options.headers.addAll({
          "Content-type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        });
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioException e, handler) {
        final globalContext = navigatorKey.currentContext;
        if (globalContext != null) {
          if (e.response!.statusCode == 401) {
            ScaffoldMessenger.of(globalContext).showSnackBar(
              SnackBar(
                content: Text("Token expire please login again."),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(left: 15.w, bottom: 15.h, right: 15.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  side: BorderSide.none,
                ),
              ),
            );
            Navigator.pushAndRemoveUntil(
              globalContext,
              CupertinoPageRoute(builder: (context) => LoginPage()),
              (route) => false,
            );
          }
        } else {
          log("Global context is null, cannot show SnackBar or navigate");
        }
        handler.next(e);
      },
    ),
  );
  return dio;
}
