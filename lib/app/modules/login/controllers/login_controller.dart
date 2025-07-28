import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_app2/app/constants/my_toast.dart'; // ✅ Import toast
import 'package:travel_app2/app/services/api_service.dart';
import '../../../routes/app_pages.dart';


class LoginController extends GetxController {
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final apiService = Get.find<ApiService>();

  void login() async {
    final input = emailOrPhoneController.text.trim();
    final password = passwordController.text.trim();

    if (input.isEmpty || password.isEmpty) {
      CustomToast.showErrorHome(Get.context!, 'Please enter all fields');
      return;
    }

    isLoading.value = true;

    try {
      final bool isPhone = RegExp(r'^\d+$').hasMatch(input);

      final response = await apiService.loginUser(
        email: isPhone ? null : input,
        phoneNumber: isPhone ? input : null,
        password: password,
      );

      final data = jsonDecode(response.body);
      isLoading.value = false;

      if (response.statusCode == 200) {
        CustomToast.showSuccess(Get.context!,  'Please Enter Otp');
        Get.toNamed(Routes.OTP);
      } else {
        CustomToast.showError(Get.context!, data['message'] ?? 'Login Failed');
      }
    } catch (e) {
      isLoading.value = false;
      CustomToast.showError(Get.context!, 'Something went wrong. Try again.');
      debugPrint("Login Exception: $e");
    }
  }

  void loginWithGoogle() {
    Get.snackbar("Google Login", "Coming soon!");
  }

  void loginWithApple() {
    Get.snackbar("Apple Login", "Coming soon!");
  }

  void goToRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  @override
  void onClose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
