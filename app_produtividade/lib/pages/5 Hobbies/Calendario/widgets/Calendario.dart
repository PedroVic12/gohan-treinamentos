import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../CalendarioController.dart';

class CalendarioWidget extends StatefulWidget {
  CalendarioWidget({super.key});

  @override
  State<CalendarioWidget> createState() => _CalendarioWidgetState();
}

class _CalendarioWidgetState extends State<CalendarioWidget> {
  @override
  Widget build(BuildContext context) {
    final calendarController = Get.put(CalendarioController());
    var dataSelecionada = DateTime.now();

    return Container(
      margin: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.pinkAccent.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar(
        //?Formatos
        firstDay: DateTime.utc(2020, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: calendarController.focusedDay,
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.monday,
        //?Estilos
        calendarStyle: CalendarStyle(isTodayHighlighted: true),
        headerStyle:
            HeaderStyle(formatButtonVisible: true, titleCentered: true),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle:
                TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            weekdayStyle: TextStyle(
                color: Colors.amberAccent, fontWeight: FontWeight.bold)),

        //?Mudança de estado
        onPageChanged: (focusedDay) {
          calendarController.onPageChanged(focusedDay);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            calendarController.onDaySelecionado(selectedDay, focusedDay);
          });
        },
        selectedDayPredicate: (day) {
          return isSameDay(day, calendarController.diaSelecionado);
        },
        eventLoader: (day) {
          return calendarController.getEventosDoDia(day);
        },
      ),
    );
  }
}
