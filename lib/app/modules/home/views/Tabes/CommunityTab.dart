import 'package:cached_network_image/cached_network_image.dart';
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

class _CommunityTabState extends State<CommunityTab> with WidgetsBindingObserver {
  final controller = Get.put(CommunityController());
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != isKeyboardVisible) {
      setState(() {
        isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      body: SafeArea(
        child: Obx(() {
          if (controller.filteredPosts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.buttonBg),
            );
          }

          return Stack(
            children: [
              SwipeCards(
                matchEngine: controller.matchEngine,
                itemBuilder: (context, index) {
                  if (controller.filteredPosts.isEmpty) return const SizedBox();
                  final postIndex = index % controller.filteredPosts.length;
                  return _buildPostCard(controller.filteredPosts[postIndex], postIndex);
                },
                onStackFinished: () {
                  controller.reset();
                },
                upSwipeAllowed: false,
                fillSpace: true,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPostCard(PostModel post, int index) {
    final lines = post.question.split('\n');
    final isExpanded = controller.isExpanded[index] ?? false;
    final maxline = 3;
    final displayText = isExpanded || lines.length <= 4
        ? post.question
        : lines.take(4).join('\n');

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        color: AppColors.cardBg,
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
                      backgroundImage: CachedNetworkImageProvider(
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
                              style: GoogleFonts.openSans(
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
                    const Icon(Icons.more_horiz, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 16),

                // Question
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayText,
                      maxLines: isExpanded ? 5 : maxline,
                      overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        fontSize: 19,
                        color: AppColors.postText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.toggleExpanded(index);
                        });
                      },
                      child: Text(
                        isExpanded ? 'Show Less' : 'Show More',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: AppColors.showMoreText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    post.image,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 16),

                // Likes/Reply/Share
                Row(
                  children: [
                    Image.asset('assets/icons/fav.png', width: 27, height: 27),
                    const SizedBox(width: 8),
                    const Text('124 Likes',
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                    const SizedBox(width: 20),
                    Image.asset('assets/icons/message.png', width: 27, height: 27),
                    const SizedBox(width: 8),
                    const Text('Reply',
                        style: TextStyle(
                          color: AppColors.iconReply,
                          fontFamily: 'SFPro',
                          fontSize: 16,
                        )),
                    const Spacer(),
                    const Icon(Icons.share_outlined, color: AppColors.iconShare),
                  ],
                ),
                const SizedBox(height: 16),

                // Hardcoded comment
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
                          color: const Color.fromARGB(255, 21, 29, 32),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Tanya Dutta',
                              style: TextStyle(
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.bold,
                                color: AppColors.commentorName,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 6),
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

                // Add Comment
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage("https://randomuser.me/api/portraits/men/1.jpg"),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 16, 28, 33),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const TextField(
                          style: TextStyle(
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
      ),
    );
  }
}
