
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:qurhealth_task/ExportFiles/ExportFilesMust.dart';

String get kBaseURL {
  return 'https://rickandmortyapi.com/api/';
}

class CheckInternet {
  static Future<bool> checkInternet() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}

class API {
  final String url;

  API({required this.url});

  Future<http.Response> get() async {
    // if (!await CheckInternet.checkInternet()) {
    //   return null;
    // }

    try {
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          String internetConnectPoorBody = 'Internet connection is poor.';
          int internetConnectPoorCode = 1111;

          return http.Response(internetConnectPoorBody, internetConnectPoorCode);
        },
      );

      return response;
    } catch (error) {
      int apiExceptionCode = 1112;

      final response = http.Response(error.toString(), apiExceptionCode);
      return response;
    }
  }

}

