//import 'package:bdcoe/ui/loginPage.dart';
//import 'package:bdcoe/ui/scan.dart';
//import 'package:bdcoe/ui/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerificationPage extends StatefulWidget {
  final User user;

  VerificationPage({required this.user});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late User currentUser;
  bool isVerified = false;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
    _checkEmailVerification();
  }

  Future<void> _checkEmailVerification() async {
    while (!isVerified) {
      await currentUser.reload(); // Reload user data from Firebase
      currentUser = FirebaseAuth.instance.currentUser!;
      isVerified = currentUser.emailVerified;

      if (isVerified) {
        Fluttertoast.showToast(
          msg: "Email verified! Redirecting to scan Page...",
          toastLength: Toast.LENGTH_LONG,
        );
        Navigator.pop(context);
       
        break; 
      } else {
        await Future.delayed(Duration(seconds: 3)); // Check every 3 seconds
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white), // Back arrow color
        title:const Text(
          "Verifying Email",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              "Please verify your email...",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
