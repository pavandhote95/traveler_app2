import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
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
                  const Icon(Icons.location_on, color: Colors.tealAccent, size: 18),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'New Delhi, India',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),




        Center(
          child: Icon(
            Icons.telegram_outlined,
            size: 60,
            color: Colors.tealAccent[700],
          ),
        ),

      ],
    );
  }
}
