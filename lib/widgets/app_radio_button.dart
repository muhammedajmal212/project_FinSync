import 'package:flutter/material.dart';

class AppRadioButton extends StatelessWidget {
  final String groupValue;
  final String newvalue;
  final Widget title;
  final ValueChanged<String> onChanged;
  const AppRadioButton(
      {super.key,
      required this.groupValue,
      required this.newvalue,
      required this.title,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity:  VisualDensity.compact,
      activeColor:const Color(0xFF80CBC4),
      title: title,
      value: newvalue,
      groupValue: groupValue,
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
