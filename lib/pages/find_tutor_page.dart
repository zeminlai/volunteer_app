import 'package:flutter/material.dart';
import 'package:volunteer_app/utils/find_tutor_components.dart';
import 'package:volunteer_app/utils/size_config.dart';

class FindTutorPage extends StatefulWidget {
  const FindTutorPage({super.key});

  @override
  State<FindTutorPage> createState() => _FindTutorPageState();
}

class _FindTutorPageState extends State<FindTutorPage> {
  List<String> subjects = [
    "Maths",
    "Physics",
    "BM",
    "Add Maths",
    "Biology",
    "Sejarah"
  ];
  late String subjectSelected = subjects.first;

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    List<String> level = ["SPM", "IGCSE", "PT3"];

    String dropdownValue = level.first;

    List<Map<String, dynamic>> tutorMaths = [
      {
        "name": "TanJZ",
        "uni": "Universiti Indon Laurencia",
        "stars": 5.0,
        "image":
            "https://scontent.fbki2-1.fna.fbcdn.net/v/t1.6435-9/31817390_1448910555255518_2611503638257860608_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=174925&_nc_ohc=-AcsCtl_ISIAX96Sr3k&_nc_oc=AQltIfNhMd8kd0PkRS7R6UbC9ORVT48fRNjCQPmkEQcqDJVtDoNwItcyTet-CVRLSh-Vdpr9HUPWxqaC238jyg2l&_nc_ht=scontent.fbki2-1.fna&oh=00_AfDgrR0z1TAJpm0W2T-FgVOBqNuuvzuq3jdZdhzg6g-PnA&oe=642FBF28",
      },
      {
        "name": "CK Yong",
        "uni": "Universiti Malaysia Sabah",
        "stars": 5.0,
        "image":
            "https://scontent.fbki2-1.fna.fbcdn.net/v/t1.18169-9/11018891_10152809453968650_1227892126726931894_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=730e14&_nc_ohc=0tkCHLoSHvkAX_izG2A&_nc_ht=scontent.fbki2-1.fna&oh=00_AfB-ODWSq2XEJZ5r1ZH0thGPGi5ka4C_79xJjh7sY97vlw&oe=64301B24",
      },
      {
        "name": "LaiZM",
        "uni": "Universiti Malaya",
        "stars": 5.2,
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg/1200px-Elon_Musk_Royal_Society_%28crop2%29.jpg",
      },
      {
        "name": "TanJZ",
        "uni": "Universiti Malaya",
        "stars": 5.0,
        "image":
            "https://scontent.fbki2-1.fna.fbcdn.net/v/t1.6435-9/31817390_1448910555255518_2611503638257860608_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=174925&_nc_ohc=-AcsCtl_ISIAX96Sr3k&_nc_oc=AQltIfNhMd8kd0PkRS7R6UbC9ORVT48fRNjCQPmkEQcqDJVtDoNwItcyTet-CVRLSh-Vdpr9HUPWxqaC238jyg2l&_nc_ht=scontent.fbki2-1.fna&oh=00_AfDgrR0z1TAJpm0W2T-FgVOBqNuuvzuq3jdZdhzg6g-PnA&oe=642FBF28",
      },
      {
        "name": "LaiZM",
        "uni": "Universiti Malaya",
        "stars": 5.2,
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg/1200px-Elon_Musk_Royal_Society_%28crop2%29.jpg",
      },
      {
        "name": "LaiZM",
        "uni": "Universiti Malaya",
        "stars": 5.2,
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg/1200px-Elon_Musk_Royal_Society_%28crop2%29.jpg",
      },
      {
        "name": "LaiZM",
        "uni": "Universiti Malaya",
        "stars": 5.2,
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg/1200px-Elon_Musk_Royal_Society_%28crop2%29.jpg",
      },
      {
        "name": "LaiZM",
        "uni": "Universiti Malaya",
        "stars": 5.2,
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg/1200px-Elon_Musk_Royal_Society_%28crop2%29.jpg",
      },
    ];
    List<Map<String, dynamic>> tutorPhysics = [
      {
        "name": "LaiZM",
        "uni": "Universiti Malaya",
        "stars": 5.2,
        "image":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg/1200px-Elon_Musk_Royal_Society_%28crop2%29.jpg",
      },
    ];
    List<Map<String, dynamic>> tutorBM = [
      {
        "name": "Fatimah",
        "uni": "Universiti Malaya",
        "stars": 5.2,
        "image":
            "https://apicms.thestar.com.my/uploads/images/2022/05/15/1585587.jpg",
      },
    ];

    Widget changeTutorList() {
      switch (subjectSelected) {
        case "Maths":
          return FindTutorSection(tutorInfo: tutorMaths);
        case "Physics":
          return FindTutorSection(tutorInfo: tutorPhysics);
        case "BM":
          return FindTutorSection(tutorInfo: tutorBM);
        default:
          return FindTutorSection(
            tutorInfo: tutorMaths,
          );
      }
    }

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
                    SubjectDropdown(level: level, dropdownValue: dropdownValue),
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
                    SubjectSelection(
                      subjects: subjects,
                      subjectSelected: subjectSelected,
                      onChanged: (String value) {
                        setState(() {
                          subjectSelected = value;
                          print(subjectSelected);
                        });
                      },
                    ),
                    SizedBox(
                      height: ScreenSize.vertical! * 2,
                    ),
                    //Tutors
                    changeTutorList()
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
