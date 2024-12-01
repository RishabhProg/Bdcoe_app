import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Achievement extends StatefulWidget {
  const Achievement({super.key});

  @override
  State<Achievement> createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:Text(
                  'Achievement',
                  style: GoogleFonts.aBeeZee(
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 245, 242, 246),
            letterSpacing: .5,
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
                  ),
            ),
      ),
    );
  }
}