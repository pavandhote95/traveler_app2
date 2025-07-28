
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/constants/app_color.dart';


import '../../../constants/text_fonts.dart';

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
class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final bool _isEditing = false;
  final String _userBio =
      'Avid traveler exploring the world one city at a time. Love capturing moments and sharing stories from my journeys!';
  final int _countriesVisited = 12;
  final int _tripsTaken = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2027), // same as NotificationView
      appBar: AppBar(
        backgroundColor: const Color(0xFF232526),
        foregroundColor: AppColors.buttonBg,
        elevation: 0.5,
        title: Text(
          'Profile',
          style: KTextStyle.montSerrat(
            fs: 20,
            fw: FontWeight.bold,
            c: AppColors.buttonBg,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopHeader(),
              _buildPromoCard(),
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
      width: double.infinity,
      color: const Color(0xFF232526),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage:
            NetworkImage("https://randomuser.me/api/portraits/men/51.jpg"),
          ),
          const SizedBox(height: 12),
          Text(
            'Veeti Seppanen',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.buttonBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                // TODO: Navigate to edit profile page
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // to keep container padding consistent
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Edit Profile',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPromoCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade600, width: 0.6),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.orange.shade100.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: const Icon(Icons.campaign, color: AppColors.buttonBg, size: 28),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Promo & Update",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              const SizedBox(height: 4),
              Text("Sapendisse dictum quam non",
                  style: GoogleFonts.montserrat(
                      fontSize: 13, color: Colors.grey.shade400)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptionList() {
    final List<String> options = [
      "Change Password",
      "Invite Friends",
      "Credits & Coupons",
      "Help Center",
      "Payments",
      "Settings",
      "Newsletter"
    ];

    return Column(
      children: options.map(
            (option) => Card(
          color: const Color(0xFF2A2A2A), // Notification card background
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color:Colors.grey, width: 0.4),
              ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            title: Text(
              option,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppColors.buttonBg),
          ),
        ),
      ).toList(),
    );
  }


  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.buttonBg.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: () {
            // TODO: Handle logout logic here
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "Logout",
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

}
