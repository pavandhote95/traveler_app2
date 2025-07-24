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
            return const Center(child: CircularProgressIndicator(color: AppColors.buttonBg,));
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
    final displayText =
        isExpanded || lines.length <= 4 ? post.question : lines.take(4).join('\n');

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
              // Header
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        NetworkImage('https://randomuser.me/api/portraits/men/10.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Traveler',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white)),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, size: 18, color: Colors.blue),
                        ],
                      ),
                      Text('${post.location} · ${post.createdAt.substring(0, 10)}',
                          style: GoogleFonts.montserrat(
                              fontSize: 14, color: Colors.grey[500])),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz, color: Colors.white),
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
                            style: GoogleFonts.montserrat(
                                fontSize: 18, color: Colors.white),
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
                  // Post image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(post.image,
                        height: 180, width: double.infinity, fit: BoxFit.cover),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Likes / Comments / Share Row
              Row(
                children: [
                  const Icon(Icons.favorite_border, color: Colors.white),
                  const SizedBox(width: 8),
                  Text('124 Likes', // Placeholder
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
              // Comment section (hardcoded sample)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage:
                        NetworkImage('https://randomuser.me/api/portraits/men/12.jpg'),
                  ),
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
                          Text('Ravi Verma',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 6),
                          Text('I also want to go there!',
                              style: GoogleFonts.montserrat(color: Colors.white)),
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
                      backgroundImage:
                          NetworkImage("https://randomuser.me/api/portraits/men/1.jpg")),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Comment sent')));
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