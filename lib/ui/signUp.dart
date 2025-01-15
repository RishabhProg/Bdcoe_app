import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'verification.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  List<String> validEmails = [];

  @override
  void initState() {
    super.initState();
    _fetchValidEmails();
  }

  Future<void> _fetchValidEmails() async {
    try {
      final response = await http.get(
        Uri.parse("https://bdcoe-backend.vercel.app/api/v1/member"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List members = data['data'];
        setState(() {
          validEmails = members.map((member) => member['email'] as String).toList();
        });
      } else {
        Fluttertoast.showToast(
          msg: "Failed to fetch valid emails.",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> _signUp() async {
    final enteredEmail = _emailController.text.trim();

    if (!validEmails.contains(enteredEmail)) {
      Fluttertoast.showToast(
        msg: "This email is not authorized to sign up.",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: enteredEmail,
        password: _passwordController.text.trim(),
      );

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Fluttertoast.showToast(
          msg: "Verification email sent. Please verify your email.",
          toastLength: Toast.LENGTH_LONG,
        );

        // Navigate to VerificationPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VerificationPage(user: user)),
        );
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Error occurred!",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme:const IconThemeData(color: Colors.white), // Back arrow color
        title: const Text("Sign Up", style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text(
                "Create a new account",
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
             const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration:const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
             const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style:const TextStyle(color: Colors.white),
                decoration:const InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
             const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _signUp,
                  child:const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
             const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child:const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
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
