import 'package:flutter/material.dart';

class SubjectDropdown extends StatefulWidget {
  List<String> subjects;
  String dropdownValue;

  SubjectDropdown(
      {super.key, required this.subjects, required this.dropdownValue});

  @override
  State<SubjectDropdown> createState() => Subject_DropdownState();
}

class Subject_DropdownState extends State<SubjectDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          widget.dropdownValue = value!;
        });
      },
      items: (widget.subjects).map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
