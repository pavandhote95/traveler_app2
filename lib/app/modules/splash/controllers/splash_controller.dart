import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app2/app/routes/app_pages.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 2.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutBack),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    animationController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(Routes.ONBOARDING);
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
