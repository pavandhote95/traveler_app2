import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  void login() async {



    final input = emailOrPhoneController.text.trim();
    final password = passwordController.text.trim();



// Simulate login delay

      // Navigate to OTP screen or dashboard
      Get.toNamed(Routes.OTP);

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
