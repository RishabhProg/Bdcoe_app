import 'package:bdcoe/bloc/team_bloc.dart';
import 'package:bdcoe/firebase_options.dart';
import 'package:bdcoe/models/nav_provider.dart';
import 'package:bdcoe/models/scanner_provider.dart';
//import 'package:bdcoe/ui/signUp.dart';
import 'package:bdcoe/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MultiProvider(
      providers: [
        
        ChangeNotifierProvider(create: (context) => NavProvider()),
        ChangeNotifierProvider(create: (context) => ScannerProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
         
          BlocProvider(create: (context) => MemberBloc()),
          BlocProvider(create: (context) => DropdownBloc())
          
        ],
        child: const MyApp(),
      ),
    ),
  );
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
