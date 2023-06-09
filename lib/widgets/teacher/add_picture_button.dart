import 'package:flutter/material.dart';

class AddPictureButton extends StatefulWidget {
  final Function() onPressed;
  final IconData icon;
  final String label;
  const AddPictureButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
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
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Center(
                    child: Icon(
                  widget.icon,
                  color: const Color(0xFF545454),
                  size: 54,
                )),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, right: 12.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.add,
                        color: Color(0xFF545454),
                      )),
                ),
              ],
            ),
          ),
        ),
        Text(widget.label),
      ],
    );
  }
}
