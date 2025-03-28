import 'dart:convert';
import 'package:bdcoe/bloc/team_bloc.dart';
import 'package:bdcoe/bloc/team_event.dart';
import 'package:bdcoe/bloc/team_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  void initState() {
    super.initState();
    // Initial load of data from the cached or API based on year
    BlocProvider.of<MemberBloc>(context).add(FetchMembers(DateTime.now().year));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reset the dropdown value to '2nd Year' whenever the screen is reloaded
    context.read<DropdownBloc>().add(Dropdownchangedevent('4th Year'));
  }

  final List<String> items = [
    '4th Year',
    '3rd Year',
    '2nd Year',
    'Alumini',
    'Faculty'
  ];
  final Map<String, int> yearMap = {
    '4th Year': DateTime.now().year,
    '3rd Year': DateTime.now().year + 1,
    '2nd Year': DateTime.now().year + 2,
    'Alumini': 420
  };
  final Map<String, String> domain = {
    'AD': 'App Developer',
    'ML': 'Machine Learning',
    'FE': 'Frontend',
    'FS': 'Fullstack',
    'BE': 'Backend',
    'DE': 'Designer',
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.03),
            Padding(
              padding: EdgeInsets.only(left: width * 0.05),
              child: Text(
                'Our Team',
                style: GoogleFonts.aBeeZee(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 33, 92, 186),
                    letterSpacing: .5,
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            BlocBuilder<DropdownBloc, DropdownChangedstate>(
              builder: (context, state) {
                return Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.6, left: width * 0.05),
                  child: DropdownButtonFormField<String>(
                    value: state.selected_year,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                    dropdownColor: Colors.grey[850],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    items: items.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        if (value == 'Faculty') {
                          _showFacultyDialog();
                        } else {
                          context
                              .read<DropdownBloc>()
                              .add(Dropdownchangedevent(value));
                          context
                              .read<MemberBloc>()
                              .add(FetchMembers(yearMap[value]!));
                        }
                      }
                    },
                  ),
                );
              },
            ),
            SizedBox(height: height * 0.01),
            BlocBuilder<MemberBloc, MemberState>(
              builder: (context, state) {
                if (state is MemberLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MemberLoaded) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.8,
                      ),
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
                              image: const DecorationImage(
                                image: AssetImage('assets/teambck.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                     CachedNetworkImageProvider(member['imageUrl']),
                                  radius: 45,
                                ),
                                const SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    member['fullname'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  domain[member['domain']] ?? 'Unknown',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Image.asset('assets/linkedin.png',
                                          width: 32, height: 32),
                                      iconSize: 32,
                                      onPressed: () {
                                        _launchLinkedIn(
                                            'https://www.linkedin.com/in/${member['linkedin']}');
                                      },
                                    ),
                                    IconButton(
                                      icon: Image.asset('assets/github.png',
                                          width: 32, height: 32),
                                      iconSize: 32,
                                      onPressed: () {
                                        _launchGitHub(
                                            'https://github.com/${member['github']}');
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is MemberError) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return const Center(child: Text('No data found.'));
              },
            ),
          ],
        ),
      ),
    );
  }

  // void _launchUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
 

void _launchLinkedIn(String username) async {
  final linkedInAppUrl = Uri.parse("$username");
  final linkedInWebUrl = Uri.parse("$username");

  if (await canLaunchUrl(linkedInAppUrl)) {
    await launchUrl(linkedInAppUrl);
  } else {
    await launchUrl(linkedInWebUrl, mode: LaunchMode.externalApplication);
  }
}

void _launchGitHub(String username) async {
  final githubAppUrl = Uri.parse("$username");
  final githubWebUrl = Uri.parse("$username");

  if (await canLaunchUrl(githubAppUrl)) {
    await launchUrl(githubAppUrl);
  } else {
    await launchUrl(githubWebUrl, mode: LaunchMode.externalApplication);
  }
}


  void _showFacultyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Our Faculty',
            style: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(color: Colors.white)),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _facultyMember(
                  'Dr. Ruchi Gupta',
                  'https://www.akgec.ac.in/wp-content/uploads/2023/04/RUCHI-GUPTA.jpg',
                ),
                _facultyMember(
                  'Mr. Amit Sharma',
                  'https://res.cloudinary.com/dhy42cidp/image/upload/v1729435141/ytazhk1sgbv8do71fga6.jpg',
                ),
                _facultyMember(
                  'Mr. Ropak Kumar',
                  'https://ucarecdn.com/599d1a82-3ca2-4426-bd09-3d01f0625ef6/-/preview/311x376/',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _facultyMember(String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
