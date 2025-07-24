import 'package:get/get.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:travel_app2/app/services/api_service.dart';
import '../views/community_model.dart';


class CommunityController extends GetxController {
  RxList<PostModel> posts = <PostModel>[].obs;
  RxInt currentIndex = 0.obs;
  Map<int, bool> isExpanded = {};
  late MatchEngine matchEngine;

  final ApiService apiService = Get.find<ApiService>(); // Access ApiService instance

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final data = await apiService.fetchPosts(); // Use ApiService to fetch posts
      List<PostModel> loadedPosts = [];
      for (var item in data) {
        loadedPosts.add(PostModel.fromJson(item));
      }
      posts.value = loadedPosts;
      initializeSwipeEngine();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load posts: $e');
    }
  }

  void initializeSwipeEngine() {
    final swipeItems = List.generate(
      posts.length * 100, // Large number to simulate infinite looping
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