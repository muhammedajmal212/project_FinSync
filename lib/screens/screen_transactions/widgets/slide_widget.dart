import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlideWidget extends StatelessWidget {
  final void Function(BuildContext edit)? editFunction;
  final void Function(BuildContext delete)? deleteFunction;
  final Widget child;
  final String? id;
  const SlideWidget(
      {super.key,
      required this.editFunction,
      required this.child,
      required this.deleteFunction,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              icon: Icons.edit,
              backgroundColor:const Color(0xFFCCE5E3),
              onPressed: editFunction,
            ),
            SlidableAction(
              icon: Icons.delete,
              backgroundColor:const  Color(0xFFFEE1B6),
              onPressed: deleteFunction,
            ),
          ],
        ),
        child: child);
  }
}
