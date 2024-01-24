import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:friendly_spaces/my_components/my_svg_widget.dart';

class NoteTile extends StatelessWidget {
  final String noteText;
  final MySvgWidget? emotionIcon;
  final Function(BuildContext)? editTapped;
  final Function(BuildContext)? deleteTapped;

  const NoteTile(
      {super.key,
      required this.noteText,
      required this.emotionIcon,
      this.editTapped,
      this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //edit option
            SlidableAction(
              onPressed: editTapped,
              backgroundColor: Theme.of(context).colorScheme.surfaceTint,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(12),
            ),
            //delete option
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //note text
              SizedBox(
                width: 300,
                child: Text(
                  noteText,
                  maxLines: null,
                ),
              ),
              //emotion icon
              Container(
                height: 30,
                width: 30,
                child: emotionIcon ?? const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
