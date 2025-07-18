import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_color.dart';
import '../../../constants/text_fonts.dart';
import '../controllers/community_search_controller.dart';

class CommunitySearchView extends GetView<CommunitySearchController> {
  @override
  final CommunitySearchController controller = Get.put(CommunitySearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2027), // Match dashboard background
      appBar: AppBar(
        backgroundColor: const Color(0xFF232526),
        foregroundColor: Colors.tealAccent,
        elevation: 0.5,
        title: Text(
          'Explore Communities',
          style: KTextStyle.montSerrat(
            fs: 20,
            fw: FontWeight.bold,
            c: Colors.tealAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextFormField(
                controller: controller.searchController,
                onChanged: controller.onSearchChanged,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Search destinations or interests...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: const Icon(CupertinoIcons.search, color: Colors.tealAccent),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                  filled: true,
                  fillColor: const Color(0xFF1C1C1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade600), // Default border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 0.1),
                  ),
                ),

              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (controller.filteredCommunities.isEmpty) {
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
                        "No results found",
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.filteredCommunities.length,
                itemBuilder: (context, index) {
                  final community = controller.filteredCommunities[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Card(
                      color: const Color(0xFF1F1F1F),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(color:Colors.grey, width: 0.3),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/travel_icon.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(
                          community.name,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          community.description,
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.tealAccent, size: 16),
                        onTap: () {
                          // Navigate to community details (optional)
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
