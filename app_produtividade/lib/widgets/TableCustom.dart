import 'package:flutter/material.dart';

class TableCustom extends StatelessWidget {
  final List<String> columns;
  final List<List<String>> rows;

  TableCustom({required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[300]),
          children: columns.map((col) {
            return TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  col,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        ...rows.map((row) {
          return TableRow(
            children: row.map((cell) {
              return TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cell),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ],
    );
  }
}
