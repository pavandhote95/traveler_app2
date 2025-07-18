import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app2/app/routes/app_pages.dart'; // Change as per your project

class OtpController extends GetxController {
  final RxInt secondsRemaining = 30.obs;
  Timer? _timer;

  // OTP input boxes
  final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    secondsRemaining.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  void resendOtp() {
    Get.snackbar("OTP Sent", "A new OTP has been sent.",
        backgroundColor: Colors.green, colorText: Colors.white);
    startTimer();
  }

  void verify4DigitOtp() {
    String otp = otpControllers.map((e) => e.text).join();
    if (otp.length == 4) {
      Get.offAllNamed(Routes.DASHBOARD); // Adjust route as per your setup
    } else {
      Get.snackbar("Invalid OTP", "Enter the complete 4-digit OTP.",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var c in otpControllers) {
      c.dispose();
    }
    super.onClose();
  }
}
