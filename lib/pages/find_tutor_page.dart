import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunteer_app/utils/find_tutor_components.dart';
import 'package:volunteer_app/utils/size_config.dart';

class FindTutorPage extends StatefulWidget {
  const FindTutorPage({super.key});

  @override
  State<FindTutorPage> createState() => _FindTutorPageState();
}

class _FindTutorPageState extends State<FindTutorPage> {
  List subjects = [];
  late String subjectSelected = subjects.first;

  List<String> level = ["SPM", "IGCSE", "PT3"];

  late String dropdownValue = level.first;
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
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
                        if (snapshot.hasData) {
                          final subjectsDocs = snapshot.data!.docs;
                          for (int i = 0; i < subjectsDocs.length; i++) {
                            if (subjectsDocs[i]["level"] == dropdownValue) {
                              subjects = subjectsDocs[i]['subjects'];
                            }
                          }
                          return SubjectSelection(
                            subjects: subjects,
                            subjectSelected: subjectSelected,
                            onChanged: (String value) {
                              setState(
                                () {
                                  subjectSelected = value;
                                  print(subjectSelected);
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
                          if (tutorDocs[i]["subject"] == subjectSelected &&
                              tutorDocs[i]["level"] == dropdownValue) {
                            print(tutorDocs[i]["name"]);
                            filteredTutors.add(tutorDocs[i]);
                          }
                        }
                        print(filteredTutors);
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final currentTutor = filteredTutors[index];

                                  return FindTutorCard(
                                    tutorName: currentTutor["name"],
                                    tutorUni: currentTutor["uni"],
                                    tutorImage: currentTutor["image"],
                                    tutorStars: double.parse(
                                      currentTutor["stars"].toString(),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: ScreenSize.vertical! * 2,
                                    ),
                                itemCount: filteredTutors.length),
                          );
                        } else {
                          return CircularProgressIndicator();
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
