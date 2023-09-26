import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../widgets/Custom/CustomText.dart';
import 'widgets/ModalCreateTask.dart';

class CalendarioController extends GetxController {
  final Map<DateTime, List<Event>> eventos = {};
  late DateTime _diaSelecionado = DateTime.now();
  late DateTime _focusedDay = DateTime.now();

  DateTime get diaSelecionado => _diaSelecionado;
  DateTime get focusedDay => _focusedDay;

  //!Adicione variáveis para armazenar os valores
  RxString nomeDoEvento = ''.obs;
  RxString tipoDoEvento = ''.obs;
  Rx<DateTime?> dataSelecionada = Rx<DateTime?>(null);
  Rx<TimeOfDay?> horaSelecionada = Rx<TimeOfDay?>(null);
  RxString categoriaSelecionada = 'Faculdade'.obs; // valor inicial
  RxString prioridadeSelecionada = ''.obs;

  //! Métodos para atualizar as variáveis
  void atualizarPrioridade(String prioridade) {
    prioridadeSelecionada.value = prioridade;
  }

  void atualizarNomeDoEvento(String nome) {
    nomeDoEvento.value = nome;
  }

  void atualizarTipoDoEvento(String tipo) {
    tipoDoEvento.value = tipo;
  }

  void atualizarDataSelecionada(DateTime data) {
    dataSelecionada.value = data;
  }

  void atualizarHoraSelecionada(TimeOfDay hora) {
    horaSelecionada.value = hora;
  }

  void atualizarCategoriaSelecionada(String categoria) {
    categoriaSelecionada.value = categoria;
  }

  void imprimirDadosDoEvento() {
    print('\n\n');
    print('Nome do Evento: ${nomeDoEvento.value}');
    print('Tipo do Evento: ${tipoDoEvento.value}');
    print('Prioridade: ${prioridadeSelecionada.value}');
    print('Data Selecionada: ${dataSelecionada.value}');
    print('Hora Selecionada: ${horaSelecionada.value}');
    print('Categoria: ${categoriaSelecionada.value}');
  }

  //!Métodos Calendario
  void onDaySelecionado(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(diaSelecionado, selectedDay)) {
      _diaSelecionado = selectedDay;
      _focusedDay = focusedDay;
      update(); // Notifica a interface do usuário sobre as mudanças
    }
  }

  void onPageChanged(DateTime focusedDay) {
    _focusedDay = focusedDay;
    update(); // Notifica a interface do usuário sobre as mudanças
  }

  List<Event> getEventosDoDia(DateTime dia) {
    return eventos[dia] ?? [];
  }

// Função para adicionar um evento ao calendário
  void adicionarEventoAoCalendario(
      String titulo, String tipo, DateTime dataHora, String categoria) {
    final DateTime data = DateTime(dataHora.year, dataHora.month, dataHora.day);

    // Crie o evento
    final Event novoEvento = Event(title: titulo, date: data);

    // Adicione o evento à lista de eventos
    if (eventos.containsKey(data)) {
      eventos[data]!.add(novoEvento);
    } else {
      eventos[data] = [novoEvento];
    }

    // Atualize o estado para refletir as mudanças no calendário
    update();

    // Feche o modal (você pode usar Navigator.pop(context) se estiver dentro de um Navigator)
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

  void createOrUpdateTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bc) {
          final altura = MediaQuery.of(context).size.height;
          return CreateTaskFields(altura: altura);
        });
  }
}

class Event {
  final String title;
  final DateTime date;

  Event({required this.title, required this.date});
}
