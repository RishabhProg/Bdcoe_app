import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailScreen extends StatelessWidget {
  final Map<String, dynamic> event;
  final String selectedImage;

  const EventDetailScreen({super.key, required this.event,required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    List<dynamic> eventPhotos = event['images'] ?? [];
    String eventImage = (eventPhotos.isNotEmpty)
        ? eventPhotos[eventPhotos.length - 1]
        : '';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          'Events',
          style:GoogleFonts.aBeeZee(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 33, 92, 186),
              letterSpacing: .5,
              fontSize: 35,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
            const SizedBox(height: 30),
            Center(
              child: eventImage.isNotEmpty
                  ? Image.network(
                eventImage,
                height: 200,
                fit: BoxFit.cover,
              )
                  : const Text(
                'No Image Available',
                style:TextStyle(color:Colors.white),
              ),
            ),
            const SizedBox(height: 35),

            Text(
              event['eventname'] ?? 'Unnamed Event',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 33, 92, 186),
              ),
            ),

            const SizedBox(height: 20),
            Text(
              event['description'] ?? 'No description available',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height:50),
            const Text(
              'Event Photos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 33, 92, 186),
              ),
            ),
            const SizedBox(height:20),

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
                    ? Image.network(
                  photo,
                  fit: BoxFit.cover,
                )
                    : const Text(
                  'Invalid Photo',
                  style: TextStyle(color: Colors.white),
                );
              },
            )
                : const Text(
              'No Photos Available',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
      backgroundColor: Colors.black,
   );
  }
}