import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/modules/post_quesions/views/bottom_sheet_questions.dart';
import '../../controllers/community_controller.dart';
import '../community_model.dart';

class CommunityTab extends StatefulWidget {
  const CommunityTab({super.key});

  @override
  State<CommunityTab> createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab> {
  final controller = Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      body: SafeArea(
        child: Obx(() {
          if (controller.posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.buttonBg),
            );
          }

          return SwipeCards(
            matchEngine: controller.matchEngine,
            itemBuilder: (context, index) {
              // Use modulo to loop through posts
              final postIndex = index % controller.posts.length;
              return _buildPostCard(controller.posts[postIndex], postIndex);
            },
            onStackFinished: () {
              // No need to call restartPosts here since we use modulo for infinite looping
              controller.reset();
            },
            upSwipeAllowed: false,
            fillSpace: true,
          );
        }),
      ),
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
    final lines = post.question.split('\n');
    final isExpanded = controller.isExpanded[index] ?? false;
    final displayText = isExpanded || lines.length <= 4
        ? post.question
        : lines.take(4).join('\n');

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: const Color.fromARGB(255, 4, 20, 29),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.buttonBg, width: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/10.jpg',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Kunal Patel',
                            style: GoogleFonts.inter(
                         
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: AppColors.nameText,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.verified,
                            size: 22,
                            color: AppColors.buttonBg,
                          ),
                        ],
                      ),
                      Text(
                        '${post.location} · ${post.createdAt.substring(0, 10)}',
                        style: GoogleFonts.inter(
                             
                              fontWeight: FontWeight.w400,
                        
                          fontSize: 14,
                          color: AppColors.buttonBg,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz, color:Colors.white),
                ],
              ),
              const SizedBox(height: 16),
              // Question text with Show More
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
                            style: GoogleFonts.inter(
                                    fontSize: 19,
                              color: AppColors.postText,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          if (lines.length > 3)
                            TextSpan(
                              text: isExpanded ? '\nShow Less' : '\nShow More',
                              style: TextStyle(
                                fontFamily: 'SFPro',
                                fontSize: 15,
                                color: AppColors.showMoreText,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    controller.toggleExpanded(index),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Post image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      post.image,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Likes / Comments / Share Row
              Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    child: Image.asset(
                      'assets/icons/fav.png',
           // optional: apply white tint
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '124 Likes', // Placeholder
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 27,
                    height: 27,
                    child: Image.asset(
                      'assets/icons/message.png',
               // optional: apply white tint
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Reply',
                    style: TextStyle(
                      color: AppColors.iconReply,
                      fontFamily: 'SFPro',
                      fontSize: 16
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.share_outlined, color: AppColors.iconShare),
                ],
              ),
              const SizedBox(height: 16),
              // Comment section (hardcoded sample)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/12.jpg',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 21, 29, 32),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tanya Dutta',
                            style: TextStyle(
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.bold,
                              color: AppColors.commentorName,
                              fontSize: 18
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "it's my dream to visit there someday!",
                            style: TextStyle(
                                          
                             fontWeight: FontWeight.w500,
                          fontFamily: 'SFPro',
                    fontSize: 16,
                              color: AppColors.commentText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Add comment input
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/1.jpg",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 16, 28, 33),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'SFPro',
                        ),
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          hintStyle: TextStyle(
                            fontFamily: 'SFPro',
                            color: AppColors.commentPlaceholder,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.buttonBg),
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
