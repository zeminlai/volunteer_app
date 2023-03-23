import 'package:flutter/material.dart';
import '../models/session.dart';
import '../utils/size_config.dart';
import 'package:intl/intl.dart';

class PopUpBookingCard extends StatefulWidget {
  final Session session;

  const PopUpBookingCard({super.key, required this.session});

  @override
  State<PopUpBookingCard> createState() => _PopUpBookingCardState();
}

class _PopUpBookingCardState extends State<PopUpBookingCard> {
  @override
  Widget build(BuildContext context) {
    final timeStart = DateFormat("h:mma").format(widget.session.timeStart);
    final timeEnd = DateFormat("h:mma").format(widget.session.timeEnd);
    return AlertDialog(
      title: Text(widget.session.title),
      content: Column(
        children: [
          Text("${timeStart} - ${timeEnd}"),
          Text(
              "Participants : ${widget.session.participants.length} / ${widget.session.maxParticipants}"),
          Text("Session ID : ${widget.session.id}"),
        ],
      ),
    );
  }
}

class AvailableSessionCard extends StatefulWidget {
  final String tutorName;
  final Session session;
  final DateTime selectDay;
  const AvailableSessionCard(
      {super.key, required this.session, required this.selectDay, required this.tutorName});

  @override
  State<AvailableSessionCard> createState() => AvailableSessionCardState();
}

class AvailableSessionCardState extends State<AvailableSessionCard> {
  @override
  Widget build(BuildContext context) {
    final timeStart = DateFormat("h:mma").format(widget.session.timeStart);
    final timeEnd = DateFormat("h:mma").format(widget.session.timeEnd);
    ScreenSize().init(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: EdgeInsets.fromLTRB(0, 0, 0, ScreenSize.vertical! * 2),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.session.title,
              style: TextStyle(fontSize: ScreenSize.horizontal! * 4.3),
            ),
            subtitle: Text("by ${widget.tutorName}"),
            trailing: Text("${timeStart} - ${timeEnd}"),
          ),
        ],
      ),
    );
  }
}
