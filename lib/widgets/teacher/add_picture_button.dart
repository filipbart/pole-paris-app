import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class AddPictureButton extends StatefulWidget {
  final Function() onPressed;
  final IconData icon;
  final String label;
  final bool circle;
  const AddPictureButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.circle = false,
  });

  @override
  State<AddPictureButton> createState() => _AddPictureButtonState();
}

class _AddPictureButtonState extends State<AddPictureButton> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      direction: Axis.vertical,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          onPressed: widget.onPressed,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFC4C4C4),
              borderRadius: BorderRadius.circular(widget.circle ? 75 : 20),
            ),
            child: Center(
                child: Icon(
              widget.icon,
              color: CustomColors.hintText,
              size: 54,
            )),
          ),
        ),
        Text(widget.label),
      ],
    );
  }
}
