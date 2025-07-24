import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/constants/app_color.dart';
import 'package:travel_app2/app/routes/app_pages.dart';
import 'package:travel_app2/app/services/api_service.dart';

void main() {
  Get.put(ApiService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.mainBg,
        textTheme: GoogleFonts.interTextTheme( // Using Inter
          ThemeData.dark().textTheme,
        ).apply(
          fontFamilyFallback: [ 'Roboto'], // fallback order
        ),
      ),
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
    );
  }
}
