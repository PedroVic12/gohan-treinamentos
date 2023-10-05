import 'dart:convert';
import 'dart:io';

import 'package:app_produtividade/pages/5%20Hobbies/Calendario/Eventos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../widgets/Custom/CustomText.dart';
import 'widgets/ModalCreateTask.dart';

class CalendarioController extends GetxController {
  Map<DateTime, List<Event>> eventos = {};
  final EventUtils eventUtils = EventUtils();
  Rx<DateTime> _diaSelecionado = DateTime.now().obs;
  late DateTime _focusedDay = DateTime.now();

  DateTime get diaSelecionado => _diaSelecionado.value;
  DateTime get focusedDay => _focusedDay;

  @override
  void onInit() {
    super.onInit();
    lerEventosJson();
  }

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
    print('Dados Coletados:\n');
    print('Nome do Evento: ${nomeDoEvento.value}');
    print('Prioridade: ${prioridadeSelecionada.value}');
    print('Data Selecionada: ${dataSelecionada.value}');
    print('Hora Selecionada: ${horaSelecionada.value}');
    print('Categoria: ${categoriaSelecionada.value}');
  }

// Função para verificar se o app está sendo executado na web
  bool isRunningOnWeb() {
    return kIsWeb;
  }

  //!Métodos Calendario
  void onDaySelecionado(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(diaSelecionado, selectedDay)) {
      _diaSelecionado.value = selectedDay;
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

//! Função para adicionar um evento ao calendário
  void adicionarEventoNaDataSelecionada({
    required String titulo,
    required String prioridade,
    required TimeOfDay hora,
    required String categoria,
  }) {
    DateTime dataHoraEvento = DateTime(
      _diaSelecionado.value.year,
      _diaSelecionado.value.month,
      _diaSelecionado.value.day,
      hora.hour,
      hora.minute,
    );

    Event evento = Event(
      title: titulo,
      date: dataHoraEvento,
      prioridade: prioridade,
      hora: hora,
      categoria: categoria,
    );

    if (eventos.containsKey(_diaSelecionado)) {
      eventos[_diaSelecionado]!.add(evento);
    } else {
      eventos[_diaSelecionado.value] = [evento];
    }

    try {
      salvarEventosJson(evento);
      Get.snackbar(
        'Evento Adicionado', // Título
        'Evento ${evento.title} foi adicionado com sucesso!', // Mensagem
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );
    } catch (e) {
      print('erro ao salvar json ${e}');
    }
    update(); // Atualiza o estado para refletir as mudanças
  }

  void createOrUpdateTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          final altura =
              MediaQuery.of(context).size.height * 0.7; // 70% da altura da tela
          return Container(
            height: altura,
            color: Colors.blueGrey.shade100,
            child: ModalPegarEventosCalendario(altura: altura),
          );
        });
  }

  //!Funções JSON
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    return File('lib/assets/eventos.json');
  }

  Future<void> salvarEventosJson(Event event) async {
    final file = await _localFile;
    final Map<String, dynamic> jsonData = eventUtils.eventMapToJson(eventos);
    print('\nJson salvo: ${jsonData}');
    await file.writeAsString(jsonEncode(jsonData));
  }

  Future<void> lerEventosJson() async {
    try {
      final file = await _localFile;
      final jsonData = await file.readAsString();
      final Map<String, dynamic> data =
          Map<String, dynamic>.from(jsonDecode(jsonData));
      eventos = eventUtils.jsonToEventMap(data);
      update();
    } catch (error) {
      print("Erro ao carregar eventos do arquivo: $error");
    }
  }
}

class PlatformSpecificContainer extends StatelessWidget {
  final CalendarioController calendario;

  PlatformSpecificContainer(this.calendario);

  @override
  Widget build(BuildContext context) {
    if (calendario.isRunningOnWeb()) {
      // Salva os dados do calendário no localStorage se estiver na web
      _saveDataToLocalStorage();

      // Retorna um container para a web
      return Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blue,
        child: Text("O aplicativo está sendo executado na web"),
      );
    } else {
      // Retorna um container para outras plataformas
      return Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.green,
        child: Text("O aplicativo não está sendo executado na web"),
      );
    }
  }

  void _saveDataToLocalStorage() {
    // Aqui você pode usar o pacote `html` para acessar o `localStorage` da web e salvar os dados
    // Por exemplo:
    // window.localStorage['nomeDoEvento'] = calendario.nomeDoEvento.value;
    // ... e assim por diante para os outros campos.
  }
}
