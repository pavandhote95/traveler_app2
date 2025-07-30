import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/constants/app_color.dart';

import '../../../constants/text_fonts.dart';
import '../controllers/notifications_controller.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});
  final NotificationController controller = Get.put(NotificationController());

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.mainBg,
    appBar: AppBar(
      backgroundColor: AppColors.appbar,
      foregroundColor: Colors.white,
      elevation: 4,
      title: Text(
        'Notifications',
        style: KTextStyle.montSerrat(
          fs: 20,
          fw: FontWeight.bold,
          c: Colors.white,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(12),
        child: SizedBox(height: 12), // 👈 space below AppBar
      ),
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
                color: Colors.white24,
              ),
              const SizedBox(height: 12),
              Text(
                "No notifications",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(top:16),
        child: ListView.separated(
          itemCount: controller.notifications.length,
          separatorBuilder: (_, __) => const Divider(
            color: Colors.white12,
            thickness: 0.2,
            indent: 72,
          ),
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white10,
                    child: Icon(Icons.notifications_none, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: notification.title,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: ' ${notification.message}',
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification.time,
                          style: GoogleFonts.montserrat(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.more_vert, color: Colors.white24, size: 18),
                ],
              ),
            );
          },
        ),
      );
    }),
  );
}
}