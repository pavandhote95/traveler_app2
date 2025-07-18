import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../ExpertProfilePage.dart';

class Expertstab extends StatelessWidget {
  const Expertstab({super.key});

  final List<Map<String, dynamic>> _experts = const [

    {
      'name': 'Aditi Desai',
      'image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200',
      'locationExpertise': 'Jaipur, Rajasthan',
      'title': 'Heritage Site Guide',
      'rating': 4.7,
      'ratingsCount': 124,
      'totalTravelers': 210,
      'itinerary': 'Day 1: Amber Fort, Day 2: Hawa Mahal',
      'languages': ['Hindi', 'English'],
    },
    {
      'name': 'Drishti Patel',
      'image': 'https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=200',
      'locationExpertise': 'Rann of Kutch',
      'title': 'Cultural & Wildlife Expert',
      'rating': 4.8,
      'ratingsCount': 212,
      'totalTravelers': 340,
      'itinerary': 'Day 1: White Desert, Day 2: Kala Dungar',
      'languages': ['Gujarati', 'English'],
    },
    {
      'name': 'Ankit Sharma',
      'image': 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=200',
      'locationExpertise': 'Varanasi, UP',
      'title': 'Religious & Spiritual Guide',
      'rating': 4.6,
      'ratingsCount': 98,
      'totalTravelers': 175,
      'itinerary': 'Day 1: Ganga Aarti, Day 2: Kashi Vishwanath Temple',
      'languages': ['Hindi', 'English', 'Sanskrit'],
    },
    {
      'name': 'Riya Nair',
      'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200',
      'locationExpertise': 'Alleppey, Kerala',
      'title': 'Backwater & Ayurveda Expert',
      'rating': 4.8,
      'ratingsCount': 143,
      'totalTravelers': 260,
      'itinerary': 'Day 1: Houseboat ride, Day 2: Ayurvedic spa tour',
      'languages': ['Malayalam', 'English', 'Hindi'],
    },
    {
      'name': 'Siddharth Rao',
      'image': 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=200',
      'locationExpertise': 'Goa Beaches',
      'title': 'Beach & Party Culture Guide',
      'rating': 4.9,
      'ratingsCount': 230,
      'totalTravelers': 400,
      'itinerary': 'Day 1: Baga Beach, Day 2: Cruise party & markets',
      'languages': ['Konkani', 'English', 'Hindi'],
    },
    {
      'name': 'Meera Banerjee',
      'image': 'https://images.unsplash.com/photo-1552058544-f2b08422138a?w=200',
      'locationExpertise': 'Sundarbans, West Bengal',
      'title': 'Mangrove & Wildlife Specialist',
      'rating': 4.6,
      'ratingsCount': 77,
      'totalTravelers': 195,
      'itinerary': 'Day 1: Jungle Safari, Day 2: River Boat Cruise',
      'languages': ['Bengali', 'English'],
    },
    {
      'name': 'Arjun Thapa',
      'image': 'https://images.unsplash.com/photo-1507537297725-24a1c029d3ca?w=200',
      'locationExpertise': 'Leh-Ladakh',
      'title': 'Adventure & Trekking Expert',
      'rating': 4.8,
      'ratingsCount': 156,
      'totalTravelers': 300,
      'itinerary': 'Day 1: Pangong Lake, Day 2: Nubra Valley trekking',
      'languages': ['Hindi', 'Ladakhi', 'English'],
    },
    {
      'name': 'Tanya Chauhan',
      'image': 'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?w=200',
      'locationExpertise': 'Manali, Himachal Pradesh',
      'title': 'Mountain & Snow Activity Guide',
      'rating': 4.7,
      'ratingsCount': 110,
      'totalTravelers': 245,
      'itinerary': 'Day 1: Solang Valley, Day 2: Rohtang Pass',
      'languages': ['Hindi', 'English'],
    },
    {
      'name': 'Ravindra Joshi',
      'image': 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=200',
      'locationExpertise': 'Udaipur, Rajasthan',
      'title': 'Royal Heritage & Palace Guide',
      'rating': 4.7,
      'ratingsCount': 103,
      'totalTravelers': 270,
      'itinerary': 'Day 1: City Palace, Day 2: Lake Pichola Boat Ride',
      'languages': ['Hindi', 'Marwari', 'English'],
    },

  ];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        automaticallyImplyLeading: false,
        title: Text(
          'Indian Travel Experts',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _experts.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final expert = _experts[index];

          return GestureDetector(
            onTap: () {
              Get.to(() => ExpertProfilePage(
                expertImage: expert['image'],
                expertName: expert['name'],
                expertTitle: expert['title'],
                locationExpertise: expert['locationExpertise'],
                rating: expert['rating'],
                ratingsCount: expert['ratingsCount'],
                totalTravelers: expert['totalTravelers'],
                itinerary: expert['itinerary'],
                languages: expert['languages'],
              ));
            },
            // Inside ListView.builder > itemBuilder:
            child: Card(
              color: const Color(0xFF2A2A2A),
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(expert['image']),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expert['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            expert['title'],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            'Expert in ${expert['locationExpertise']}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white54,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${expert['rating']}',
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${expert['ratingsCount']})',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                expert['languages'].join(', '),
                                style: GoogleFonts.poppins(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          // 🚫 Removed itinerary row from here
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.tealAccent, size: 20),
                  ],
                ),
              ),
            ),

          );
        },
      ),
    );
  }


}
