import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/constants/my_toast.dart';
import 'package:travel_app2/app/widgets/custom_appbar_controller.dart';


class HeaderWidget extends StatelessWidget {
  HeaderWidget({super.key});
  final locationController = Get.put(LocationController());
  final RxBool isToggled = false.obs;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 26,
          backgroundImage:
              NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi, Bidyawant!',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.location_on,
                      color: Colors.tealAccent, size: 18),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Obx(() => Text(
                          locationController.currentAddress.value,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey[400],
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
Obx(() => Row(
  children: [
    Switch(
      value: isToggled.value,
      onChanged: (value) {
        isToggled.value = value;

        if (value) {
          // ✅ Show custom success toast
          CustomToast.showSuccessHome(context, "Traveling mode is ON");
          locationController.getCurrentLocation();
        } else {
          // ❌ Show custom error toast
          CustomToast.showErrorHome(context, "Traveling mode is OFF");
        }
      },
      activeColor: Colors.tealAccent,
    ),
    const SizedBox(width: 10),
    Icon(
      Icons.telegram_outlined,
      size: 60,
      color: Colors.tealAccent[700],
    ),
  ],
))



      ],
    );
  }
}
