import 'package:flutter/material.dart';
import 'package:week5/widgets/app_button.dart';
import 'package:week5/widgets/app_text_form_field.dart';

class AlertWidget extends StatefulWidget {
  final String text;
  final void Function()? function;
  final TextEditingController categorycontroller;
  final GlobalKey<FormState>? formKey;
  final String? Function(String?)? validatorFunction;

  const AlertWidget(
      {super.key,
      required this.function,
      required this.categorycontroller,
      required this.text,
      this.formKey,
      this.validatorFunction});

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.infinity,
        height: 150,
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextFormField(
                textEditingController: widget.categorycontroller,
                hintText: "Enter category",
                validatorKey: widget.validatorFunction,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Color.fromARGB(255, 248, 90, 90)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  AppButton(
                    onTap: widget.function,
                    text: "add ",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
