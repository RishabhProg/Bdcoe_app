import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animations/animations.dart';
import '../blocs/event_detail/event_detail_bloc.dart';
import '../blocs/event_detail/event_detail_event.dart';
import '../blocs/event_detail/event_detail_state.dart';
import 'eventdetail.dart';

class Events extends StatelessWidget {
  const Events({super.key});
  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => EventBloc()..add(FetchEvents()),
          child: BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              if (state is EventLoading) {
                /// 🔄 Loading with shimmer effect
                return const Center(child: CircularProgressIndicator(color: Colors.blue));
              } else if (state is EventLoaded) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 🔥 Animated Title
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 800),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, (1 - value) * -20),
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            'Events',
                            style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                                color: Color(0xFF1E90FF),
                                letterSpacing: .5,
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// 🖼️ Event Banner Image with Fade Animation
                        Center(
                        child:  LottieBuilder.asset(
                          "assets/coding.json",
                          repeat: true,
                          fit: BoxFit.contain,
                        )
                          
                        ),

                        const SizedBox(height: 20),

                        /// 🎭 Animated Description
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 800),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, (1 - value) * -20),
                                child: child,
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Key Events We Hosted:',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                'Celebrating Innovation and Collaboration',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),

                        /// 🔥 Animated Grid of Events
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // More compact layout
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: state.events.length,
                          itemBuilder: (context, index) {
                            final event = state.events[index];

                            return OpenContainer(
                              transitionType: ContainerTransitionType.fade,
                              closedColor: Colors.transparent,
                              closedElevation: 0,
                              closedBuilder: (context, action) => Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                        imageUrl: event['poster'] ?? '',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Shimmer.fromColors(
                                        baseColor: Colors.grey[800]!,
                                        highlightColor: Colors.grey[700]!,
                                       child: Container(
                                         height: 150,
                                         width: 150,
                                         color: Colors.white,
                                           ),
                                        ),
                                           errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                                        ),
                                ),
                              ),
                              openBuilder: (context, action) => EventDetailScreen(
                                event: event,
                                selectedImage: event['poster'],
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 30),

                        /// 🎟️ Register Button with Slide Animation
                        TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 700),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, (1 - value) * 20),
                                child: child,
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
      ),
    );
  }
}
