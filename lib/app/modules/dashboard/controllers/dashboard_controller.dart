import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var showSearchBar = false.obs;
  final TextEditingController searchController = TextEditingController();

  void changeTab(int index) {
    selectedIndex.value = index;
    if (index == 1) {
      showSearchBar.value = true;
      selectedIndex.value = 0; // Stay on HomeView
    } else {
      showSearchBar.value = false;
    }
  }
}