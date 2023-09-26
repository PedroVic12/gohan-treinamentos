


import 'package:flutter/material.dart';

class CircleCheckBox extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final bool? tristate;

  const CircleCheckBox({
    Key? key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.checkColor,
    this.tristate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(style: BorderStyle.solid, width: 2),
        color: Colors.blueGrey,
      ),
      child: Checkbox(
        value: value ?? false, // Defina como falso se for nulo
        onChanged: onChanged,
        activeColor: activeColor,
        checkColor: checkColor,
        tristate: tristate ?? false,
      ),
    );
  }
}
