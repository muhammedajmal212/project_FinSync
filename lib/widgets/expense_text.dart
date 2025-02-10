import 'package:flutter/material.dart';

class ExpenseText extends StatelessWidget {
  final IconData? icon;
  final Color? color;

  const ExpenseText({
    super.key,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: color,
          ),
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            "Expense",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
