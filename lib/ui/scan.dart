import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

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

  void _showScannedDataDialog(String scannedData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 35, 36, 36),
          title: Text('Scanned Data',style: TextStyle(color: const Color.fromARGB(255, 17, 73, 194)),),
          content: Text(scannedData,style: TextStyle(color: const Color.fromARGB(255, 17, 73, 194)),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isScanning = false; // Revert back to animation
                });
              },
              child: Text('OK',style: TextStyle(color: const Color.fromARGB(255, 253, 254, 255)),),
            ),
          ],
        );
      },
    );
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
              child: Text(
                'Attendance',
                style: GoogleFonts.robotoMono(
                  textStyle: TextStyle(
                    color: const Color.fromARGB(255, 33, 92, 186),
                    fontSize: width * 0.1, 
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
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

            // Centered Button
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
                        fontSize: width * 0.045, // Responsive font size
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
        isScanning = false; // Pause the scanner
      });
      controller.pauseCamera(); // Pause the camera
      _showScannedDataDialog(scanData.code!); // Show dialog with scanned data
    });
  }
}
