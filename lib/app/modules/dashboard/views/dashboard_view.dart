import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travel_app2/app/constants/app_color.dart';

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
    NotificationView(),
    UserProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const  Color.fromARGB(255, 23, 23, 23),
      body: Obx(() => _pages[controller.selectedIndex.value]),
      bottomNavigationBar:        SafeArea(
        child: Container(
      
          decoration: BoxDecoration(
            color:Color.fromARGB(255, 23, 23, 23),
      
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(0.1),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Obx(
                  () => GNav(
                selectedIndex: controller.selectedIndex.value,
                onTabChange: controller.changeTab,
                gap: 8,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                tabBorderRadius: 16,
               
                    
      
                    color: AppColors.buttonBg,
                activeColor: Colors.black,
                tabBackgroundColor:AppColors.buttonBg,
      
                tabs: const [
                  GButton(
                    icon: CupertinoIcons.house_fill,
                    text: 'Home',
                    
                  ),
                  GButton(
                    icon: CupertinoIcons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: CupertinoIcons.bell,
                    text: 'Notifications',
                  ),
                  GButton(
                    icon: CupertinoIcons.person,
                    text: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
