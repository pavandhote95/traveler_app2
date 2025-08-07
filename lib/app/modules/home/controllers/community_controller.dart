import 'package:get/get.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:travel_app2/app/services/api_service.dart';
import '../views/community_model.dart';


class CommunityController extends GetxController {
  RxList<PostModel> allPosts = <PostModel>[].obs; 
  RxList<PostModel> locationPosts = <PostModel>[].obs; 
  RxList<PostModel> filteredPosts = <PostModel>[].obs;
  RxInt currentIndex = 0.obs;
  RxBool isTravelingMode = false.obs; 
  Map<int, bool> isExpanded = {};
  late MatchEngine matchEngine;
  final ApiService apiService = Get.find<ApiService>();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final data = await apiService.fetchPosts();
      allPosts.value = data.map((e) => PostModel.fromJson(e)).toList();
      updateFilteredPosts();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load posts: $e');
    }
  }

  Future<void> fetchPostsByLocation(String location) async {
    try {
      final data = await apiService.fetchPostsByLocation(location);
      locationPosts.value = data.map((e) => PostModel.fromJson(e)).toList();
      updateFilteredPosts();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load location posts: $e');
    }
  }

  void setTravelingMode(bool isTraveling) {
    isTravelingMode.value = isTraveling;
    updateFilteredPosts();
  }

  void updateFilteredPosts() {
    // Determine which posts to display based on traveling mode
    List<PostModel> basePosts = isTravelingMode.value ? locationPosts : allPosts;

    // Apply search filter if there's a query
    if (searchQuery.value.isEmpty) {
      filteredPosts.assignAll(basePosts);
    } else {
      final lowerKeyword = searchQuery.value.toLowerCase();
      filteredPosts.assignAll(basePosts.where((post) =>
          post.question.toLowerCase().contains(lowerKeyword) ||
          post.location.toLowerCase().contains(lowerKeyword)));
    }

    initializeSwipeEngine();
  }

  void searchPosts(String keyword) {
    searchQuery.value = keyword;
    updateFilteredPosts();
  }

  void initializeSwipeEngine() {
    final swipeItems = List.generate(
      filteredPosts.length * 100,
      (index) => SwipeItem(
        content: filteredPosts[index % filteredPosts.length],
        likeAction: () => incrementIndex(index % filteredPosts.length),
        nopeAction: () => incrementIndex(index % filteredPosts.length),
      ),
    );
    matchEngine = MatchEngine(swipeItems: swipeItems);
    update();
  }

  void incrementIndex(int index) {
    currentIndex.value = (index + 1) % filteredPosts.length;
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
