import 'package:flutter/material.dart';
import '../utils/size_config.dart';
import '../utils/find_tutor_components.dart';

class BookSessionPage extends StatefulWidget {
  final String tutorName;
  final String tutorImage;
  final String tutorUni;
  final double tutorStars;
  final String tutorSubject;
  final String tutorBio;
  final String id;
  const BookSessionPage({
    super.key,
    required this.tutorName,
    required this.tutorUni,
    required this.tutorImage,
    required this.tutorStars,
    required this.tutorSubject,
    required this.tutorBio,
    required this.id,
  });

  @override
  State<BookSessionPage> createState() => _BookSessionPageState();
}

class _BookSessionPageState extends State<BookSessionPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    print(arguments);
    ScreenSize().init(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/book_session_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, size: ScreenSize.horizontal! * 8),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenSize.horizontal! * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      "Book a session",
                      style: TextStyle(
                        fontSize: ScreenSize.vertical! * 4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Level subject indicator
                    Row(
                      children: [
                        Text(
                          arguments["tutorLevel"],
                          style: TextStyle(
                            fontSize: ScreenSize.vertical! * 3,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          width: ScreenSize.horizontal! * 2,
                        ),
                        Image.asset("assets/fast-forward.png", scale: 22),
                        SizedBox(
                          width: ScreenSize.horizontal! * 2,
                        ),
                        Text(
                          arguments["tutorSubject"],
                          style: TextStyle(
                            fontSize: ScreenSize.vertical! * 3,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenSize.vertical! * 6,
                    ),
                    FindTutorCard(
                      tutorName: arguments["tutorName"],
                      tutorUni: arguments["tutorUni"],
                      tutorImage: arguments["tutorImage"],
                      tutorStars: arguments["tutorStars"],
                      tutorSubject: arguments["tutorSubject"],
                      tutorBio: arguments["tutorBio"],
                      id: arguments["tutorID"],
                      tutorLevel: arguments["tutorLevel"],
                      bookTutorButton: false,
                    )
                  ],
                ),
              )

              // Tutor card

              // Calendar
            ],
          ),
        ),
      ),
    );
  }
}
