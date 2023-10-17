import 'package:flutter/material.dart';

import '../../../../../widgets/Custom/CustomText.dart';
import '../../widgets/CicleCheckBox.dart';

class TaskBlock extends StatelessWidget {
  const TaskBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black, blurRadius: 8, spreadRadius: -7),
            ]),
        child: ListTile(
          leading: CircleCheckBox(
            value: true, // Defina o valor do checkbox (true, false ou null)
            onChanged: (newValue) {
              // Lógica para tratar a mudança de valor aqui
            },
            // Os outros parâmetros são opcionais
          ),
          title: CustomText(text: 'Hello'),
          subtitle: CustomText(
            text: "No Description",
          ),
          trailing: Container(
            height: 30,
            width: 90,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            child: Center(
                child: CustomText(
              text: 'High',
              color: Colors.white,
            )),
          ),
        ));
  }
}

class TaskLists extends StatelessWidget {
  const TaskLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CustomText(text: 'Hoje'), TaskBlock()],
    );
  }
}
