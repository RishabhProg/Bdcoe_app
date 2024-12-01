import 'package:bdcoe/models/nav_provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: provider.screen[provider.index],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor:
            Colors.transparent, // Set to transparent to match container
        color: Colors.white,
        buttonBackgroundColor: const Color.fromARGB(255, 238, 240, 243),
        // Set height for the navigation bar itself
        items: provider.items,
        onTap: (index) {
          provider.getIndex(index);
          // Handle navigation or actions here
          
        },
      ),
    );
  }
}
