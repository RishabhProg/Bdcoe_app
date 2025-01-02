import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/event_detail/event_detail_bloc.dart';
import '../blocs/event_detail/event_detail_event.dart';
import '../blocs/event_detail/event_detail_state.dart';
import 'package:bdcoe/ui/eventdetail.dart';
class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => EventBloc()..add(FetchEvents()),
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EventLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Events', // Title text
                        style:GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 33, 92, 186),
                          letterSpacing: .5,
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                      const SizedBox(height: 16),

                      // Display image from assets
                      Center(
                        child: Image.asset(
                          width: double.infinity,
                          'assets/eventpage.png',
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Key Events We Hosted:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const Text(
                        'Celebrating Innovation and',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const Text(
                        'Collaboration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        itemCount: state.events.length,
                        itemBuilder: (context, index) {
                          final event = state.events[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:(context) => EventDetailScreen(
                                    event:event,
                                    selectedImage: event['poster'],
                                  ),
                                ),
                              );
                            },
                          child: Card(
                            child: Image.network(
                              event['poster'] ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (state is EventError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No events available',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}