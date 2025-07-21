import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app2/app/constants/my_toast.dart';
import 'package:travel_app2/app/routes/app_pages.dart';

class OtpController extends GetxController {
  final RxInt secondsRemaining = 30.obs;
  final RxBool isLoading = false.obs; // 👈 Add loading state

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

  void resendOtp(BuildContext context) {
    CustomToast.showSuccess(context, "A new OTP has been sent.");
    startTimer();
  }

  void verify4DigitOtp(BuildContext context) async {
    String otp = otpControllers.map((e) => e.text).join();

    if (otp.length == 4) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      isLoading.value = false;
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      CustomToast.showErrorHome(context, "Enter the complete 4-digit OTP");
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
