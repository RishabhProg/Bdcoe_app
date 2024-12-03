// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';

// class Scan extends StatefulWidget {
//   const Scan({super.key});

//   @override
//   State<Scan> createState() => _ScanState();
// }

// class _ScanState extends State<Scan> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: height*0.05,),
//             // "Attendance" text at the top-left
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//               child: Text(
//                 'Attendance',
//                 style: GoogleFonts.robotoMono(
//                   textStyle: TextStyle(
//                     color: const Color.fromARGB(255, 33, 92, 186),
//                     fontSize: width * 0.1, // Responsive font size
//                     letterSpacing: 0.5,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.02),

//             // Subtext below "Attendance"
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: width * 0.04),
//               child: Text(
//                 'Scan the QR to mark\nattendance.',
//                 style: GoogleFonts.robotoMono(
//                   textStyle: TextStyle(
//                     color: const Color.fromARGB(255, 245, 242, 246),
//                     fontSize: width * 0.045, // Responsive font size
//                     letterSpacing: 0.1,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
            

//             // Lottie animation in the center
//             Expanded(
//               child: Center(
//                 child: SizedBox(
//                   height: height * 0.4, // Adjust size relative to screen
//                   width: width * 0.8,
//                   child: LottieBuilder.asset(
//                     "assets/scan.json",
//                     repeat: true,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),

//             // Centered Button
//             Padding(
//               padding: EdgeInsets.only(bottom: height * 0.07),
//               child: Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.2, vertical: height * 0.02),
//                     backgroundColor: Colors.blueAccent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   onPressed: () {
//                     // Button action here
//                     print('Button Pressed');
//                   },
//                   child: Text(
//                     'Mark Attendance',
//                     style: GoogleFonts.robotoMono(
//                       textStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: width * 0.045, // Responsive font size
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
