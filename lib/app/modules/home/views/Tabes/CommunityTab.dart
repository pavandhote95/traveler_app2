import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/modules/post_quesions/views/bottom_sheet_questions.dart';


class PostModel {
    final String username;
    final String userImage;
    final String location;
    final String time;
    final String postText;
    final String postImage;
    final int likes;
    final String commentUser;
    final String commentUserImage;
    final String commentText;

    PostModel({
        required this.username,
        required this.userImage,
        required this.location,
        required this.time,
        required this.postText,
        required this.postImage,
        required this.likes,
        required this.commentUser,
        required this.commentUserImage,
        required this.commentText,
    });
}

class CommunityTab extends StatefulWidget {
    const CommunityTab({super.key});

    @override
    State<CommunityTab> createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab> {
    late List<SwipeItem> _swipeItems;
    late MatchEngine _matchEngine;
    int currentIndex = 0;
    final Map<int, bool> _isExpanded = {};

    final List<PostModel> posts = [
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
        ),
    ];
  void initializeSwipeEngine() {
    _swipeItems = posts.map((post) {
      return SwipeItem(
        content: post,
        likeAction: () {
          setState(() {
            currentIndex = (currentIndex ++).clamp(0, posts.length);
          });
        },
        nopeAction: () {
          setState(() {
            currentIndex = (currentIndex --).clamp(0, posts.length);
          });
        },
      );
    }).toList();

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

    

    @override
    void initState() {
        super.initState();
        initializeSwipeEngine();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppColors.mainbg,
            body: SafeArea(
                child: SwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (context, index) {
                        final postIndex = currentIndex + index;
                        if (postIndex < posts.length) {
                            return _buildPostCard(posts[postIndex], postIndex);
                        } else {
                            return const SizedBox.shrink();
                        }
                    },
                    onStackFinished: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("🎉 End of posts")),
                        );
                        setState(() {
                            currentIndex = 0;
                            initializeSwipeEngine();
                        });
                    },
                    upSwipeAllowed: false,
                    fillSpace: true,
                ),
            ),

            // ✅ Floating Action Button
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) =>  BottomSheetQuestionsView(),
                    );

                    // TODO: Navigate to post creation screen
                },
                backgroundColor:AppColors.floatingButton,
                child: const Icon(Icons.add, color: Colors.black, size: 30)

            ),
        );
    }

    Widget _buildPostCard(PostModel post, int index) {
        final lines = post.postText.split('\n');
        final isExpanded = _isExpanded[index] ?? false;
        final displayText =
        isExpanded || lines.length <= 4 ? post.postText : lines.take(4).join('\n');

        return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            color: AppColors.cardbg,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color:Colors.grey, width: 0.4),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // User Info Row
                            Row(
                                children: [
                                    CircleAvatar(radius: 24, backgroundImage: NetworkImage(post.userImage)),
                                    const SizedBox(width: 12),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Row(
                                                children: [
                                                    Text(
                                                        post.username,
                                                        style: GoogleFonts.montserrat(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                        ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    const Icon(Icons.verified, size: 18, color: Colors.blue),
                                                ],
                                            ),
                                            Text(
                                                '${post.location} · ${post.time}',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: Colors.grey[500],
                                                ),
                                            ),
                                        ],
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.more_horiz, color: Colors.white),
                                ],
                            ),

                            const SizedBox(height: 16),

                            // Text + Image block
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    SizedBox(
                                        width: 300,
                                        child: RichText(
                                            text: TextSpan(
                                                children: [
                                                    TextSpan(
                                                        text: displayText,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                        ),
                                                    ),
                                                    if (lines.length > 4)
                                                        TextSpan(
                                                            text: isExpanded ? '\nShow Less' : '\nShow More',
                                                            style: GoogleFonts.montserrat(
                                                                fontSize: 16,
                                                                color: Colors.tealAccent,
                                                                fontWeight: FontWeight.w600,
                                                            ),
                                                            recognizer: TapGestureRecognizer()
                                                                ..onTap = () {
                                                                    setState(() {
                                                                        _isExpanded[index] = !(_isExpanded[index] ?? false);
                                                                    });
                                                                },
                                                        ),
                                                ],
                                            ),
                                        ),
                                    ),
                                    const SizedBox(height: 16),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.asset(
                                            post.postImage,
                                            height: 180,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                        ),
                                    ),
                                ],
                            ),

                            const SizedBox(height: 16),

                            // Likes & Comments Row
                            Row(
                                children: [
                                    const Icon(Icons.favorite_border, color: Colors.white),
                                    const SizedBox(width: 8),
                                    Text('${post.likes} Likes',
                                        style: GoogleFonts.montserrat(color: Colors.white)),
                                    const SizedBox(width: 20),
                                    const Icon(Icons.comment_outlined, color: Colors.white),
                                    const SizedBox(width: 8),
                                    Text('Replies', style: GoogleFonts.montserrat(color: Colors.white)),
                                    const Spacer(),
                                    const Icon(Icons.share_outlined, color: Colors.white),
                                ],
                            ),

                            const SizedBox(height: 16),

                            // Comment Preview
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    CircleAvatar(
                                        radius: 22,
                                        backgroundImage: NetworkImage(post.commentUserImage)),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[800],
                                                borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Text(
                                                        post.commentUser,
                                                        style: GoogleFonts.montserrat(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                        ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(post.commentText,
                                                        style: GoogleFonts.montserrat(color: Colors.white)),
                                                ],
                                            ),
                                        ),
                                    ),
                                ],
                            ),

                            const SizedBox(height: 20),

                            // Add comment
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    const CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            "https://randomuser.me/api/portraits/men/1.jpg"),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[850],
                                                borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: TextField(
                                                style: const TextStyle(color: Colors.white),
                                                decoration: InputDecoration(
                                                    hintText: 'Add a comment...',
                                                    hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                                                    border: InputBorder.none,
                                                ),
                                            ),
                                        ),
                                    ),
                                    IconButton(
                                        icon: const Icon(Icons.send, color: Colors.tealAccent),
                                        onPressed: () {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Comment sent')),
                                            );
                                        },
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

}