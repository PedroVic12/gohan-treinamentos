import 'package:flutter/material.dart';

class TableCustom extends StatelessWidget {
  final List<String> columns;
  final List<List<String>> rows;

  TableCustom({required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.redAccent),
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
              decoration: BoxDecoration(color: Colors.white),
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
      ),
    );
  }
}
