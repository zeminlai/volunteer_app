import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:volunteer_app/utils/book_session_components.dart';
import '../utils/size_config.dart';
import '../utils/find_tutor_components.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookSessionPage extends StatefulWidget {
  @override
  State<BookSessionPage> createState() => _BookSessionPageState();
}

class _BookSessionPageState extends State<BookSessionPage> {
  Map<DateTime, List<Session>> bookedSessions = {};
  List<Session> _getSessionsfromDay(DateTime date) {
    return bookedSessions[date] ?? [];
  }

  DateTime selectDay = DateTime.now();

  bool checkDuplicateSessions(DateTime tempDateTime, String tutorSessionID) {
    return bookedSessions[tempDateTime]!.any((session) => session.id == tutorSessionID);
  }

  @override
  Widget build(BuildContext context) {
    final sessionsData = FirebaseFirestore.instance.collection('sessions');
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    ScreenSize().init(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/book_session_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
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
                  margin: EdgeInsets.symmetric(horizontal: ScreenSize.horizontal! * 5),
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
                        height: ScreenSize.vertical! * 5,
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
                        tutorSessionIDs: arguments["tutorSessionsIDs"],
                        bookTutorButton: false,
                      ),
                      SizedBox(
                        height: ScreenSize.vertical! * 5,
                      ),

                      StreamBuilder(
                        stream: sessionsData.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final tutorSession = snapshot.data!.docs;
                            for (int i = 0; i < arguments["tutorSessionsIDs"].length; i++) {
                              arguments["tutorSessionsIDs"][i] =
                                  arguments["tutorSessionsIDs"][i].toString().trim();

                              for (int k = 0; k < tutorSession.length; k++) {
                                if (arguments["tutorSessionsIDs"][i] == tutorSession[k].id) {
                                  DateTime tempDateTime =
                                      DateTime.parse(tutorSession[k]["dateTime"]);
                                  DateTime timeStart = DateTime.parse(tutorSession[k]["timeStart"]);
                                  DateTime timeEnd = DateTime.parse(tutorSession[k]["timeEnd"]);

                                  if (bookedSessions[tempDateTime] != null &&
                                      !checkDuplicateSessions(tempDateTime, tutorSession[k].id)) {
                                    bookedSessions[tempDateTime]!.add(
                                      Session(
                                        id: tutorSession[k].id,
                                        dateTime: tempDateTime,
                                        maxParticipants: tutorSession[k]["maxParticipants"],
                                        participants: tutorSession[k]["participants"],
                                        title: tutorSession[k]["title"],
                                        timeStart: timeStart,
                                        timeEnd: timeEnd,
                                      ),
                                    );
                                  } else if (bookedSessions[tempDateTime] == null) {
                                    bookedSessions[tempDateTime] = [
                                      Session(
                                        id: tutorSession[k].id,
                                        dateTime: tempDateTime,
                                        maxParticipants: tutorSession[k]["maxParticipants"],
                                        participants: tutorSession[k]["participants"],
                                        title: tutorSession[k]["title"],
                                        timeStart: timeStart,
                                        timeEnd: timeEnd,
                                      )
                                    ];
                                  }
                                }
                              }
                            }
                            print("bookedSessions length : ${bookedSessions.length}");

                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(ScreenSize.horizontal! * 3),
                                child: TableCalendar(
                                  availableGestures: AvailableGestures.none,
                                  focusedDay: DateTime.now(),
                                  firstDay: DateTime.utc(2023, 3, 1),
                                  lastDay: DateTime.utc(2024, 3, 1),
                                  headerStyle: const HeaderStyle(
                                      formatButtonVisible: false, titleCentered: true),
                                  selectedDayPredicate: (day) => isSameDay(day, selectDay),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      selectDay = selectedDay;
                                    });
                                  },
                                  eventLoader: _getSessionsfromDay,
                                  calendarStyle: CalendarStyle(
                                    selectedDecoration: BoxDecoration(
                                      color: Color(0xff5FC88F),
                                      shape: BoxShape.circle,
                                    ),
                                    todayDecoration: BoxDecoration(
                                      color: Color(0xff9F9DF3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SpinKitRing(
                              color: Color(0xff9F9DF3),
                              size: ScreenSize.vertical! * 10,
                            );
                          }
                        },
                      ),

                      SizedBox(
                        height: ScreenSize.vertical! * 3,
                      ),
                      ..._getSessionsfromDay(selectDay).map(
                        (Session session) => GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => PopUpBookingCard(session: session),
                          ),
                          child: AvailableSessionCard(session: session, selectDay: selectDay),
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.vertical! * 3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
