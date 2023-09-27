import 'package:flutter/material.dart';

class Event {
  final String title;
  final DateTime date;
  final String prioridade;
  final TimeOfDay hora;
  final String categoria;

  Event({
    required this.title,
    required this.date,
    required this.prioridade,
    required this.hora,
    required this.categoria,
  });
}

class EventUtils {
  Map<String, dynamic> eventToJson(Event event) {
    return {
      'title': event.title,
      'prioridade': event.prioridade,
      'data': event.date.toIso8601String(),
      'categoria': event.categoria,
    };
  }

  Map<String, dynamic> eventMapToJson(Map<DateTime, List<Event>> eventMap) {
    Map<String, dynamic> jsonStringMap = {};
    eventMap.forEach((date, events) {
      List<Map<String, dynamic>> jsonEvents =
          events.map((e) => eventToJson(e)).toList();
      jsonStringMap[date.toIso8601String()] = jsonEvents;
    });
    return jsonStringMap;
  }

  Map<DateTime, List<Event>> jsonToEventMap(Map<String, dynamic> jsonMap) {
    Map<DateTime, List<Event>> eventMap = {};
    jsonMap.forEach((dateString, jsonEvents) {
      List<Event> events = List<Event>.from((jsonEvents as List)
          .map((e) => jsonToEvent(Map<String, dynamic>.from(e))));
      eventMap[DateTime.parse(dateString)] = events;
    });
    return eventMap;
  }

  Event jsonToEvent(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      prioridade: json['prioridade'],
      date: DateTime.parse(json['data']),
      hora: TimeOfDay.fromDateTime(DateTime.parse(json['data'])),
      categoria: json['categoria'],
    );
  }
}
