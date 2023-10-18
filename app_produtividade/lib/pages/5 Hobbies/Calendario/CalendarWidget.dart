import 'package:app_produtividade/pages/5%20Hobbies/Calendario/controller/ControleCalendario.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/controller/Evento.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/BotaoPrioridade.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DateTimePicker.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DropDownCategorias.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:app_produtividade/widgets/Layout/CustomAppBar.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SfCalendar(
            controller: _calendarController,
            view: CalendarView.month,
            firstDayOfWeek: 6,
            dataSource: ReuniaoDataSource(_appointments),
            onTap: (calendarTapDetails) {
              _atualizarEventosDoDia(calendarTapDetails.date!);
            },
          ),
          _eventosDoDia.isEmpty
              ? Center(
                  child: Text('Nenhum evento para a data selecionada'),
                )
              : Expanded(
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.all(16),
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
          title: Text('Novo evento'),
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
                    Colors.red,
                    false, // Defina diaTodo conforme necessário
                  );

                  // Adicione o novo evento à lista de appointments
                  _appointments.add(Appointment(
                    startTime: startTime,
                    endTime: endTime,
                    subject: _assunto,
                    color: Colors.red,
                  ));

                  // Salve o evento usando o EventoController
                  await EventoController().salvarEvento(novoEvento);

                  // Atualize a lista de eventos do dia
                  _atualizarEventosDoDia(selectedDate!);

                  // Atualize o calendário para mostrar a data selecionada
                  _calendarController.selectedDate = selectedDate!;

                  // Fecha o formulário
                  Navigator.pop(context);
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
