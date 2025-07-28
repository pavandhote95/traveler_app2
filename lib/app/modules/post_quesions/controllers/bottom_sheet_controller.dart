import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app2/app/modules/home/controllers/community_controller.dart';
import 'package:travel_app2/app/services/api_service.dart';




class BottomSheetQuestionsController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString? selectedLocation = RxString('');
  final RxString questionText = ''.obs;
  final ApiService _apiService = Get.find<ApiService>();
  final picker = ImagePicker();
  final RxBool isPickingImage = false.obs;
    final isLoading = false.obs;
// Flag to track image picking state
  final CommunityController communityController = Get.find<CommunityController>();

  Future<void> pickImage() async {
    if (isPickingImage.value) {
      print('Image picker already active, ignoring request');
      return;
    }

    print('Picking image from gallery...');
    try {
      isPickingImage.value = true; // Set flag to true
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        print('Image picked: ${pickedFile.path}');
        selectedImage.value = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
      if (e.toString().contains('already_active')) {
        Get.snackbar('Error', 'Image picker is already active, please try again',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Failed to pick image: $e',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } finally {
      isPickingImage.value = false; // Reset flag
    }
  }

  void clearImage() {
    print('Clearing selected image');
    selectedImage.value = null;
  }

  void updateLocation(String? location) {
    print('Updating location to: $location');
    selectedLocation?.value = location ?? '';
  }

  void updateQuestion(String value) {
    print('Updating question text to: $value');
    questionText.value = value;
  }

  Future<void> submitPost() async {
    print('Submitting post...');
    print('Question: ${questionText.value}, Location: ${selectedLocation!.value}, Image: ${selectedImage.value?.path}');

    if (questionText.value.isEmpty || selectedLocation!.value.isEmpty) {
      print('Validation failed: Empty question or location');
      Get.snackbar('Error', 'Please fill in both question and location fields',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      print('Calling API to add post...');
      final response = await _apiService.addPost(
        question: questionText.value,
        location: selectedLocation!.value,
        imageFile: selectedImage.value,
      );

      print('API response status code: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        print('Post created successfully');
        Get.snackbar('Success', 'Post created successfully',
            backgroundColor: Colors.green, colorText: Colors.white);

        // Fetch updated posts
        try {
          print('Fetching updated posts after successful submission...');
          await communityController.fetchPosts();
          Get.back();
          print('Updated posts fetched successfully');
        } catch (e) {
          print('Error fetching updated posts: $e');
          Get.snackbar('Warning', 'Post created but failed to fetch updated posts: $e',
              backgroundColor: Colors.orange, colorText: Colors.white);
        }

        // Clear fields after successful submission
        questionText.value = '';
        selectedLocation!.value = '';
        selectedImage.value = null;
        print('Fields cleared after successful submission');
      } else {
        print('Failed to create post: ${response.statusCode} - ${response.reasonPhrase}');
        Get.snackbar('Error', 'Failed to create post: ${response.statusCode} - ${response.reasonPhrase}',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Error during post submission: $e');
      Get.snackbar('Error', 'Failed to create post: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}