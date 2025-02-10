import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final void Function() ontap;

  const AddButton({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF80CBC4),
      onPressed: ontap,
      child: const Icon(
        Icons.add_circle_outlined,
        size: 50,
        color: Colors.white,
      ),
    );
  }
}
