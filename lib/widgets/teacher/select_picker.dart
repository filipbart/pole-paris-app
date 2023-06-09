import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pole_paris_app/styles/color.dart';

class SelectPicker extends StatefulWidget {
  final List<String> items;
  final double selectWidth;
  final double dropDownWidth;
  final ValueChanged<String?> onChanged;
  const SelectPicker({
    super.key,
    required this.items,
    required this.selectWidth,
    required this.dropDownWidth,
    required this.onChanged,
  });

  @override
  State<SelectPicker> createState() => _SelectPickerState();
}

Widget dropdownChooseHint = const Text('Wybierz',
    style: TextStyle(
      color: CustomColors.hintText,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Satoshi',
    ));

class _SelectPickerState extends State<SelectPicker> {
  bool _open = false;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> result = [];
    for (var item in items) {
      result.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  color: CustomColors.inputText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                color: Color(0xFFABABAB),
                thickness: 0.5,
              ),
            ),
        ],
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.selectWidth,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2(
          iconStyleData: IconStyleData(
            icon: Icon(_open ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          isExpanded: true,
          hint: dropdownChooseHint,
          validator: (value) {
            if (value == null) {
              return 'Wybierz godzinę.';
            }
            return null;
          },
          onMenuStateChange: (isOpen) {
            setState(() {
              _open = isOpen;
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            padding: const EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color:
                      _open ? CustomColors.inputText : const Color(0xFFE1E1E1)),
              color: Colors.white,
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            offset: const Offset(0, -5),
            elevation: 4,
            maxHeight: 180,
            width: widget.dropDownWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            height: 25,
          ),
          items: _addDividersAfterItems(widget.items),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
