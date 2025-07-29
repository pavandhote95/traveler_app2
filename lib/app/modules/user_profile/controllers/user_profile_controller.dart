import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_app2/app/constants/my_toast.dart';
import 'package:travel_app2/app/routes/app_pages.dart';
import 'package:travel_app2/app/services/api_service.dart';

class UserProfileController extends GetxController {
  final box = GetStorage();
  final ApiService apiService = Get.find<ApiService>();
 final RxInt totalPosts = 5.obs;
  final RxInt totalAnswers = 12.obs;
  void logoutUser() async {
    final token = box.read('token');
    print("📦 Token from storage: $token");
     

    if (token == null) {
      CustomToast.showError(Get.context!, 'User not logged in');
      return;
    }

    try {
      final response = await apiService.logoutUser(token);
      if (response.statusCode == 200) {
        await box.erase();
        CustomToast.showSuccess(Get.context!, 'Logout successful');
        Get.offAllNamed(Routes.LOGIN);
      } else {
            Get.offAllNamed(Routes.LOGIN);
        CustomToast.showError(Get.context!, 'Logout failed');
      }
    } catch (e) {
      CustomToast.showError(Get.context!, 'Logout error: $e');
    }
  }
}
