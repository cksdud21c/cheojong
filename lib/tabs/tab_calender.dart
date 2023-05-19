//하단바의 달력버튼을 누르면 나오는 화면
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/screens/shared_screens/bottombar.dart';
import 'package:untitled/screens/shared_screens/menu.dart';
class TabCalender extends StatefulWidget{
  @override
  State<TabCalender> createState() => _TabCalenderState();
}

class _TabCalenderState extends State<TabCalender> {
  // Define a variable to store the selected date
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  // Define a function to handle the onDaySelected event
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    // Update the selectedDay variable with the new value
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
    });

    // Display a popup window with the selected date
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected date'),
          content: Text('You have selected: ${DateFormat.yMMMMd('en_US').format(selectedDay)}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 67, 117),
        title: Text('달력'),
      ),
      endDrawer: SafeArea(child: Menu()),
      body: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2021, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        onDaySelected: _onDaySelected, // Call the _onDaySelected function when a day is selected
        selectedDayPredicate: (DateTime day) {
          return isSameDay(selectedDay, day);
        },
        headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextFormatter: (date, locale) => DateFormat.yMMMMd(locale).format(date),
          formatButtonVisible: false,
          titleTextStyle: const TextStyle(
            fontSize: 20.0,
            color: Colors.blue,
          ),
          headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
          leftChevronIcon: const Icon(
            Icons.arrow_left,
            size: 40.0,
          ),
          rightChevronIcon: const Icon(
            Icons.arrow_right,
            size: 40.0,
          ),
        ),
        calendarStyle: const CalendarStyle(
          isTodayHighlighted: true,
          todayTextStyle: TextStyle(
            color: Colors.black,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.amber,
          ),
        ),
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}
