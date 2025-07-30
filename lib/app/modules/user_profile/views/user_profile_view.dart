import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/constants/custom_button.dart';
import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  UserProfileView({super.key});

  final UserProfileController controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      appBar: AppBar(
        backgroundColor: AppColors.appbar,
        elevation: 0,
        title: Text(
          "My Profile",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeader(),
              _buildStatsCard(),
              _buildPromoCard(),
              const SizedBox(height: 8),
              _buildProfileOptionList(),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('assets/profile.jpg'),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Pavan!",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Traveler",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.mainBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.buttonBg, width: 0.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonBg,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem("Posts", controller.totalPosts.value),
              _buildStatItem("Answers", controller.totalAnswers.value),
              _buildStatItem(
                  "Points",
                  (controller.totalPosts.value * 50) +
                      (controller.totalAnswers.value * 10)),
            ],
          )),
    );
  }

  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        Text(
          "$value",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.card_giftcard_rounded, color: Colors.redAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Get rewards by completing your travel profile.",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptionList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.mainBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildOptionTile(Icons.person, "Edit Profile", () {}),
          _buildDivider(),
          _buildOptionTile(Icons.settings, "Settings", () {}),
          _buildDivider(),
          _buildOptionTile(Icons.verified_user, "My Badges", () {}),
          _buildDivider(),
          _buildOptionTile(Icons.help_outline, "Help & Support", () {}),
        ],
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: Colors.grey, thickness: 0.3),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SizedBox(
        width: double.infinity,
        child: CustomButton(
        isLoading: controller.isLoading,
        onPressed: controller.logoutUser,
        text: 'Logout',

        textColor: Colors.white,
      ),
      )
    );
  }
}
