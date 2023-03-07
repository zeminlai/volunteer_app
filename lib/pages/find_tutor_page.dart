import 'package:flutter/material.dart';
import 'package:volunteer_app/utils/find_tutor_components.dart';

class FindTutorPage extends StatefulWidget {
  const FindTutorPage({super.key});

  @override
  State<FindTutorPage> createState() => _FindTutorPageState();
}

class _FindTutorPageState extends State<FindTutorPage> {
  @override
  Widget build(BuildContext context) {
    List<String> subjects = ["SPM", "IGCSE", "PT3"];
    String dropdownValue = subjects[0];
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(250, 226, 223, 223),
          image: DecorationImage(
            image: AssetImage("assets/find_tutor_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //FIND TUTOR TITLE
              Text("Find a tutor"),
              // LEVEL SELECTION INPUT FIELD
              SubjectDropdown(subjects: subjects, dropdownValue: dropdownValue)
              // LIST OF TUTORS
            ],
          ),
        ),
      ),
    );
  }
}
