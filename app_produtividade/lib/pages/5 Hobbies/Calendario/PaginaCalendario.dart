import 'package:app_produtividade/pages/5%20Hobbies/Calendario/controller/ControleCalendario.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/BotaoPrioridade.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DateTimePicker.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DropDownCategorias.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:app_produtividade/widgets/Layout/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PaginaCalendario extends StatefulWidget {
  @override
  _PaginaCalendarioState createState() => _PaginaCalendarioState();
}

class _PaginaCalendarioState extends State<PaginaCalendario> {
  List<Evento> reunioes = <Evento>[];
  DateTime? dataSelecionada;
  CalendarioController calendario = Get.put(CalendarioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          _buildCalendar(),
          _buildEventList(),
          // BlurGlassCardWidget(
          // eventos: reunioes,
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
            });

            if (details.appointments != null &&
                details.appointments!.isNotEmpty) {
              setState(() {
                final events = details.appointments as List<Evento>;
                reunioes = events
                    .where((e) => e.inicio.day == details.date!.day)
                    .toList();
              });
              print('Eventos no dia selecionado: ${reunioes.length}');
            } else {
              setState(() {
                reunioes = [];
              });
              print('Sem eventos no dia selecionado.');
            }
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
          if (reunioes.isEmpty) Text('Nenhum evento encontrado.'),
          Expanded(
            child: ListView.builder(
              itemCount: reunioes.length,
              itemBuilder: (context, index) {
                final event = reunioes[index];
                return Card(
                  child: ListTile(
                    title: Text(event.nomeEvento),
                    subtitle: Text('${event.inicio} - ${event.fim}'),
                  ),
                );
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

                // Adicione o evento ao controlador
                calendario.adicionarReuniao(
                  selectedDate!,
                  eventNameController.text,
                );

                // Exiba uma Snackbar quando o evento for cadastrado com sucesso
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Evento cadastrado com sucesso!'),
                    duration: Duration(
                        seconds: 2), // Opcional: Defina a duração da Snackbar
                  ),
                );

                // Imprima todas as informações do evento
                printEventDetails(Evento(
                  eventNameController.text,
                  inicio,
                  fim,
                  Colors.blue, // Defina a cor de fundo desejada
                  false, // Defina se é o dia todo conforme necessário
                ));
              } else {
                print(
                  'Data ou hora não selecionada. Não foi possível adicionar o evento.',
                );
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
