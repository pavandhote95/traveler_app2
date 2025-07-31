import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/constants/my_toast.dart';
import 'package:travel_app2/app/modules/home/controllers/community_controller.dart';
import 'package:travel_app2/app/widgets/custom_appbar_controller.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({Key? key}) : super(key: key);

  // Initialize controllers
  final LocationController locationController = Get.put(LocationController());
  final RxBool isToggled = false.obs; // For switch toggle state

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Avatar
        const CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(
            'https://randomuser.me/api/portraits/men/11.jpg',
          ),
        ),
        const SizedBox(width: 12),
        // Greeting and Location
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Text
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hi, Bidyawant!',
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.buttonBg,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Location Row
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.buttonBg, size: 18),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Obx(
                      () => Text(
                        locationController.currentAddress.value,              
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.openSans(
                          fontSize: 13,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Toggle Switch and Icon
        Obx(
          () => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Mode Text
              Text(
                isToggled.value ? "Traveling" : "Home",
                style: GoogleFonts.openSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isToggled.value ? AppColors.buttonBg:AppColors.titleText
                ),
              ),
              const SizedBox(width: 6),
              // Switch with custom theme
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
                  scale: 0.9,
                  child: Switch(
                    value: isToggled.value,
                 // Inside the Switch's onChanged callback in HeaderWidget
onChanged: (value) async {
  isToggled.value = value;
  final communityController = Get.find<CommunityController>();

  communityController.setTravelingMode(value); // Notify controller of mode change

  if (value) {
    // Enable travel mode
    CustomToast.showSuccessHome(context, "Traveling mode is ON");
    await locationController.getCurrentLocation();
    final city = locationController.city.value;
    if (city.isNotEmpty) {
      communityController.fetchPostsByLocation(city);
    }
  } else {
    // Disable travel mode
    CustomToast.showErrorHome(context, "Traveling mode is OFF");
    communityController.fetchPosts();
  }
},
                  ),
                ),
              ),
              const SizedBox(width: 5),
              // Telegram Icon
              Image.asset(
                'assets/icons/telegram.png',
                height: 35,
                width: 35,
                fit: BoxFit.contain,
                color: AppColors.buttonBg,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}