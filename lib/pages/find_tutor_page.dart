import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunteer_app/resources/tutor_model.dart';
import 'package:volunteer_app/utils/find_tutor_components.dart';
import 'package:volunteer_app/utils/size_config.dart';

class FindTutorPage extends StatefulWidget {
  const FindTutorPage({super.key});

  @override
  State<FindTutorPage> createState() => _FindTutorPageState();
}

class _FindTutorPageState extends State<FindTutorPage> {
  // Initialize subjects list
  List subjects = [];
  late String subjectSelected = subjects.first;

  List<String> level = ["SPM", "IGCSE", "PT3"];

  late String dropdownValue = level.first;

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    // Assign subjectsData and tutorData to firebase collections
    final subjectsData = FirebaseFirestore.instance.collection('levels');
    final tutorData = FirebaseFirestore.instance.collection('tutors');

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  ScreenSize.horizontal! * 5,
                  ScreenSize.vertical! * 5,
                  ScreenSize.horizontal! * 5,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //FIND TUTOR TITLE
                    Text(
                      "Find a tutor",
                      style: TextStyle(
                          fontSize: ScreenSize.vertical! * 4,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: ScreenSize.vertical! * 2,
                    ),

                    // LEVEL SELECTION INPUT FIELD
                    LevelDropdown(
                      level: level,
                      dropdownValue: dropdownValue,
                      // When level dropdown value is changed, setState dropdownValue
                      onLevelChanged: (String value) {
                        setState(() {
                          dropdownValue = value;
                          subjectSelected = "Maths";
                        });
                      },
                    ),
                  ],
                ),
              ),

              // LIST OF TUTORS
              Container(
                padding: EdgeInsets.all(ScreenSize.horizontal! * 5),
                width: ScreenSize.horizontal! * 100,
                height: ScreenSize.vertical! * 78,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(155, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                child: Column(
                  children: [
                    //Subjects
                    StreamBuilder(
                      stream: subjectsData.snapshots(),
                      builder: (context, snapshot) {
                        // If there is data in subjectsData snapshot
                        if (snapshot.hasData) {
                          // Get all documents of subjects in Firebase
                          final subjectsDocs = snapshot.data!.docs;

                          // Find the suitable document of subjects according to
                          // level selected
                          for (int i = 0; i < subjectsDocs.length; i++) {
                            if (subjectsDocs[i]["level"] == dropdownValue) {
                              // Assign all of the subjectsData into subjects List
                              subjects = subjectsDocs[i]['subjects'];
                            }
                          }
                          return SubjectSelection(
                            subjects: subjects,
                            subjectSelected: subjectSelected,
                            // When subject button is pressed, assign the value
                            // to subjectSelected variable
                            onChanged: (String value) {
                              setState(
                                () {
                                  subjectSelected = value;
                                },
                              );
                            },
                          );
                        } else {
                          return Text("error when getting subject data");
                        }
                      },
                    ),
                    SizedBox(
                      height: ScreenSize.vertical! * 2,
                    ),
                    //Tutors
                    StreamBuilder(
                      stream: tutorData.snapshots(),
                      builder: (context, snapshot) {
                        final tutorDocs = snapshot.data!.docs;
                        final List filteredTutors = [];
                        // Filter tutors by subject and store in filteredTutors
                        for (int i = 0; i < tutorDocs.length; i++) {
                          // If tutor subject and level is matching
                          if (tutorDocs[i]["subject"] == subjectSelected &&
                              tutorDocs[i]["level"] == dropdownValue) {
                            // Add the tutor to a List of filteredTutors
                            filteredTutors.add(tutorDocs[i]);
                          }
                        }
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  // Loop through filteredTutors List
                                  final currentTutor = filteredTutors[index];

                                  return FindTutorCard(
                                    tutorName: currentTutor["name"],
                                    tutorUni: currentTutor["uni"],
                                    tutorImage: currentTutor["image"],
                                    tutorStars: double.parse(
                                      currentTutor["stars"].toString(),
                                    ),
                                    tutorSubject: currentTutor["subject"],
                                    tutorBio: currentTutor["bio"],
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: ScreenSize.vertical! * 2,
                                    ),
                                itemCount: filteredTutors.length),
                          );
                        } else {
                          return Text("Error getting tutor data");
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
