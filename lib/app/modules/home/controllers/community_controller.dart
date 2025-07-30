
// === community_controller.dart ===
import 'package:get/get.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:travel_app2/app/services/api_service.dart';

import '../views/community_model.dart';

class CommunityController extends GetxController {
  RxList<PostModel> posts = <PostModel>[].obs;
  RxInt currentIndex = 0.obs;
  Map<int, bool> isExpanded = {};
  late MatchEngine matchEngine;
  RxBool isSearchMode = false.obs;
  final ApiService apiService = Get.find<ApiService>();
  
  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final data = await apiService.fetchPosts();
      posts.value = data.map((e) => PostModel.fromJson(e)).toList();
      initializeSwipeEngine();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load posts: \$e');
    }
  }

  Future<void> fetchPostsByLocation(String location) async {
    try {
      final data = await apiService.fetchPostsByLocation(location);
      posts.value = data.map((e) => PostModel.fromJson(e)).toList();
      initializeSwipeEngine();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load location posts: \$e');
    }
  }

  void initializeSwipeEngine() {
    final swipeItems = List.generate(
      posts.length * 100,
      (index) => SwipeItem(
        content: posts[index % posts.length],
        likeAction: () => incrementIndex(index % posts.length),
        nopeAction: () => incrementIndex(index % posts.length),
      ),
    );
    matchEngine = MatchEngine(swipeItems: swipeItems);
    update();
  }

  void incrementIndex(int index) {
    currentIndex.value = (index + 1) % posts.length;
    update();
  }

  void reset() {
    currentIndex.value = 0;
    update();
  }

  void toggleExpanded(int index) {
    isExpanded[index] = !(isExpanded[index] ?? false);
    update();
  }
}
