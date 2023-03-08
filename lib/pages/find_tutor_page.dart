import 'package:flutter/material.dart';
import 'package:volunteer_app/utils/find_tutor_components.dart';
import 'package:volunteer_app/utils/size_config.dart';

class FindTutorPage extends StatefulWidget {
  const FindTutorPage({super.key});

  @override
  State<FindTutorPage> createState() => _FindTutorPageState();
}

class _FindTutorPageState extends State<FindTutorPage> {
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    List<String> level = ["SPM", "IGCSE", "PT3"];
    List<String> subjects = [
      "Maths",
      "Physics",
      "BM",
      "Add Maths",
      "Biology",
      "Sejarah"
    ];
    String dropdownValue = level.first;

    List<Map<String, dynamic>> tutorInfo = [
      {
        "name": "TanJZ",
        "uni": "Universiti Malaya",
        "stars": 5.0,
        "image":
            "https://scontent.fbki2-1.fna.fbcdn.net/v/t1.6435-9/31817390_1448910555255518_2611503638257860608_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=174925&_nc_ohc=-AcsCtl_ISIAX96Sr3k&_nc_oc=AQltIfNhMd8kd0PkRS7R6UbC9ORVT48fRNjCQPmkEQcqDJVtDoNwItcyTet-CVRLSh-Vdpr9HUPWxqaC238jyg2l&_nc_ht=scontent.fbki2-1.fna&oh=00_AfDgrR0z1TAJpm0W2T-FgVOBqNuuvzuq3jdZdhzg6g-PnA&oe=642FBF28",
      },
      {
        "name": "TanJZ",
        "uni": "Universiti Malaya",
        "stars": 5.0,
        "image":
            "https://scontent.fbki2-1.fna.fbcdn.net/v/t1.6435-9/31817390_1448910555255518_2611503638257860608_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=174925&_nc_ohc=-AcsCtl_ISIAX96Sr3k&_nc_oc=AQltIfNhMd8kd0PkRS7R6UbC9ORVT48fRNjCQPmkEQcqDJVtDoNwItcyTet-CVRLSh-Vdpr9HUPWxqaC238jyg2l&_nc_ht=scontent.fbki2-1.fna&oh=00_AfDgrR0z1TAJpm0W2T-FgVOBqNuuvzuq3jdZdhzg6g-PnA&oe=642FBF28",
      },
      {
        "name": "TanJZ",
        "uni": "Universiti Malaya",
        "stars": 5.0,
        "image":
            "https://scontent.fbki2-1.fna.fbcdn.net/v/t1.6435-9/31817390_1448910555255518_2611503638257860608_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=174925&_nc_ohc=-AcsCtl_ISIAX96Sr3k&_nc_oc=AQltIfNhMd8kd0PkRS7R6UbC9ORVT48fRNjCQPmkEQcqDJVtDoNwItcyTet-CVRLSh-Vdpr9HUPWxqaC238jyg2l&_nc_ht=scontent.fbki2-1.fna&oh=00_AfDgrR0z1TAJpm0W2T-FgVOBqNuuvzuq3jdZdhzg6g-PnA&oe=642FBF28",
      },
      {
        "name": "TanJZ",
        "uni": "Universiti Malaya",
        "stars": 5.0,
        "image":
            "https://scontent.fbki2-1.fna.fbcdn.net/v/t1.6435-9/31817390_1448910555255518_2611503638257860608_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=174925&_nc_ohc=-AcsCtl_ISIAX96Sr3k&_nc_oc=AQltIfNhMd8kd0PkRS7R6UbC9ORVT48fRNjCQPmkEQcqDJVtDoNwItcyTet-CVRLSh-Vdpr9HUPWxqaC238jyg2l&_nc_ht=scontent.fbki2-1.fna&oh=00_AfDgrR0z1TAJpm0W2T-FgVOBqNuuvzuq3jdZdhzg6g-PnA&oe=642FBF28",
      },
    ];
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
                padding: EdgeInsets.fromLTRB(ScreenSize.horizontal! * 5,
                    ScreenSize.vertical! * 5, ScreenSize.horizontal! * 5, 0),
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
                    SubjectDropdown(level: level, dropdownValue: dropdownValue),
                  ],
                ),
              ),

              // LIST OF TUTORS
              Container(
                padding: EdgeInsets.all(ScreenSize.horizontal! * 5),
                width: ScreenSize.horizontal! * 100,
                height: ScreenSize.vertical! * 78,
                decoration: BoxDecoration(
                    color: Color.fromARGB(155, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40))),
                child: Column(
                  children: [
                    //Subjects
                    SubjectSelection(
                      subjects: subjects,
                    ),

                    //Tutors
                    FindTutorSection(tutorInfo: tutorInfo)
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
