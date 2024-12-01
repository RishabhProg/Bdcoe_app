import 'package:bdcoe/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
 
  @override
  void initState() {
    super.initState();

    // Navigate to the next screen after a delay
    Future.delayed(const Duration(seconds: 5), () {
      // Replace with your navigation logic
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logobdc.svg', // Path to your SVG file
                width: 100,
                height: 100,
                // Optional: Tint color
              ),
              const SizedBox(height: 20),
              Text(
                  'BDCOE',
                  style: GoogleFonts.aBeeZee(
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 245, 242, 246),
            letterSpacing: .5,
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
                  ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}

