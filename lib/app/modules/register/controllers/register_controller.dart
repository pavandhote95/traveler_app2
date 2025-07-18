import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app2/app/routes/app_pages.dart';
class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController(); // ✅ Add this
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  void register() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    Get.snackbar('Success', 'Registered successfully!');
    Get.toNamed('/login');
  }

  void goToLogin() {
    Get.toNamed('/login');
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose(); // ✅ Dispose here too
    passwordController.dispose();
    super.onClose();
  }
}
