import 'package:flutter/material.dart';

class DateFormField extends StatefulWidget {
  final String? Function(String?)? validatorKey;
  final TextEditingController datecontroller;
  final void Function(BuildContext) function;
  const DateFormField(
      {super.key,
      required this.datecontroller,
      this.validatorKey,
      required this.function});

  @override
  State<DateFormField> createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validatorKey,
      controller: widget.datecontroller,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () => widget.function(context),
          icon: const Icon(Icons.calendar_month_outlined),
        ),
        hintText: "Date",hintStyle: const TextStyle(color:  Color(0xFFA4A4A4)),
       fillColor:   const  Color.fromARGB(255, 237, 240, 239),
        filled: true,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            borderSide: BorderSide.none),
      ),
    );
  }
}
