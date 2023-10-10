import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/DateTimePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PaginaCalendario extends StatefulWidget {
  @override
  _PaginaCalendarioState createState() => _PaginaCalendarioState();
}

class _PaginaCalendarioState extends State<PaginaCalendario> {
  List<Evento> reunioes = <Evento>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [_buildCalendar(), _buildEventList(), BlurGlassCardWidget()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _adicionarEvento(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCalendar() {
    return SfCalendar(
      view: CalendarView.month,
      dataSource: FonteDadosReuniao(reunioes),
      onTap: (details) {
        print('Data selecionada: ${details.date}');
        if (details.appointments != null && details.appointments!.isNotEmpty) {
          setState(() {
            final events = details.appointments as List<Evento>;
            reunioes =
                events.where((e) => e.inicio.day == details.date!.day).toList();
          });
          print('Eventos no dia selecionado: ${reunioes.length}');
        } else {
          print('Sem eventos no dia selecionado.');
        }
      },
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemCount: reunioes.length,
        itemBuilder: (context, index) {
          final event = reunioes[index];
          return ListTile(
            title: Text(event.nomeEvento),
            subtitle: Text('${event.inicio} - ${event.fim}'),
          );
        },
      ),
    );
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
              mainAxisSize: MainAxisSize.min, // Set to min to prevent overflow
              children: [
                TextField(
                  controller: eventNameController,
                  decoration: InputDecoration(hintText: 'Nome do Evento'),
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
                // Optional: Display selected date and time for user confirmation
                Text("Data : ${selectedDate?.toLocal()}"),
                Text("Hora : ${selectedTime?.format(context)}"),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (selectedDate != null && selectedTime != null) {
                final inicio = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    selectedTime!.hour,
                    selectedTime!.minute);
                final fim = inicio.add(Duration(hours: 2));
                setState(() {
                  reunioes.add(Evento(eventNameController.text, inicio, fim,
                      Colors.blue, false));
                });
                print(
                    'Evento adicionado: ${eventNameController.text} em $inicio');
              } else {
                print(
                    'Data ou hora não selecionada. Não foi possível adicionar o evento.');
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}

class Evento {
  Evento(this.nomeEvento, this.inicio, this.fim, this.corFundo, this.diaTodo);
  String nomeEvento;
  DateTime inicio;
  DateTime fim;
  Color corFundo;
  bool diaTodo;
}

class FonteDadosReuniao extends CalendarDataSource {
  FonteDadosReuniao(List<Evento> fonte) {
    appointments = fonte;
  }
  @override
  DateTime getStartTime(int index) => appointments![index].inicio;
  @override
  DateTime getEndTime(int index) => appointments![index].fim;
  @override
  String getSubject(int index) => appointments![index].nomeEvento;
  @override
  Color getColor(int index) => appointments![index].corFundo;
  @override
  bool isAllDay(int index) => appointments![index].diaTodo;
}

class BlurGlassCardWidget extends StatelessWidget {
  const BlurGlassCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
        height: 200,
        width: 350,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.40),
            Colors.white.withOpacity(0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.60),
            Colors.white.withOpacity(0.10),
            Colors.purpleAccent.withOpacity(0.05),
            Colors.purpleAccent.withOpacity(0.60),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.39, 0.40, 1.0],
        ),
        blur: 20,
        borderRadius: BorderRadius.circular(24.0),
        borderWidth: 1.0,
        elevation: 3.0,
        isFrostedGlass: true,
        shadowColor: Colors.purple.withOpacity(0.20),
        child: Center(
          child: CupertinoListTile(
            title: Text('Ola mundo'),
          ),
        ));
  }
}
