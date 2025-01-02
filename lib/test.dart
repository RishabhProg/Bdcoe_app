import 'package:bdcoe/bloc/team_bloc.dart';
import 'package:bdcoe/bloc/team_event.dart';
import 'package:bdcoe/bloc/team_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  @override
  Widget build(BuildContext context) {
    final memberBloc = BlocProvider.of<MemberBloc>(context);
    memberBloc.add(FetchMembers());

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MemberBloc, MemberState>(
        builder: (context, state) {
          if (state is MemberLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MemberLoaded) {
            return ListView.builder(
              itemCount: state.members.length,
              itemBuilder: (context, index) {
                final member = state.members[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(member['imageUrl']),
                          radius: 30,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member['fullname'] ?? 'Unknown',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                member['domain'] ?? 'Unknown',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.person),
                          onPressed: () {
                            _launchUrl(
                                'https://www.linkedin.com/in/${member['linkedin']}');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.code),
                          onPressed: () {
                            _launchUrl(
                                'https://github.com/${member['github']}');
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is MemberError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No data found.'));
        },
      ),
    );
  }

  void _launchUrl(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
