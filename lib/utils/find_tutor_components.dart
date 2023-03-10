import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunteer_app/utils/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

// Subject dropdown menu
class LevelDropdown extends StatefulWidget {
  List<String> level;
  String dropdownValue;
  final Function(String) onLevelChanged;

  LevelDropdown(
      {super.key,
      required this.level,
      required this.dropdownValue,
      required this.onLevelChanged});

  @override
  State<LevelDropdown> createState() => Level_DropdownState();
}

class Level_DropdownState extends State<LevelDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                color: Color.fromARGB(155, 255, 255, 255), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                color: Color.fromARGB(1, 255, 255, 255), width: 2),
          ),
          filled: true,
          fillColor: const Color.fromARGB(155, 255, 255, 255),
          contentPadding: const EdgeInsets.all(10)),
      isExpanded: true,
      value: widget.dropdownValue,
      items: widget.level.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        widget.onLevelChanged(value!);
      },
    );
  }
}

// Subject selection
class SubjectSelection extends StatelessWidget {
  final List subjects;
  final String subjectSelected;
  final Function(String) onChanged;
  SubjectSelection(
      {super.key,
      required this.subjects,
      required this.subjectSelected,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Container(
      width: ScreenSize.horizontal! * 100,
      height: ScreenSize.vertical! * 5,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: subjects.map(
          (value) {
            return TextButton(
              onPressed: () {
                onChanged(value);
              },
              child: (subjectSelected == value)
                  ? Text(
                      value,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenSize.vertical! * 2),
                    )
                  : Text(
                      value,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenSize.vertical! * 2),
                    ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class FindTutorCard extends StatelessWidget {
  final String tutorName;
  final String tutorImage;
  final String tutorUni;
  final double tutorStars;

  const FindTutorCard({
    super.key,
    required this.tutorName,
    required this.tutorUni,
    required this.tutorImage,
    required this.tutorStars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
          leading: CircleAvatar(
            foregroundImage: NetworkImage(tutorImage),
            radius: ScreenSize.vertical! * 3,
          ),
          title: Text(tutorName),
          subtitle: Text(tutorUni),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$tutorStars"),
              SizedBox(
                width: ScreenSize.horizontal! * 1,
              ),
              Image.asset(
                "assets/star2.png",
                height: ScreenSize.horizontal! * 5,
              ),
            ],
          )),
    );
    ;
  }
}
