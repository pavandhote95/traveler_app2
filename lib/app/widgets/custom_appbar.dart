import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/constants/my_toast.dart';
import 'package:travel_app2/app/modules/home/controllers/community_controller.dart';
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
                  style:TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.buttonBg,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.location_on,
                      color: AppColors.buttonBg, size: 18),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Obx(() => Text(
                          locationController.currentAddress.value,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'SFPro',
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
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.blueGrey; // ON
            }
            return AppColors.buttonBg; // OFF
          }),
          trackColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.buttonBg;
            }
            return AppColors.buttonBg.withOpacity(0.3);
          }),
          trackOutlineColor: MaterialStateProperty.all(AppColors.buttonBg),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
      child: Transform.scale(
        scale: 1.1,
        child: Switch(
          value: isToggled.value,
          onChanged: (value) async {
            isToggled.value = value;

            final communityController = Get.find<CommunityController>();

            if (value) {
              CustomToast.showSuccessHome(context, "Traveling mode is ON");
              await locationController.getCurrentLocation();

              final city = locationController.city.value;
              if (city.isNotEmpty) {
                communityController.fetchPostsByLocation(city);
              }
            } else {
              CustomToast.showErrorHome(context, "Traveling mode is OFF");
              communityController.fetchPosts();
            }
          },
        ),
      ),
    ),
    const SizedBox(width: 10),
    Image.asset(
      'assets/icons/telegram.png', // 🧠 Replace with your image path
      height: 40,
      width: 40,
      fit: BoxFit.contain,
      color: AppColors.buttonBg,
    ),
  ],
))


      ],
    );
  }
}
