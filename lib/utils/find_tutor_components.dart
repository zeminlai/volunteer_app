import 'package:flutter/material.dart';
import 'package:volunteer_app/utils/size_config.dart';

// Subject dropdown menu
class SubjectDropdown extends StatefulWidget {
  List<String> level;
  String dropdownValue;

  SubjectDropdown(
      {super.key, required this.level, required this.dropdownValue});

  @override
  State<SubjectDropdown> createState() => Subject_DropdownState();
}

class Subject_DropdownState extends State<SubjectDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Color.fromARGB(155, 255, 255, 255), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Color.fromARGB(1, 255, 255, 255), width: 2),
          ),
          filled: true,
          fillColor: Color.fromARGB(155, 255, 255, 255),
          contentPadding: EdgeInsets.all(10)),
      isExpanded: true,
      value: widget.dropdownValue,
      items: widget.level.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 15),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(
          () {
            widget.dropdownValue = value!;
          },
        );
      },
    );
  }
}

// Subject selection
class SubjectSelection extends StatefulWidget {
  List<String> subjects;

  SubjectSelection({super.key, required this.subjects});

  @override
  State<SubjectSelection> createState() => _SubjectSelectionState();
}

class _SubjectSelectionState extends State<SubjectSelection> {
  late String subjectSelected = widget.subjects.first;

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Container(
      width: ScreenSize.horizontal! * 100,
      height: ScreenSize.vertical! * 4,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: widget.subjects.map((value) {
          return TextButton(
            onPressed: () {
              setState(() {
                subjectSelected = value;
                print(subjectSelected);
              });
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
                        color: Colors.grey, fontSize: ScreenSize.vertical! * 2),
                  ),
          );
        }).toList(),
      ),
    );
  }
}

class FindTutorSection extends StatefulWidget {
  List<Map<String, dynamic>> tutorInfo = [{}];
  FindTutorSection({super.key, required this.tutorInfo});

  @override
  State<FindTutorSection> createState() => _FindTutorSectionState();
}

class _FindTutorSectionState extends State<FindTutorSection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.tutorInfo.length,
        itemBuilder: (context, index) {
          final tutor = widget.tutorInfo[index];
          return ListTile(
            leading: Image.network(tutor["image"]),
            title: Text(tutor["name"]),
            subtitle: Text(tutor["uni"]),
            trailing: Text("${tutor["stars"]}"),
          );
        },
      ),
    );
  }
}
