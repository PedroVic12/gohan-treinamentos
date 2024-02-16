import 'dart:convert';

import 'package:app_produtividade/pages/5%20Hobbies/Calendario/controller/Evento.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/BotaoPrioridade.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DateTimePicker.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DropDownCategorias.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:app_produtividade/widgets/Layout/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';

class CalendarioWidget extends StatefulWidget {
  const CalendarioWidget({super.key});

  @override
  State<CalendarioWidget> createState() => _CalendarioWidgetState();
}

class _CalendarioWidgetState extends State<CalendarioWidget> {
  final List<Appointment> _appointments = [];
  String _assunto = '';
  final CalendarController _calendarController = CalendarController();
  List<Appointment> _eventosDoDia = [];

  Future<void> _carregarEventosSalvos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final eventosJson = prefs.getStringList('eventos_key') ?? [];
      _appointments.clear(); // Limpa os eventos para evitar duplicações

      eventosJson.forEach((eventoJson) {
        final eventoMap = json.decode(eventoJson) as Map<String, dynamic>;

        final evento = Evento.fromJson(eventoMap);

        // Adiciona o evento aos appointments e eventos do diac
        _appointments.add(Appointment(
          startTime: evento.inicio,
          endTime: evento.fim,
          subject: evento.nomeEvento,
        ));
      });

      setState(() {
        _eventosDoDia = _appointments;
      });

      // Print para verificar os eventos carregados
      for (final evento in _eventosDoDia) {
        print('Evento Carregado: ${evento.subject}');
      }
    } catch (e) {
      // Lidar com erros ao carregar eventos, se necessário
      print('Erro ao carregar eventos: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarEventosSalvos(); // Carrega os eventos ao iniciar a página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: SfCalendar(
              controller: _calendarController,
              view: CalendarView.month,
              firstDayOfWeek: 6,
              dataSource: ReuniaoDataSource(_appointments),
              onTap: (calendarTapDetails) {
                _atualizarEventosDoDia(calendarTapDetails.date!);
              },
            ),
          ),
          _eventosDoDia.isEmpty
              ? Center(
                  child: Text('Nenhum evento para a data selecionada'),
                )
              : Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Eventos do Dia'),
                      ),
                      Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _eventosDoDia.length,
                        itemBuilder: (context, index) {
                          final evento = _eventosDoDia[index];
                          return ListTile(
                            title: Text(evento.subject),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _removerEvento(evento);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openCadastroEventoDialog(DateTime.now());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _openCadastroEventoDialog(DateTime dataSelecionada) {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Novo evento do dia :)'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Assunto',
                      ),
                      onChanged: (text) {
                        setState(() {
                          _assunto = text;
                        });
                      },
                    ),
                  ),
                  DateTimePickerWidget(
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    onTimeSelected: (time) {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                  ),
                  Text("Data : ${selectedDate?.toLocal()}"),
                  Text("Hora : ${selectedTime?.format(context)}"),
                  _buildCategorySection(),
                  const SizedBox(height: 8),
                  const CustomText(text: 'Prioridades'),
                  DropDownCategoria(),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Fecha o formulário
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (selectedDate != null && selectedTime != null) {
                  final startTime = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    selectedTime!.hour,
                    selectedTime!.minute,
                  );
                  final endTime = startTime.add(const Duration(hours: 1));

                  final novoEvento = Evento(
                    _assunto,
                    startTime,
                    endTime,
                    false, // Defina diaTodo conforme necessário
                  );

                  // Adicione o novo evento à lista de appointments
                  _appointments.add(Appointment(
                    startTime: startTime,
                    endTime: endTime,
                    subject: _assunto,
                    color: Colors.red,
                  ));

                  // Print para verificar o novo evento antes de salvá-lo
                  print('Novo Evento: ${novoEvento.nomeEvento}');

                  // Salve o evento usando o EventoController
                  await EventoController().salvarEvento(novoEvento);

                  // Atualize a lista de eventos do dia
                  _atualizarEventosDoDia(selectedDate!);

                  // Atualize o calendário para mostrar a data selecionada
                  _calendarController.selectedDate = selectedDate!;

                  // Fecha o formulário
                  Navigator.pop(context);

                  // Após adicionar um novo evento, carregue novamente os eventos salvos
                  _carregarEventosSalvos();
                }
              },
              child: Text('Cadastrar'),
            ),
          ],
        );
      },
    );
  }

  void _atualizarEventosDoDia(DateTime dataSelecionada) {
    _eventosDoDia = _appointments.where((evento) {
      final eventoDate = evento.startTime;
      return eventoDate.year == dataSelecionada.year &&
          eventoDate.month == dataSelecionada.month &&
          eventoDate.day == dataSelecionada.day;
    }).toList();
    setState(() {}); // Atualiza a interface do usuário
  }

  void _removerEvento(Appointment evento) {
    _appointments.remove(evento);
    _atualizarEventosDoDia(_calendarController.selectedDate!);
  }

  CategoriaController _categoriaController = Get.put(CategoriaController());

  Widget _buildCategorySection() {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const CustomText(text: 'Categorias'),
          ),
        ),
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BotaoPrioridade(
                label: 'Trabalho',
                color: Colors.green,
                selected: _categoriaController.prioridadeSelecionada.value ==
                    'Trabalho',
                onPressed: () =>
                    _categoriaController.atualizarPrioridade('Trabalho'),
              ),
              BotaoPrioridade(
                label: 'Faculdade',
                color: Colors.purpleAccent,
                selected: _categoriaController.prioridadeSelecionada.value ==
                    'Faculdade',
                onPressed: () =>
                    _categoriaController.atualizarPrioridade('Faculdade'),
              ),
              BotaoPrioridade(
                label: 'Projetos',
                color: Colors.red,
                selected: _categoriaController.prioridadeSelecionada.value ==
                    'Projetos',
                onPressed: () =>
                    _categoriaController.atualizarPrioridade('Projetos'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//! WIDGETS

//!MODEL 1
class ReuniaoDataSource extends CalendarDataSource {
  ReuniaoDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class CategoriaController extends GetxController {
  RxString prioridadeSelecionada = ''.obs;

  void atualizarPrioridade(String novaPrioridade) {
    prioridadeSelecionada.value = novaPrioridade;
  }
}

//! MODEL 2
class Evento {
  String nomeEvento;
  DateTime inicio;
  DateTime fim;
  bool diaTodo;

  Evento(this.nomeEvento, this.inicio, this.fim, this.diaTodo);

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      json['nomeEvento'],
      DateTime.parse(json['inicio']),
      DateTime.parse(json['fim']),
      json['diaTodo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nomeEvento': nomeEvento,
      'inicio': inicio.toIso8601String(),
      'fim': fim.toIso8601String(),
      'diaTodo': diaTodo,
    };
  }
}

class EventoController {
  final List<Evento> eventos = [];
  final String eventosKey = 'eventos_key';

  Future<void> carregarEventos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final eventosJson = prefs.getStringList(eventosKey) ?? [];

      eventos.clear();
      for (final eventoJson in eventosJson) {
        final eventoMap = json.decode(eventoJson) as Map<String, dynamic>;
        final evento = Evento.fromJson(eventoMap);
        eventos.add(evento);
      }
    } catch (e) {
      // Lidar com erros ao carregar eventos, se necessário
      print('Erro ao carregar eventos: $e');
    }
  }

  Future<void> salvarEvento(Evento evento) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final eventosJson = prefs.getStringList(eventosKey) ?? [];

      final eventoJson =
          json.encode(evento.toJson()); // Convertendo o evento para JSON

      eventosJson.add(eventoJson);

      await prefs.setStringList(eventosKey, eventosJson);
    } catch (e) {
      // Lidar com erros ao salvar eventos, se necessário
      print('Erro ao salvar evento: $e');
    }
  }

  Future<void> removerEvento(Evento evento) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final eventosJson = prefs.getStringList(eventosKey) ?? [];

      final eventoJson =
          json.encode(evento.toJson()); // Convertendo o evento para JSON

      eventosJson.remove(eventoJson);

      await prefs.setStringList(eventosKey, eventosJson);
    } catch (e) {
      // Lidar com erros ao remover eventos, se necessário
      print('Erro ao remover evento: $e');
    }
  }
}
