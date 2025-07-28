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
              AppColors.centerleft , AppColors.centerright  //// Almost black bottom
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      title: HeaderWidget(),
      toolbarHeight: 90,
      
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