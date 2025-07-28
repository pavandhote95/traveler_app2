
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/modules/home/controllers/home_controller.dart';
import '../../../widgets/custom_appbar.dart';
import 'Tabes/CommunityTab.dart';
import 'Tabes/ExpertsTab.dart';

class HomeView extends GetView<HomeController> {
 HomeController controller = Get.put(HomeController());
  HomeView({super.key});
  @override
  Widget build(BuildContext context) {

 return DefaultTabController(
  length: 2,
  child: Scaffold(
    backgroundColor: AppColors.mainBg,
    appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.mainBg,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
            // Top (bluish navy)
               Color.fromARGB(255, 8, 37, 47),
                 Color(0xFF0D192F),  //// Almost black bottom
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      title: HeaderWidget(),
      toolbarHeight: 90,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
              Color.fromARGB(255, 8, 37, 47),// Top (bluish navy)
                  Color(0xFF0A1323), // Bottom
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: TabBar(
              controller: controller.tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Color.fromARGB(255, 121, 141, 158),
              dividerColor: Colors.transparent,
              labelStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              indicator: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 18, 61, 78), // Start of selected tab
                    Color.fromARGB(255, 8, 37, 47),  // End of selected tab
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: "Community"),
                Tab(text: "Experts"),
              ],
            ),
          ),
        ),
      ),
    ),

        body: TabBarView(
          controller: controller.tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
             CommunityTab(), 
               
            Expertstab(),
          ],
        ),
      
      
      ),
    );
  }

}
