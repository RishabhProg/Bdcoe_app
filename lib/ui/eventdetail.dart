import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailScreen extends StatelessWidget {
  final Map<String, dynamic> event;
  final String selectedImage;

  const EventDetailScreen({super.key, required this.event, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    List<dynamic> eventPhotos = event['images'] ?? [];
    String eventImage = (eventPhotos.isNotEmpty) ? eventPhotos.last : '';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// 🌟 Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Color(0xFF1A1A2E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔥 Event Title
                    Text(
                      'Events',
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// 🎭 Event Image with Hero Animation
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: eventImage.isNotEmpty
                            ? Hero(
                                tag: eventImage, // Animation tag
                                child: CachedNetworkImage(
                                 imageUrl:  eventImage,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Text(
                                'No Image Available',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// 🎤 Event Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🎉 Event Name
                          Text(
                            event['eventname'] ?? 'Unnamed Event',
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),

                          /// 📜 Event Description
                          Text(
                            event['description'] ?? 'No description available',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// ✨ Divider with Styling
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.white24,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Event Photos',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.white24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// 📸 Event Photos Grid
                    eventPhotos.isNotEmpty && eventPhotos.any((photo) => photo != null && photo.isNotEmpty)
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1,
                            ),
                            itemCount: eventPhotos.length,
                            itemBuilder: (context, index) {
                              final photo = eventPhotos[index];
                              return photo != null && photo.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                       imageUrl:  photo,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Text(
                                      'Invalid Photo',
                                      style: TextStyle(color: Colors.white),
                                    );
                            },
                          )
                        : const Center(
                            child: Text(
                              'No Photos Available',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                    const SizedBox(height: 40),

                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
