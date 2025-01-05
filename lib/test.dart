
// //////////////////////////////////////////////////////////////////////////bloc
// import 'dart:convert';
// import 'package:bdcoe/bloc/team_event.dart';
// import 'package:bdcoe/bloc/team_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;

// class MemberBloc extends Bloc<MemberEvent, MemberState> {
//   MemberBloc() : super(MemberInitial()) {
//     on<FetchMembers>(_fetchMembers);
//   }

//   Future<void> _fetchMembers(
//       FetchMembers event, Emitter<MemberState> emit) async {
//     emit(MemberLoading());
//     try {
//       final response = await http.get(
//         Uri.parse('https://bdcoe-backend.vercel.app/api/v1/member'),
//       );
//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         final members = List<Map<String, dynamic>>.from(jsonResponse['data']);
//         final filteredMembers =
//             members.where((member) => member['graduation'] == 2027).toList();

//         emit(MemberLoaded(filteredMembers));
//       } else {
//         emit(MemberError('Failed to fetch members'));
//       }
//     } catch (e) {
//       print(e.toString());
//       emit(MemberError(e.toString()));
//     }
//   }
// }


// /////////////////////////////////////////////////////////////////state
// import 'package:equatable/equatable.dart';

// abstract class MemberState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class MemberInitial extends MemberState {}

// class MemberLoading extends MemberState {}

// class MemberLoaded extends MemberState {
//   final List<Map<String, dynamic>> members;

//   MemberLoaded(this.members);

//   @override
//   List<Object?> get props => [members];
// }

// class MemberError extends MemberState {
//   final String error;

//   MemberError(this.error);

//   @override
//   List<Object?> get props => [error];
// }



// //////////////////////////////////////////////////////////event
// import 'package:equatable/equatable.dart';

// abstract class MemberEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class FetchMembers extends MemberEvent {}




// /////////////////////////////////////////////////////////////////////ui
// import 'package:bdcoe/bloc/team_bloc.dart';
// import 'package:bdcoe/bloc/team_event.dart';
// import 'package:bdcoe/bloc/team_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Team extends StatefulWidget {
//   const Team({super.key});

//   @override
//   State<Team> createState() => _TeamState();
// }

// class _TeamState extends State<Team> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<MemberBloc>(context).add(FetchMembers());
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: BlocBuilder<MemberBloc, MemberState>(
//         builder: (context, state) {
//           if (state is MemberLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is MemberLoaded) {
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Number of columns
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 0.8,
//               ),
//               itemCount: state.members.length,
//               itemBuilder: (context, index) {
//                 final member = state.members[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     padding: const EdgeInsets.all(16.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           blurRadius: 5,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                       image: DecorationImage(
//                         image: AssetImage('assets/teambck.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: NetworkImage(member['imageUrl']),
//                           radius: 45,
//                         ),
//                         SizedBox(height: 10),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Text(
//                             member['fullname'] ?? 'Unknown',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         Text(
//                           member['domain'] ?? 'Unknown',
//                           style: const TextStyle(color: Colors.grey),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.person),
//                               onPressed: () {
//                                 _launchUrl(
//                                     'https://www.linkedin.com/in/${member['linkedin']}');
//                               },
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.code),
//                               onPressed: () {
//                                 _launchUrl(
//                                     'https://github.com/${member['github']}');
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is MemberError) {
//             return Center(child: Text('Error: ${state.error}'));
//           }
//           return const Center(child: Text('No data found.'));
//         },
//       ),
//     );
//   }

//   void _launchUrl(String url) async {
//     // ignore: deprecated_member_use
//     if (await canLaunch(url)) {
//       // ignore: deprecated_member_use
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dropdown_bloc.dart';
// import 'dropdown_event.dart';
// import 'dropdown_state.dart';

// class DropdownScreen extends StatelessWidget {
//   final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => DropdownBloc(),
//       child: Scaffold(
//         appBar: AppBar(title: Text('Dropdown with BLoC')),
//         body: Center(
//           child: BlocBuilder<DropdownBloc, DropdownState>(
//             builder: (context, state) {
//               return DropdownButton<String>(
//                 value: state.selectedItem,
//                 items: items.map((item) {
//                   return DropdownMenuItem<String>(
//                     value: item,
//                     child: Text(item),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   if (value != null) {
//                     context.read<DropdownBloc>().add(DropdownChanged(value));
//                   }
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
