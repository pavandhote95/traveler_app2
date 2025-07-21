
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1B1B1B),  Color(0xFF1B1B1B),
              Color(0xFF1B1B1B),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 1,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1B1B1B),
                    Color(0xFF1B1B1B),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            title:  HeaderWidget(),
            toolbarHeight: 90,
            bottom: TabBar(
              controller: controller.tabController,
              labelColor: Colors.white,
              dividerColor: Colors.transparent,
              unselectedLabelColor: Colors.white54,
              labelStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              indicator: const BoxDecoration(
                color: Color(0xFF2A2A2A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: "Community"),
                Tab(text: "Experts"),
              ],
            ),
          ),

          body: TabBarView(
            controller: controller.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const CommunityTab(),
              Expertstab(),
            ],
          ),


        ),
      ),
    );
  }

}
