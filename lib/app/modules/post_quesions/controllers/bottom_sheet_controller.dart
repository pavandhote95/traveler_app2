import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetQuestionsController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString? selectedLocation = RxString('');
  final RxString questionText = ''.obs;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }

  void updateLocation(String? location) {
    selectedLocation?.value = location ?? '';
  }

  void updateQuestion(String value) {
    questionText.value = value;
  }
}
