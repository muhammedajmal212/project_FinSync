import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const AppButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:const  ButtonStyle(
        fixedSize: WidgetStatePropertyAll(
          Size(130, 0),
        ),
        backgroundColor: WidgetStatePropertyAll(
       Color(0xFF2F7E79),
        ),
        foregroundColor: WidgetStatePropertyAll(Color(0xFF2F2F2F),)
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 1),
        
      ),
    );
  }
}
