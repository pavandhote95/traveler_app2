import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travel_app2/app/modules/home/controllers/community_controller.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var showSearchBar = false.obs;
  var isTravelingModeOn = false.obs;
  final TextEditingController searchController = TextEditingController();

  void changeTab(int index) {
    selectedIndex.value = index;
    if (index == 1) {
      showSearchBar.value = true;
      selectedIndex.value = 0;
    } else {
      showSearchBar.value = false;
    }
  }

  Future<void> enableTravelingMode() async {
    isTravelingModeOn.value = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Error", "Location services are disabled.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Error", "Location permissions are denied");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("Error", "Location permissions are permanently denied");
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final city = placemarks.first.locality ?? '';
      if (city.isNotEmpty) {
        Get.find<CommunityController>().fetchPostsByLocation(city);
        Get.snackbar("Traveling Mode", "Showing posts from $city");
      } else {
        Get.snackbar("Error", "Could not determine city from location.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to get location: $e");
    }
  }
}
