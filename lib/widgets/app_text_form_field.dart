import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
 final  TextInputType? keyboardType;
  final String? Function(String?)? validatorKey;
  final String hintText;

  final TextEditingController textEditingController;
  const AppTextFormField({
    this.keyboardType, 
    this.validatorKey,
    super.key,
    required this.hintText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validatorKey,
      controller: textEditingController,
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
            letterSpacing: 1,
            fontWeight: FontWeight.w400,
            // color: Color.fromARGB(255, 140, 139, 139)
            color:  Color.fromARGB(255, 150, 147, 147)
            ),
        fillColor:const  Color.fromARGB(255, 237, 240, 239),
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
