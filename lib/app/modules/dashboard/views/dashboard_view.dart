import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/modules/home/views/Tabes/ExpertsTab.dart';
import '../../community_search/views/community_search_view.dart';
import '../../home/views/home_view.dart';
import '../../notifications/views/notifications_view.dart';
import '../../user_profile/views/user_profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({super.key});

  final List<Widget> _pages = [
    HomeView(),
    CommunitySearchView(),
    Expertstab(),
    NotificationView(),
    UserProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 37, 47),
      body: Obx(() => _pages[controller.selectedIndex.value]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () => controller.changeTab(2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
            
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.buttonBg,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.star_fill,
                color: Colors.black,
                size: 28,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Expert',
              style: TextStyle(
                color: AppColors.buttonBg,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
     bottomNavigationBar: Obx(() => SafeArea(
       child: SizedBox(
        height: 65,
         child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 20,
          color: const Color.fromARGB(255, 3, 21, 26),
          child: SizedBox(
            height: 50, // Reduced height from 60 or 70 to 50
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabIcon(CupertinoIcons.house_fill, 0),
                _buildTabIcon(CupertinoIcons.search, 1),
                const SizedBox(width: 48), // Space for FAB
                _buildTabIcon(CupertinoIcons.bell, 3),
                _buildTabIcon(CupertinoIcons.person, 4),
              ],
            ),
          ),
             ),
       ),
     )),

   
    );
  }

  Widget _buildTabIcon(IconData icon, int index) {
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Icon(
        icon,
        color: controller.selectedIndex.value == index
            ? AppColors.buttonBg
            : Colors.white.withOpacity(0.5),
        size: 28,
      ),
    );
  }
}
