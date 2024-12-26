import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
                  'Domains',
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