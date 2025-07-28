import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/constants/custom_button.dart';
import 'package:travel_app2/app/modules/post_quesions/controllers/bottom_sheet_controller.dart';

class BottomSheetQuestionsView extends GetView<BottomSheetQuestionsController> {
  BottomSheetQuestionsView({Key? key}) : super(key: key) {
    Get.put(BottomSheetQuestionsController());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F2027),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            _buildTextField(),
            const SizedBox(height: 20),
            _buildImagePicker(),
            const SizedBox(height: 20),
            _buildDropdown(["Japan", "India", "USA"]),
            const SizedBox(height: 30),
            SafeArea(
              child: CustomButton(
                isLoading: controller.isLoading,
                onPressed: controller.submitPost,
                text: "Post",
                textColor: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }


  Widget _buildTextField() {
    return TextField(
      onChanged: controller.updateQuestion,
      maxLines: 5,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Ask a question post something",
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.buttonBg),
        ),
      ),
    );
  }

  Widget _buildDropdown(List<String> items) {
    return Obx(() => DropdownButtonFormField<String>(
          value: controller.selectedLocation?.value == '' ? null : controller.selectedLocation?.value,
          dropdownColor: const Color(0xFF1F1F1F),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Add Location (optional)",
            labelStyle: const TextStyle(color: AppColors.buttonBg),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.buttonBg),
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: controller.updateLocation,
        ));
  }

  Widget _buildImagePicker() {
    return Obx(() {
      final image = controller.selectedImage.value;
      return GestureDetector(
        onTap: controller.pickImage,
        child: image == null
            ? Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Center(
                  child: Text(
                    "+ Add Image",
                    style: TextStyle(color: AppColors.buttonBg),
                  ),
                ),
              )
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(image.path),
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: controller.clearImage,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black54,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
