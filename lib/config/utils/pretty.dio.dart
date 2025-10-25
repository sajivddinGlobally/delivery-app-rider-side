import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../RiderScreen/login.page.dart';
import 'navigatorKey.dart';

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
  var box = Hive.box("userdata");
  var token = box.get("token");
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll({
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        });
        handler.next(options);
      },

      onResponse: (response, handler) {
        handler.next(response);
        if (response.data['code'] == 401 || response.data['code'] == 3) {
          // final errorMessage = response.) ?? "Unauthorized access";
          // log('Unauthorized Error: ${e.response?.data}');
          navigatorKey.currentState?.pushAndRemoveUntil(
            CupertinoPageRoute(builder: (_) => LoginPage()),
            (route) => false,
          );
          box.clear();
          Fluttertoast.showToast(
            msg: response.data['message'],
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },

      onError: (DioException e, handler) {
        String extractErrorMessage(dynamic data) {
          String defaultMessage = "An error occurred";
          if (data is Map<String, dynamic>) {
            final errors = data['errors'];
            if (errors is Map && errors.isNotEmpty) {
              final firstError = errors.values.first;
              if (firstError is List && firstError.isNotEmpty) {
                return firstError.first.toString();
              }
            }
          }
          return defaultMessage;
        }

        if (e.requestOptions.path.contains("/api/login")) {
          log("Invalid email or password");
          Fluttertoast.showToast(
            msg: "Invalid email or password",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          handler.next(e);
          return;
        }
        if (e.response?.statusCode == 401) {
          final errorMessage =
              extractErrorMessage(e.response?.data) ?? "Unauthorized access";
          log('Unauthorized Error: ${e.response?.data}');
          Fluttertoast.showToast(
            msg: errorMessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (e.response?.statusCode == 422) {
          final errorMessage =
              extractErrorMessage(e.response?.data) ??
              "Please enter valid data";
          log('Validation Error: ${e.response?.data}');
          Fluttertoast.showToast(
            msg: errorMessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (e.response?.statusCode == 404) {
          final errorMessage =
              extractErrorMessage(e.response?.data) ?? "Resource not found";
          log('Not Found Error: ${e.response?.data}');
          Fluttertoast.showToast(
            msg: errorMessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (e.response?.statusCode == 403) {
          final errorMessage =
              extractErrorMessage(e.response?.data) ?? "Forbidden access";
          log('Forbidden Error: ${e.response?.data}');
          Fluttertoast.showToast(
            msg: errorMessage,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          log('Unexpected Error: ${e.message}');
          Fluttertoast.showToast(
            msg: "An unexpected error occurred",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        handler.next(e);
      },
    ),
  );
  return dio;
}
