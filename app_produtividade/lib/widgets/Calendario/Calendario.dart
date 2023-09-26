import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioWidget extends StatelessWidget {
  CalendarioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarioController calendarController =
        Get.find<CalendarioController>();

    return Container(
      margin: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.pinkAccent.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: calendarController.focusedDay,
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onPageChanged: (focusedDay) {
              calendarController.onPageChanged(focusedDay);
            },
            onDaySelected: (selectedDay, focusedDay) {
              calendarController.onDaySelecionado(selectedDay, focusedDay);
            },
            selectedDayPredicate: (day) {
              return isSameDay(calendarController.diaSelecionado, day);
            },
            eventLoader: (day) {
              return calendarController.getEventosDoDia(day);
            },
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;
  final DateTime date;

  Event({required this.title, required this.date});
}

class CalendarioController extends GetxController {
  static CalendarioController get to => Get.find<CalendarioController>();

  final Map<DateTime, List<Event>> eventos = {};
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

  void onPageChanged(DateTime focusedDay) {
    _focusedDay.value = focusedDay;
  }

  List<Event> getEventosDoDia(DateTime dia) {
    return eventos[dia] ?? [];
  }

  void adicionarEvento(DateTime data, String titulo) {
    Event evento = Event(title: titulo, date: data);

    if (eventos.containsKey(data)) {
      eventos[data]!.add(evento);
    } else {
      eventos[data] = [evento];
    }

    update(); // Atualiza o estado para refletir as mudanças
  }
}
