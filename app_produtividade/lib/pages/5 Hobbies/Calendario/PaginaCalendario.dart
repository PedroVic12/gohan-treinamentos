import 'package:app_produtividade/pages/5%20Hobbies/Calendario/CalendarWidget.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/controller/ControleCalendario.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/controller/Evento.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/BotaoPrioridade.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DateTimePicker.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DropDownCategorias.dart';
import 'package:app_produtividade/widgets/BotaoNavega%C3%A7ao.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:app_produtividade/widgets/Layout/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class PaginaCalendario extends StatefulWidget {
  @override
  _PaginaCalendarioState createState() => _PaginaCalendarioState();
}

class _PaginaCalendarioState extends State<PaginaCalendario> {
  List<Evento> reunioes = <Evento>[];
  DateTime? dataSelecionada;
  CalendarioController calendario = Get.put(CalendarioController());
  FonteDadosReuniao fonteDadosReuniao = FonteDadosReuniao([]);
  Evento? _eventoSelecionado; // Propriedade para rastrear o evento selecionado
  List<Evento> _eventos = <Evento>[];
  final EventoService eventoService = EventoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          _buildCalendar(),
          _buildEventList(),

          //BlurGlassCardWidget(
          //eventos: fonteDadosReuniao.appointments.toList(),
          //)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _adicionarEvento(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white70,
        child: SfCalendar(
          view: CalendarView.month,
          dataSource: FonteDadosReuniao(reunioes),
          onTap: (details) {
            print('Data selecionada: ${details.date}');
            setState(() {
              dataSelecionada = details.date;
              if (details.appointments != null &&
                  details.appointments!.isNotEmpty) {
                final events = details.appointments as List<Evento>;
                reunioes = events
                    .where((e) => e.inicio.day == details.date!.day)
                    .toList();
                if (reunioes.isNotEmpty) {
                  // Defina o evento selecionado quando houver eventos
                  _eventoSelecionado = reunioes.first;
                }
              } else {
                reunioes = [];
                _eventoSelecionado = null; // Limpe o evento selecionado
              }
            });
            print('Eventos no dia selecionado: ${reunioes.length}');
          },
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: Column(
        children: [
          if (dataSelecionada != null)
            Text(
                'Eventos em ${dataSelecionada!.day}/${dataSelecionada!.month}/${dataSelecionada!.year}'),
          if (_eventos.isEmpty) Text('Nenhum evento encontrado.'),
          Expanded(
            child: ListView.builder(
              itemCount: _eventos.length, // Usar a lista _eventos aqui
              itemBuilder: (context, index) {
                final event = _eventos[index]; // Usar a lista _eventos aqui
                // Verificar se o evento pertence ao dia selecionado
                if (event.inicio.year == dataSelecionada!.year &&
                    event.inicio.month == dataSelecionada!.month &&
                    event.inicio.day == dataSelecionada!.day) {
                  final dateFormat = DateFormat('dd/MM/yyyy');
                  final timeFormat = DateFormat('HH:mm');
                  final formattedStartDate = dateFormat.format(event.inicio);
                  final formattedStartTime = timeFormat.format(event.inicio);
                  final formattedEndDate = dateFormat.format(event.fim);
                  final formattedEndTime = timeFormat.format(event.fim);
                  final formattedDateTime =
                      'Data: $formattedStartDate \nHorario: $formattedStartTime até $formattedEndTime';

                  return Card(
                    child: ListTile(
                      title: Text('Evento: ${event.nomeEvento}'),
                      subtitle: Text(formattedDateTime),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Remova o evento da lista _eventos
                          setState(() {
                            _eventos.removeAt(index);
                          });

                          // Remova o evento também da fonte de dados e notifique o SfCalendar
                          fonteDadosReuniao.appointments?.remove(event);
                          fonteDadosReuniao.notifyListeners(
                              CalendarDataSourceAction.remove, [event]);
                        },
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink(); // Oculta eventos de outros dias
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(CalendarioController calendario) {
    return Column(
      children: [
        Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const CustomText(text: 'Categorias'),
        )),
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BotaoPrioridade(
                label: 'Trabalho',
                color: Colors.green,
                selected: calendario.prioridadeSelecionada.value == 'Trabalho',
                onPressed: () => calendario.atualizarPrioridade('Trabalho'),
              ),
              BotaoPrioridade(
                label: 'Faculdade',
                color: Colors.purpleAccent,
                selected: calendario.prioridadeSelecionada.value == 'Faculdade',
                onPressed: () => calendario.atualizarPrioridade('Faculdade'),
              ),
              BotaoPrioridade(
                label: 'Projetos',
                color: Colors.red,
                selected: calendario.prioridadeSelecionada.value == 'Projetos',
                onPressed: () => calendario.atualizarPrioridade('Projetos'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void printEventDetails(Evento evento) {
    print('Nome do Evento: ${evento.nomeEvento}');
    print('Data de Início: ${evento.inicio}');
    print('Data de Fim: ${evento.fim}');
    print('Cor de Fundo: ${evento.corFundo}');
    print('Dia Todo: ${evento.diaTodo}');
  }

  void _adicionarEvento(BuildContext context) {
    final eventNameController = TextEditingController();
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar Evento'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: TextField(
                    controller: eventNameController,
                    decoration: InputDecoration(hintText: 'Nome do Evento'),
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
                _buildCategorySection(calendario),
                const SizedBox(height: 8),
                const CustomText(text: 'Prioridades'),
                DropDownCategoria(),
              ],
            );
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (selectedDate != null && selectedTime != null) {
                final inicio = DateTime(
                  selectedDate!.year,
                  selectedDate!.month,
                  selectedDate!.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                );
                final fim = inicio.add(Duration(hours: 2));

                // Adicione o evento usando a classe de serviço
                final evento = Evento(
                  eventNameController.text,
                  inicio,
                  fim,
                  Colors.blue,
                  false,
                );
                eventoService.adicionarEvento(evento);

                // Atualize o estado para exibir o novo evento
                setState(() {
                  _eventoSelecionado = evento;
                });
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
