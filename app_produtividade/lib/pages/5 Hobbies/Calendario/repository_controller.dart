import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepositoryController extends GetxController {
  final List<Appointment> _appointments = [];
  final String _key =
      'events'; // Chave para salvar eventos no SharedPreferences

  List<Appointment> get appointments => _appointments;

  @override
  void onInit() {
    super.onInit();
    // Carregue os eventos salvos quando o controller é inicializado
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final eventsData = prefs.getString(_key);
    if (eventsData != null) {
      final savedEvents = AppointmentHelper.fromData(eventsData);
      _appointments.addAll(savedEvents);
      update(); // Notifique os observadores sobre a mudança
    }
  }

  Future<void> saveEvent(Appointment event) async {
    _appointments.add(event);
    update(); // Notifique os observadores sobre a mudança

    final prefs = await SharedPreferences.getInstance();
    final eventsData = AppointmentHelper.toData(_appointments);
    await prefs.setString(_key, eventsData);
  }

  void removeEvent(Appointment event) {
    _appointments.remove(event);
    update(); // Notifique os observadores sobre a mudança

    // Atualize os eventos salvos no SharedPreferences após a remoção
    _updateSavedEvents();
  }

  Future<void> _updateSavedEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final eventsData = AppointmentHelper.toData(_appointments);
    await prefs.setString(_key, eventsData);
  }
}

class AppointmentHelper {
  // Converta uma lista de eventos para uma representação de String
  static String toData(List<Appointment> events) {
    final eventList = events.map((e) {
      return {
        'startTime': e.startTime.millisecondsSinceEpoch,
        'endTime': e.endTime.millisecondsSinceEpoch,
        'subject': e.subject,
        'color': e.color.value,
      };
    }).toList();
    return eventList.toString();
  }

  // Converta uma representação de String de eventos de volta para uma lista de eventos
  static List<Appointment> fromData(String data) {
    final eventList = List<Map<String, dynamic>>.from(eval(data));
    return eventList.map((e) {
      return Appointment(
        startTime: DateTime.fromMillisecondsSinceEpoch(e['startTime']),
        endTime: DateTime.fromMillisecondsSinceEpoch(e['endTime']),
        subject: e['subject'],
        color: Color(e['color']),
      );
    }).toList();
  }
}

// Função para analisar a representação de String da lista de eventos
List<Map<String, dynamic>> eval(String data) {
  final List<Map<String, dynamic>> list = [];
  final RegExp exp = RegExp(r'{.*?}');
  exp.allMatches(data).forEach((Match match) {
    final String mapString = match.group(0)!;
    list.add(Map<String, dynamic>.from(
      evalMapString(mapString),
    ));
  });
  return list;
}

// Função para analisar a representação de String de um mapa
Map<String, dynamic> evalMapString(String mapString) {
  final Map<String, dynamic> map = {};
  final List<String> entries = mapString.split(', ');
  entries.forEach((String entry) {
    final List<String> keyValue = entry.split(': ');
    final String key = keyValue[0];
    final String value = keyValue[1];
    map[key] = value;
  });
  return map;
}
