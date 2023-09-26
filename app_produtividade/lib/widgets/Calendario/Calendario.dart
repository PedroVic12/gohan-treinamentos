import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioWidget extends StatefulWidget {
  const CalendarioWidget({super.key});

  @override
  State<CalendarioWidget> createState() => _CalendarioWidgetState();
}

class _CalendarioWidgetState extends State<CalendarioWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _diaSelecionado;
  Map<DateTime, List<Event>> envetos = {};

  @override
  void initState() {
    super.initState();
    _diaSelecionado = _focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onDaySelecionado(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_diaSelecionado, selectedDay)) {
      setState(() {
        _diaSelecionado = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
        selectedDayPredicate: (day) => isSameDay(_diaSelecionado, day),
        calendarFormat: _calendarFormat,
        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: onDaySelecionado,
        calendarStyle: CalendarStyle(outsideDaysVisible: false),
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) => _focusedDay = focusedDay,
      ),
    );
  }
}

class Event {
  final String title;

  Event({required this.title});
}

class CalendarioController extends GetxController {
  final Map<DateTime, List<Event>> envetos = {};
  final Rx<DateTime> _diaSelecionado = DateTime.now().obs;
  final Rx<DateTime> _focusedDay = DateTime.now().obs;

  DateTime get diaSelecionado => _diaSelecionado.value;
  DateTime get focusedDay => _focusedDay.value;

  void onDaySelecionado(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(diaSelecionado, selectedDay)) {
      _diaSelecionado.value = selectedDay;
      _focusedDay.value = focusedDay;
    }
  }
}
