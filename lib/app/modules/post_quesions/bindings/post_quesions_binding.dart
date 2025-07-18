import 'package:get/get.dart';

import '../controllers/post_quesions_controller.dart';

class PostQuesionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostQuesionsController>(
      () => PostQuesionsController(),
    );
  }
}
