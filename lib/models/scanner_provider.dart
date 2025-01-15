import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:vibration/vibration.dart';

class ScannerProvider extends ChangeNotifier {
  bool _isScanning = true;
  User? currentUser;
  String? _apiData;

  String? get apiData => _apiData;

  bool get isScanning => _isScanning;

  void changeScanner() {
    _isScanning = !_isScanning;
    notifyListeners();
  }

  void checkAuthentication() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      currentUser = user;
        notifyListeners();
    });
   
  }

  Future<void> sendDataToApi(String scannedData) async {
    final url = Uri.parse('https://bdcoe-mail-service.vercel.app/qr/verify');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'encrypted': scannedData,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (await Vibration.hasVibrator() != null) {
          Vibration.vibrate();
        }
        _apiData = responseBody['msg'];
      } else {
        if (await Vibration.hasVibrator() != null) {
          Vibration.vibrate();
        }
        _apiData = 'Data:${scannedData}\nFailed ';
      }
    } catch (e) {
      _apiData = 'An error occurred: $e';
    }
    notifyListeners();
  }

  Future<void> sendManualDataToApi(String member1, String member2) async {
    final url =
        Uri.parse('https://bdcoe-mail-service.vercel.app/qr/manualVerify');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'member1studentNo': member1,
          'member2studentNo': member2,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (await Vibration.hasVibrator() != null) {
          Vibration.vibrate();
          _apiData = responseBody['msg'];
        }
        // _showResponseDialog(responseBody['msg']);
      } else {
        if (await Vibration.hasVibrator() != null) {
          Vibration.vibrate();
        }
        _apiData = "Failed to submit. Please try again later.";
        // _showResponseDialog('Failed to submit. Please try again later.');
      }
    } catch (e) {
      _apiData = "An error occurred: $e";
      //_showResponseDialog('An error occurred: $e');
    }
    notifyListeners();
  }

  ScannerProvider() {
    Future<void> requestCameraPermission() async {
      if (await Permission.camera.isDenied) {
        await Permission.camera.request();
      }
    }
  }
}
