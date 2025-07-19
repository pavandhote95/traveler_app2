import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {


  final nameController = TextEditingController();
  final emailOrMobileController = TextEditingController();
  final passwordController = TextEditingController();

  void register() {
    String name = nameController.text.trim();
    String emailOrMobile = emailOrMobileController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || emailOrMobile.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all fields');
      return;
    }

    bool isEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailOrMobile);
    bool isMobile = RegExp(r'^\d{10}$').hasMatch(emailOrMobile);

    if (!isEmail && !isMobile) {
      Fluttertoast.showToast(msg: 'Enter valid email or mobile number');
      return;
    }

    String type = isEmail ? 'email' : 'mobile';

    // Simulate register API call
    Fluttertoast.showToast(
      msg: 'Registering with $type: $emailOrMobile',
    );

    // TODO: Make actual API call here
  }

  @override
  void onClose() {
    nameController.dispose();
    emailOrMobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}