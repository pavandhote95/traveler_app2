import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; // You can remove if unused
import 'package:travel_app2/app/constants/my_toast.dart'; // Adjust the path if needed

class ForgotPasswordController extends GetxController {
  final emailOrPhoneController = TextEditingController();
  var isLoading = false.obs;

  void sendOtp() async {
    final input = emailOrPhoneController.text.trim();

    if (input.isEmpty) {
      CustomToast.showError(Get.context!, "Please enter your email or mobile number");
      return;
    }

    if (!_isValidEmail(input) && !_isValidPhone(input)) {
      CustomToast.showError(Get.context!, "Please enter a valid email or 10-digit mobile number");
      return;
    }

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      CustomToast.showSuccess(Get.context!, "OTP has been sent to $input");

      Get.toNamed("/otp", arguments: {"input": input});
    } finally {
      isLoading.value = false;
    }
  }

  bool _isValidEmail(String input) {
    return GetUtils.isEmail(input);
  }

  bool _isValidPhone(String input) {
    return RegExp(r'^\d{10}$').hasMatch(input);
  }

  @override
  void onClose() {
    emailOrPhoneController.dispose();
    super.onClose();
  }
}
