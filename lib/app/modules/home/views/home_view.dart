import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:travel_app2/app/modules/home/views/Tabes/CommunityTab.dart';
import 'package:travel_app2/app/widgets/custom_appbar.dart';

class HomeView extends GetView<DashboardController> {
  final DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081B22),
appBar: PreferredSize(
  preferredSize: Size.fromHeight(80),
  child: Obx(() {
    return dashboardController.showSearchBar.value
        ? AppBar(
            backgroundColor: AppColors.centerright,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search posts, places...',
                  filled: true,
                  fillColor: AppColors.cardBg,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      dashboardController.showSearchBar.value = false;
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          )
        : AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.mainBg,
            elevation: 5,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.centerleft,
                    AppColors.centerright,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            title: HeaderWidget(),
            toolbarHeight: 110,
          );
  }),
),

     
      body: SafeArea(
        child: CommunityTab(),
      ),
    );
  }
}
