import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pole_paris_app/styles/color.dart';

class DateSelectPicker extends StatefulWidget {
  final Function(DateTime?) callback;
  final double selectWidth;

  const DateSelectPicker({
    super.key,
    required this.selectWidth,
    required this.callback,
  });

  @override
  State<DateSelectPicker> createState() => _DateSelectPickerState();
}

class _DateSelectPickerState extends State<DateSelectPicker> {
  bool _open = false;
  DateTime? choosenDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _open = true;
        });
        showDatePicker(
          context: context,
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: Colors.white,
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: CustomColors.text2,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            child: child!,
          ),
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 1)),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        ).then((value) {
          setState(() {
            _open = false;
            choosenDate = value;
            widget.callback(choosenDate);
          });
        });
      },
      splashColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _open ? CustomColors.inputText : const Color(0xFFE1E1E1),
          ),
        ),
        width: widget.selectWidth,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                choosenDate == null
                    ? 'Wybierz datę'
                    : DateFormat('dd.MM.yyyy').format(choosenDate!),
                style: choosenDate == null
                    ? const TextStyle(
                        color: CustomColors.hintText,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Satoshi',
                      )
                    : const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Satoshi',
                        color: CustomColors.inputText,
                        fontWeight: FontWeight.w500,
                      ),
              ),
              Icon(_open ? Icons.arrow_drop_up : Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
    );
  }
}
