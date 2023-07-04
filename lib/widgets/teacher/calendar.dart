import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pole_paris_app/extensions/dateTime.dart';
import 'package:pole_paris_app/styles/color.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final DateTime firstDay;
  final List<DateTime>? classDays;
  final DateTime? focusedDay;
  final Function(DateTime, DateTime)? onDateChanged;

  const Calendar({
    super.key,
    required this.firstDay,
    this.classDays,
    this.onDateChanged,
    this.focusedDay,
  });

  static TextStyle daysStyle = GoogleFonts.lato(
    color: CustomColors.text,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static TextStyle weekDaysStyle = GoogleFonts.lato(
    color: CustomColors.text,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE1E1E1)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar(
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            if (widget.classDays != null) {
              for (DateTime classes in widget.classDays!) {
                if (classes.isSameDate(day)) {
                  return Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: CustomColors.text,
                      ),
                    ),
                    //TODO: odnośnik do twoje zajęcia
                    child: Center(
                      child: Text(
                        '${day.day}',
                      ),
                    ),
                  );
                }
              }
            }
            return null;
          },
        ),
        selectedDayPredicate: (day) {
          return (widget.focusedDay ?? _focusedDay).isSameDate(day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (widget.onDateChanged != null) {
            widget.onDateChanged!(selectedDay, focusedDay);
            if (_focusedDay.isSameDate(selectedDay) == false) {
              setState(() {
                _focusedDay = selectedDay;
              });
            }
          }
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        firstDay: widget.firstDay,
        lastDay: DateTime.now().add(const Duration(days: 30)),
        focusedDay: widget.focusedDay ?? _focusedDay,
        headerStyle: HeaderStyle(
            headerPadding: const EdgeInsets.only(bottom: 12),
            titleCentered: true,
            formatButtonVisible: false,
            leftChevronVisible: false,
            rightChevronVisible: false,
            headerMargin: const EdgeInsets.symmetric(vertical: 12),
            titleTextStyle: GoogleFonts.lato(
              fontSize: 15.5,
              color: const Color(0xFF828282),
              fontWeight: FontWeight.w400,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.77,
                  color: Color(0xFFBDBDBD),
                ),
              ),
            )),
        daysOfWeekHeight: 25,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: Calendar.weekDaysStyle,
          weekendStyle: Calendar.weekDaysStyle,
        ),
        calendarStyle: CalendarStyle(
          tablePadding: const EdgeInsets.symmetric(horizontal: 15),
          outsideDaysVisible: false,
          weekNumberTextStyle: Calendar.daysStyle,
          rangeEndTextStyle: Calendar.daysStyle,
          rangeStartTextStyle: Calendar.daysStyle,
          selectedDecoration: const BoxDecoration(
            color: CustomColors.text2,
            shape: BoxShape.circle,
          ),
          isTodayHighlighted: widget.onDateChanged == null,
          todayDecoration: const BoxDecoration(
            color: CustomColors.text2,
            shape: BoxShape.circle,
          ),
          weekendTextStyle: Calendar.daysStyle,
          defaultTextStyle: Calendar.daysStyle,
        ),
        locale: 'pl_PL',
      ),
    );
  }
}
