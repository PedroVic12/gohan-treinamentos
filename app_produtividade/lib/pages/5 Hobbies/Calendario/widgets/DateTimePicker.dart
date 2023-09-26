import 'package:flutter/material.dart';

class DateTimePickerWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final Function(TimeOfDay) onTimeSelected;

  DateTimePickerWidget(
      {Key? key, required this.onDateSelected, required this.onTimeSelected})
      : super(key: key);

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    Future _selectDate() async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030));

      if (picked != null) {
        widget.onDateSelected(picked);
      }
    }

    Future _selectTime() async {
      final TimeOfDay? picked =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (picked != null) {
        widget.onTimeSelected(picked);
      }
    }

    return Flexible(
      child: Container(
        width: 350,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.timeline),
          TextButton(
              onPressed: () {
                _selectDate();
              },
              child: const Text('Dia')),
          const Icon(Icons.lock_clock),
          TextButton(
              onPressed: () {
                _selectTime();
              },
              child: const Text('Horário')),
        ]),
      ),
    );
  }
}
