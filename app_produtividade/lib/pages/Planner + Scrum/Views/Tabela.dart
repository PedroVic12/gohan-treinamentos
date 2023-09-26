import 'package:flutter/material.dart';

class TabularWidget extends StatelessWidget {
  final List<String> columns;
  final List<List<String>> rows;

  TabularWidget({required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.black), // Adicionar borda preta à tabela
      ),
      child: DataTable(
        columnSpacing: 20.0, // Espaçamento entre colunas
        columns: columns.map((col) {
          return DataColumn(
            label: Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.grey, // Cor de fundo cinza para as colunas
              child: Text(
                col,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Cor do texto das colunas
                ),
              ),
            ),
          );
        }).toList(),
        rows: rows.map((row) {
          return DataRow(
            cells: row.map((cell) {
              return DataCell(
                Text(
                  cell,
                  style: TextStyle(
                    fontSize: 14.0, // Tamanho da fonte das células
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
