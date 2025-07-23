import 'package:get/get.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../../models/post_model.dart';

class CommunityController extends GetxController {
  final posts = <PostModel>[].obs;
  final currentIndex = 0.obs;
  final isExpanded = <int, bool>{}.obs;

  late List<SwipeItem> swipeItems;
  late MatchEngine matchEngine;

  @override
  void onInit() {
    super.onInit();
    loadPosts();
    initializeSwipeEngine(); // 💡 Call here if posts are static
  }

  void loadPosts() {
    posts.assignAll([

         PostModel(
            username: 'Yaksh Dalwadi',
            userImage: 'https://randomuser.me/api/portraits/men/51.jpg',
            location: 'Rome, Italy',
            time: '21h',
            postText:
            'Planning a Rome surprise trip\nfor my girlfriend this month.\nAny romantic food places?\nThinking Colosseum or Vatican.\nDrop your fav chill spots!',
            postImage: 'assets/images/post1.png',
            likes: 20000,
            commentUser: 'Isha Solanki',
            commentUserImage: 'https://randomuser.me/api/portraits/women/44.jpg',
            commentText:
            'Highly Recommend Lantica Da’ Pizzeria if you are visiting Naples after Rome.',
        ),
        PostModel(
            username: 'Aarav Mehta',
            userImage: 'https://randomuser.me/api/portraits/men/45.jpg',
            location: 'Venice, Italy',
            time: '5h',
            postText:
            'Venice is a dream place!\nLoved the colorful Burano town.\nGondola rides are magical.\nEach canal tells a story.\nDon’t miss local pasta spots!',
            postImage: 'assets/images/post2.jpg',
            likes: 15000,
            commentUser: 'Simran Kaur',
            commentUserImage: 'https://randomuser.me/api/portraits/women/55.jpg',
            commentText: 'Definitely go for a gondola ride — unforgettable!',
        ),
        PostModel(
            username: 'Ravi Sharma',
            userImage: 'https://randomuser.me/api/portraits/men/51.jpg',
            location: 'Paris, France',
            time: '2d',
            postText:
            'The Eiffel Tower never gets old.\nSunset views are stunning.\nBoat ride on the Seine.\nCroissants are delicious.\nParis is always a good idea.',
            postImage: 'assets/images/post3.jpg',
            likes: 12000,
            commentUser: 'Priya Verma',
            commentUserImage: 'https://randomuser.me/api/portraits/women/68.jpg',
            commentText: 'Love Paris! Especially in spring 🌸',
        ),
        PostModel(
            username: 'Ananya Singh',
            userImage: 'https://randomuser.me/api/portraits/women/39.jpg',
            location: 'London, UK',
            time: '3h',
            postText:
            'Explored Camden Market today.\nTried some amazing food.\nStreet art is everywhere.\nLoved the vintage shops.\nLondon is magical in the rain.',
            postImage: 'assets/images/post4.jpg',
            likes: 8900,
            commentUser: 'Neha Joshi',
            commentUserImage: 'https://randomuser.me/api/portraits/women/28.jpg',
            commentText: 'Camden is the vibe! ❤️',
        ),
        PostModel(
            username: 'Kunal Patel',
            userImage: 'https://randomuser.me/api/portraits/men/29.jpg',
            location: 'Barcelona, Spain',
            time: '7h',
            postText:
            'Visited Sagrada Familia today.\nGaudi’s designs are unreal.\nStreet musicians everywhere.\nTapas are a must-try.\nCity full of colors and culture.',
            postImage: 'assets/images/post5.jpg',
            likes: 10400,
            commentUser: 'Tanya Dutta',
            commentUserImage: 'https://randomuser.me/api/portraits/women/32.jpg',
            commentText: 'It’s my dream to visit there someday!',
        ),
        PostModel(
            username: 'Meera Nair',
            userImage: 'https://randomuser.me/api/portraits/women/77.jpg',
            location: 'Prague, Czechia',
            time: '10h',
            postText:
            'Wandered around Prague Castle.\nDrank coffee at a riverside cafe.\nCharles Bridge is stunning.\nOld Town is a gem.\nPerfect solo travel destination.',
            postImage: 'assets/images/post6.jpg',
            likes: 7600,
            commentUser: 'Sana Khan',
            commentUserImage: 'https://randomuser.me/api/portraits/women/80.jpg',
            commentText: 'Prague is magical 🏰',
        ),
        PostModel(
            username: 'Arjun Rao',
            userImage: 'https://randomuser.me/api/portraits/men/22.jpg',
            location: 'Amsterdam, Netherlands',
            time: '14h',
            postText:
            'Rented a cycle today.\nExplored the canals.\nHad Dutch pancakes for lunch.\nVisited Van Gogh museum.\nAmsterdam is peaceful yet lively.',
            postImage: 'assets/images/post7.jpg',
            likes: 11200,
            commentUser: 'Divya Kapoor',
            commentUserImage: 'https://randomuser.me/api/portraits/women/59.jpg',
            commentText: 'Totally agree! The vibes there are unmatched.',
        ),
        PostModel(
            username: 'Nikhil Dey',
            userImage: 'https://randomuser.me/api/portraits/men/36.jpg',
            location: 'Santorini, Greece',
            time: '1d',
            postText:
            'Blue domes and white walls.\nCliffside cafes everywhere.\nHad fresh seafood for dinner.\nSunset was breathtaking.\nSantorini is paradise on earth.',
            postImage: 'assets/images/post2.jpg',
            likes: 13400,
            commentUser: 'Ayesha Sheikh',
            commentUserImage: 'https://randomuser.me/api/portraits/women/33.jpg',
            commentText: 'I want to honeymoon there 😍',
        ),
        PostModel(
            username: 'Shruti Bansal',
            userImage: 'https://randomuser.me/api/portraits/women/19.jpg',
            location: 'Dubai, UAE',
            time: '4d',
            postText:
            'Watched fountain show at Burj.\nDesert safari was amazing.\nLoved the night skyline.\nTried camel milk ice cream.\nShopping malls are huge here!',
            postImage: 'assets/images/post9.jpg',
            likes: 9400,
            commentUser: 'Radhika Sharma',
            commentUserImage: 'https://randomuser.me/api/portraits/women/24.jpg',
            commentText: 'The view from the top is unreal!',
        ),
        PostModel(
            username: 'Manav Desai',
            userImage: 'https://randomuser.me/api/portraits/men/18.jpg',
            location: 'New York, USA',
            time: '9h',
            postText:
            'Times Square in the rain.\nVisited Central Park.\nHad street hotdogs.\nWatched a Broadway show.\nNew York never sleeps.',
            postImage: 'assets/images/post10.jpg',
            likes: 15300,
            commentUser: 'Juhi Saxena',
            commentUserImage: 'https://randomuser.me/api/portraits/women/13.jpg',
            commentText: 'NYC is always alive 🗽',

      // 🔁 Add the same PostModel list from your original code here.
   ) 
      // your PostModel list (same as you pasted)
    ]);
  }

  void toggleExpanded(int index) {
    isExpanded[index] = !(isExpanded[index] ?? false);
  }

  void reset() {
    currentIndex.value = 0;
  }

  void incrementIndex() {
    currentIndex.value = (currentIndex.value ++).clamp(0, posts.length - 1);
  }



  /// 🔄 Swipe Engine Setup
  void initializeSwipeEngine() {
    swipeItems = posts.map((post) {
      return SwipeItem(
        content: post,
        likeAction: () {
          incrementIndex();
        },
        nopeAction: () {
          incrementIndex();
        },
      );
    }).toList();

    matchEngine = MatchEngine(swipeItems: swipeItems);
  }
}
