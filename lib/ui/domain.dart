import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart' show rootBundle;

class Domain extends StatefulWidget {
  const Domain({super.key});

  @override
  State<Domain> createState() => _DomainState();
}

class _DomainState extends State<Domain> {
  final List<Map<String, String>> domains = [
    {'image': 'assets/firstdomain.png', 'title': 'Big Data','description': 'assets/des1.txt' },
    {'image': 'assets/domain2.png', 'title': 'Machine Learning','description': 'assets/des2.txt'},
    {'image': 'assets/domain1.png', 'title': 'Competitive Programming','description':'assets/des3.txt'},
    {'image': 'assets/domain5.png', 'title': 'App Development','description':'assets/des4.txt'},
    {'image': 'assets/domain4.png', 'title': 'Web Development','description':'assets/des5.txt'},
    {'image': 'assets/domain3.png', 'title': 'UI/UX Designing','description':'assets/des6.txt'},


  ];
  List<String> descriptions = List.filled(6, "");

  @override
  void initState() {
    super.initState();
    loadDescriptions();
  }

  Future<void> loadDescriptions() async {
    for (int i = 0; i < domains.length; i++) {
      String description = await rootBundle.loadString(domains[i]['description']!);
      setState(() {
        descriptions[i] = description;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: SvgPicture.asset(
                'assets/logobdc.svg',
                width: 80,
                height: 80,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'BIG DATA',
                style: GoogleFonts.aBeeZee(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Centre Of Excellence',
                style: GoogleFonts.aBeeZee(
                  textStyle: const TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Decipher your Destiny',
                style: GoogleFonts.aBeeZee(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 24),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'We',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: ' Learn',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: ' | We',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' Develop',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' | We',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    TextSpan(
                      text: ' Execute',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              ),

            ),
            const SizedBox(height: 80),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '"Explore Our Domains"',
                style: GoogleFonts.aBeeZee(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),


            ListView.builder(
              shrinkWrap: true,
              physics:const NeverScrollableScrollPhysics(),

              itemCount: domains.length,
              itemBuilder: (context, index) {
                return FlipCard(
                  front:SizedBox(
                    height:200,
                    child:Card(
                  color: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        domains[index]['image']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      // Domain title
                      Text(
                        domains[index]['title']!,
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ),
                  ),
                  back: Card(
                    color: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: double.infinity, // Ensure it takes the full width
                            child: Text(
                              descriptions[index],  // Your description content
                              style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


