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
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Scan extends StatefulWidget {
//   const Scan({super.key});

//   @override
//   State<Scan> createState() => _ScanState();
// }

// class _ScanState extends State<Scan> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   bool isScanning = false;

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   void toggleScanner() {
//     setState(() {
//       isScanning = !isScanning;
//     });
//   }

//   void _showResponseDialog(String responseMessage) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: const Color.fromARGB(255, 35, 36, 36),
//           title: Text(
//             'API Response',
//             style: const TextStyle(color: Color.fromARGB(255, 17, 73, 194)),
//           ),
//           content: Text(
//             responseMessage,
//             style: const TextStyle(color: Color.fromARGB(255, 17, 73, 194)),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 setState(() {
//                   isScanning = false;
//                 });
//               },
//               child: const Text(
//                 'OK',
//                 style: TextStyle(color: Color.fromARGB(255, 253, 254, 255)),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _sendDataToApi(String scannedData) async {
//     final url = Uri.parse('https://bdcoe-mail-service.vercel.app/qr/verify'); // Replace with your API endpoint

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'encrypted': scannedData,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(response.body);
//         _showResponseDialog(responseBody['msg']);
//       } else {
//         _showResponseDialog(
//             'Failed to mark attendance. Please try again later.');
//       }
//     } catch (e) {
//       _showResponseDialog('An error occurred: $e');
//     }
//   }

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
//             SizedBox(height: height * 0.05),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//               child: Text(
//                 'Attendance',
//                 style: GoogleFonts.robotoMono(
//                   textStyle: TextStyle(
//                     color: const Color.fromARGB(255, 33, 92, 186),
//                     fontSize: width * 0.1,
//                     letterSpacing: 0.5,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: height * 0.02),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: width * 0.04),
//               child: Text(
//                 'Scan the QR to mark\nattendance.',
//                 style: GoogleFonts.robotoMono(
//                   textStyle: TextStyle(
//                     color: const Color.fromARGB(255, 245, 242, 246),
//                     fontSize: width * 0.045,
//                     letterSpacing: 0.1,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Center(
//                 child: isScanning
//                     ? QRView(
//                         key: qrKey,
//                         onQRViewCreated: _onQRViewCreated,
//                       )
//                     : SizedBox(
//                         height: height * 0.4,
//                         width: width * 0.8,
//                         child: LottieBuilder.asset(
//                           "assets/scan.json",
//                           repeat: true,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//               ),
//             ),
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
//                   onPressed: toggleScanner,
//                   child: Text(
//                     isScanning ? 'Cancel' : 'Mark Attendance',
//                     style: GoogleFonts.robotoMono(
//                       textStyle: TextStyle(
//                         color: Colors.white,
//                         fontSize: width * 0.045,
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

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         isScanning = false;
//       });
//       controller.pauseCamera();
//       _sendDataToApi(scanData.code!);
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanning = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void toggleScanner() {
    setState(() {
      isScanning = !isScanning;
    });
  }

  void _showResponseDialog(String responseMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 35, 36, 36),
          title: Text(
            'Response',
            style: const TextStyle(color: Color.fromARGB(255, 17, 73, 194)),
          ),
          content: Text(
            responseMessage,
            style: const TextStyle(color: Color.fromARGB(255, 17, 73, 194)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isScanning = false;
                });
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color.fromARGB(255, 253, 254, 255)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendDataToApi(String scannedData) async {
    final url = Uri.parse('https://bdcoe-mail-service.vercel.app/qr/verify');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'encrypted': scannedData,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        _showResponseDialog(responseBody['msg']);
      } else {
        _showResponseDialog(
            'Failed to mark attendance. Please try again later.');
      }
    } catch (e) {
      _showResponseDialog('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Attendance',
                    style: GoogleFonts.robotoMono(
                      textStyle: TextStyle(
                        color: const Color.fromARGB(255, 33, 92, 186),
                        fontSize: width * 0.08,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: const Color.fromARGB(255, 33, 92, 186),
                      size: width * 0.07,
                    ),
                    onPressed: () {
                      _showManualEntryDialog();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Text(
                'Scan the QR to mark\nattendance.',
                style: GoogleFonts.robotoMono(
                  textStyle: TextStyle(
                    color: const Color.fromARGB(255, 245, 242, 246),
                    fontSize: width * 0.045,
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: isScanning
                    ? QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      )
                    : SizedBox(
                        height: height * 0.4,
                        width: width * 0.8,
                        child: LottieBuilder.asset(
                          "assets/scan.json",
                          repeat: true,
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.07),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.2, vertical: height * 0.02),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: toggleScanner,
                  child: Text(
                    isScanning ? 'Cancel' : 'Mark Attendance',
                    style: GoogleFonts.robotoMono(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        isScanning = false;
      });
      controller.pauseCamera();
      _sendDataToApi(scanData.code!);
    });
  }

 void _showManualEntryDialog() {
  showDialog(
    context: context,
    builder: (context) {
      String member1 = '';
      String member2 = '';

      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(
              Icons.edit,
              color: const Color.fromARGB(255, 17, 73, 194),
            ),
            SizedBox(width: 8),
            Text(
              'Manual Entry',
              style: const TextStyle(
                color: Color.fromARGB(255, 17, 73, 194),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Member 1',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                member1 = value;
              },
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Member 2',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                member2 = value;
              },
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 17, 73, 194),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _sendManualDataToApi(member1, member2);
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}


  Future<void> _sendManualDataToApi(String member1, String member2) async {
    final url = Uri.parse('https://bdcoe-mail-service.vercel.app/qr/manualVerify');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'member1studentNo': member1,
          'member2studentNo': member2,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        _showResponseDialog(responseBody['msg']);
      } else {
        _showResponseDialog('Failed to submit. Please try again later.');
      }
    } catch (e) {
      _showResponseDialog('An error occurred: $e');
    }
  }
}
