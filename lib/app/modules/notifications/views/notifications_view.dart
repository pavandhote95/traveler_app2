import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/constants/app_color.dart';


import '../controllers/notifications_controller.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2027),
      appBar: AppBar(
        backgroundColor: const Color(0xFF232526),
        foregroundColor: AppColors.buttonBg,
        elevation: 0.5,
        title: Text(
          'Notifications',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight:  FontWeight.bold,
            color: AppColors.buttonBg,
          ),
        ), 
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/search_image.png',
                  width: 180,
                  color: AppColors.buttonBg,
                ),
                const SizedBox(height: 12),
                Text(
                  "No notifications",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                color: const Color(0xFF1F1F1F),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(color:Colors.grey, width: 0.4),
                ),
                child: ListTile(
                  leading: const Icon(Icons.notifications, color: AppColors.buttonBg),
                  title: Text(
                    notification.title,
                    style: GoogleFonts.roboto(
                      
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.message,
                        style: GoogleFonts.roboto(color: Colors.grey.shade400),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.time,
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.buttonBg, size: 16),
                  onTap: () {
                    // Navigate to detailed view or perform action
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
