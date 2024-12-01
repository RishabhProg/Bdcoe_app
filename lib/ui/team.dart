import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:Text(
                  'Team',
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