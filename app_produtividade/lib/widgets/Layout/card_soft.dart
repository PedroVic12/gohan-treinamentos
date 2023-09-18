import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  final String titulo;
  final Color card_color;
  final List<String> items;

  const SimpleCard(
      {super.key,
      required this.titulo,
      required this.card_color,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          color: card_color,
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    //color: Colors.purple,
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            items[index],
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
