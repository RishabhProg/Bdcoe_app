import 'package:bdcoe/models/nav_provider.dart';
import 'package:bdcoe/models/scanner_provider.dart';
import 'package:bdcoe/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavProvider()),
        ChangeNotifierProvider(create: (context) => ScannerProvider()),

        
      ],
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
