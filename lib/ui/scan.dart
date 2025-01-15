import 'package:bdcoe/models/scanner_provider.dart';
import 'package:bdcoe/ui/loginPage.dart';
//import 'package:bdcoe/ui/signUp.dart';
//import 'package:bdcoe/ui/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class scan extends StatefulWidget {
  const scan({super.key});

  @override
  State<scan> createState() => _scanState();
}

class _scanState extends State<scan> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ScannerProvider>(context, listen: false)
          .checkAuthentication();
    });
  }

  void _showLoginAlertDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey[900], 
        title: const Text(
          'Not Logged In',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'You need to log in first to use this feature.',
          style: TextStyle(color: Colors.white70), 
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.blueAccent), 
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, 
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: const Text('Log In'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScannerProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.04),
              Padding(
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attendance',
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 33, 92, 186),
                          letterSpacing: .5,
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (provider.currentUser == null) {
                              _showLoginAlertDialog();
                            } else {
                              _showManualEntryDialog();
                            }
                          },
                          icon: Icon(
                            Icons.edit,
                            color: const Color.fromARGB(255, 33, 92, 186),
                            size: width * 0.07,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (provider.currentUser == null) {
                              _showLoginAlertDialog();
                              return;
                            } else {
                              await FirebaseAuth.instance.signOut();
                              Fluttertoast.showToast(
                                msg: "Logged out successfully!",
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                          },
                          icon: Icon(
                            Icons.logout,
                            color: const Color.fromARGB(255, 33, 92, 186),
                            size: width * 0.07,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.05),
              Padding(
                padding: EdgeInsets.only(left: width * 0.06),
                child: Text(
                  'Scan the QR code to mark attendance.',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 227, 229, 232),
                      letterSpacing: .5,
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              provider.isScanning
                  ? SizedBox(
                      height: height * 0.4,
                      width: width * 0.8,
                      child: LottieBuilder.asset(
                        "assets/scan.json",
                        repeat: true,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Container(
                      height: height * 0.45,
                      width: width * 0.8,
                      child: MobileScanner(
                        controller: MobileScannerController(
                            detectionSpeed: DetectionSpeed.noDuplicates,
                            returnImage: true),
                        onDetect: (capture) async {
                          if (provider.currentUser == null) {
                            _showLoginAlertDialog();
                            return;
                          }
                          final List<Barcode> barcodes = capture.barcodes;
                          for (final barcode in barcodes) {
                            provider.changeScanner();
                            if (barcode.rawValue != null) {
                              await provider
                                  .sendDataToApi(barcode.rawValue.toString());
                              if (provider.apiData != null) {
                                _showResponseDialog(provider.apiData!);
                              }
                            }
                          }
                        },
                      ),
                    ),
              SizedBox(height: height * 0.04),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.2, vertical: height * 0.015),
                    backgroundColor: const Color.fromARGB(255, 33, 92, 186)),
                onPressed: () {
                  if (provider.currentUser == null) {
                    _showLoginAlertDialog();
                  } else {
                    provider.changeScanner();
                  }
                },
                child: Text(
                  provider.isScanning ? 'Scan' : "Cancel",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 227, 229, 232),
                      letterSpacing: .5,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResponseDialog(String responseMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 35, 36, 36),
          title: const Text(
            'Response',
            style: TextStyle(color: Color.fromARGB(255, 17, 73, 194)),
          ),
          content: Text(
            responseMessage,
            style: const TextStyle(color: Color.fromARGB(255, 17, 73, 194)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
          title: const Row(
            children: [
              Icon(
                Icons.edit,
                color: Color.fromARGB(255, 17, 73, 194),
              ),
              SizedBox(width: 8),
              Text(
                'Manual Entry',
                style: TextStyle(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  final provider2 =
                      Provider.of<ScannerProvider>(context, listen: false);
                  Navigator.of(context).pop();
                  await provider2.sendManualDataToApi(member1, member2);
                  if (provider2.apiData != null) {
                    _showResponseDialog(provider2.apiData!);
                  }
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
}
