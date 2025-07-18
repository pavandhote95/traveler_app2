import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/text_fonts.dart';
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
        foregroundColor: Colors.tealAccent,
        elevation: 0.5,
        title: Text(
          'Notifications',
          style: KTextStyle.montSerrat(
            fs: 20,
            fw: FontWeight.bold,
            c: Colors.tealAccent,
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
                  color: Colors.tealAccent,
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
                  leading: const Icon(Icons.notifications, color: Colors.tealAccent),
                  title: Text(
                    notification.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.message,
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.time,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.tealAccent, size: 16),
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
