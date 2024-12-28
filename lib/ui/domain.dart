import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Domain extends StatefulWidget {
  const Domain({super.key});

  @override
  State<Domain> createState() => _DomainState();
}

class _DomainState extends State<Domain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
                  'Domain',
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