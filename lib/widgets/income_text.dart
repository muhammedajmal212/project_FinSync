import 'package:flutter/material.dart';

class IncomeText extends StatelessWidget {
  final IconData? icon;
  final Color? iconcolor;

  const IncomeText({
    super.key,
    this.icon,
    this.iconcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: iconcolor,
          ),
        const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            "Income",
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
