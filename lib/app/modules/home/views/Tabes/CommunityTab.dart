// lib/app/modules/community/views/community_tab.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/modules/post_quesions/views/bottom_sheet_questions.dart';


import '../../../../models/post_model.dart';
import '../../controllers/community_controller.dart';



class CommunityTab extends StatefulWidget {
    CommunityTab({super.key});

  @override
  State<CommunityTab> createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab> {
    final controller = Get.put(CommunityController());

    late final MatchEngine matchEngine = MatchEngine(
        swipeItems: controller.posts
            .map(
                (post) => SwipeItem(
                content: post,
                likeAction: () => controller.incrementIndex(),
                nopeAction: () => controller.incrementIndex(),
            ),
        )
            .toList(),
    );

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppColors.mainBg,
            body:SafeArea(
  child:  SwipeCards(
        matchEngine: controller.matchEngine, // ✅ use from controller
        itemBuilder: (context, index) {
          final postIndex = controller.currentIndex.value + index;
          if (postIndex < controller.posts.length) {
            return _buildPostCard(controller.posts[postIndex], postIndex);
          } else {
            return const SizedBox.shrink();
          }
        },
        onStackFinished: () {
          setState(() {
                controller.reset();
          controller.initializeSwipeEngine();
            
          });
       // 🔁 rebuild cards
        },
        upSwipeAllowed: false,
        fillSpace: true,
      )),

            
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => BottomSheetQuestionsView(),
                    );
                },
                backgroundColor: AppColors.buttonBg,
                child: const Icon(Icons.add, color: Colors.black, size: 30),
            ),
        );
    }

    Widget _buildPostCard(PostModel post, int index) {
        final lines = post.postText.split('\n');
        final isExpanded = controller.isExpanded[index] ?? false;
        final displayText =
        isExpanded || lines.length <= 4 ? post.postText : lines.take(4).join('\n');

        return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            color: AppColors.cardBg,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Colors.grey, width: 0.4),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // User Info
                            Row(
                                children: [
                                    CircleAvatar(radius: 24, backgroundImage: NetworkImage(post.userImage)),
                                    const SizedBox(width: 12),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Row(
                                                children: [
                                                    Text(post.username,
                                                        style: GoogleFonts.montserrat(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16,
                                                            color: Colors.white)),
                                                    const SizedBox(width: 4),
                                                    const Icon(Icons.verified, size: 18, color: Colors.blue),
                                                ],
                                            ),
                                            Text('${post.location} · ${post.time}',
                                                style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[500])),
                                        ],
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.more_horiz, color: Colors.white),
                                ],
                            ),
                            const SizedBox(height: 16),
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
                                                        style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white),
                                                    ),
                                                    if (lines.length > 4)
                                                        TextSpan(
                                                            text: isExpanded ? '\nShow Less' : '\nShow More',
                                                            style: GoogleFonts.montserrat(
                                                                fontSize: 16,
                                                                color: AppColors.buttonBg,
                                                                fontWeight: FontWeight.w600),
                                                            recognizer: TapGestureRecognizer()
                                                                ..onTap = () => controller.toggleExpanded(index),
                                                        ),
                                                ],
                                            ),
                                        ),
                                    ),
                                    const SizedBox(height: 16),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.asset(post.postImage,
                                            height: 180, width: double.infinity, fit: BoxFit.cover),
                                    ),
                                ],
                            ),
                            const SizedBox(height: 16),
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
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    CircleAvatar(radius: 22, backgroundImage: NetworkImage(post.commentUserImage)),
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
                                                    Text(post.commentUser,
                                                        style: GoogleFonts.montserrat(
                                                            fontWeight: FontWeight.bold, color: Colors.white)),
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
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    const CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            "https://randomuser.me/api/portraits/men/1.jpg")),
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
                                        icon: const Icon(Icons.send, color: AppColors.buttonBg),
                                        onPressed: () {
                                            ScaffoldMessenger.of(Get.context!).showSnackBar(
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
