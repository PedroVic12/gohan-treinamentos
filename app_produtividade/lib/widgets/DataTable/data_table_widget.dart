import 'package:flutter/material.dart';

class TabelaGrid extends StatefulWidget {
  final List<String> columns;
  final List<List<String?>> rows;
  final Function(List<List<String?>>) onUpdate;

  const TabelaGrid({
    Key? key,
    required this.columns,
    required this.rows,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<TabelaGrid> createState() => _TabelaGridState();
}

class _TabelaGridState extends State<TabelaGrid> {
  bool isEditing = false;
  int editingRowIndex = -1;
  int editingCellIndex = -1;
  bool _showIcon = false;

  late List<List<String?>> tableData;

  @override
  void initState() {
    super.initState();
    tableData = List<List<String?>>.from(widget.rows);
  }

  void _updateTableData() {
    widget.onUpdate(tableData);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        sortColumnIndex: 0,
        sortAscending: true,
        border: TableBorder.all(),
        columns: [
          ...widget.columns.map(
            (column) => DataColumn(
              label: Container(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(column),
                ),
              ),
            ),
          ),
          DataColumn(
            label: Container(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Opções'),
              ),
            ),
          ),
        ],
        rows: widget.rows.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final row = entry.value;

            if (row.length != widget.columns.length) {
              final filledRow = List<String?>.filled(widget.columns.length, '');
              for (int i = 0; i < row.length; i++) {
                filledRow[i] = row[i] ?? '';
              }
              widget.rows[index] = filledRow;
            }

            return DataRow(
              color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (index.isEven) {
                    return Colors.white; // Linhas pares são brancas
                  } else {
                    return Colors.grey
                        .withOpacity(0.3); // Linhas ímpares são cinzas
                  }
                },
              ),
              cells: [
                ...row.asMap().entries.map((entry) {
                  final cellIndex = entry.key;
                  final cellValue = entry.value;

                  Color cellColor = Colors.transparent;

                  if (cellIndex != widget.columns.length - 1 &&
                      cellValue == 'TODO') {
                    cellColor = Colors
                        .yellow; // Se o valor for "TODO", torna a célula amarela
                  }

                  return DataCell(
                    Container(
                      color: cellColor,
                      child: Text(cellValue ?? ''),
                    ),
                  );
                }),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          print('Excluir item na linha $index');
                        },
                        icon: Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          print('Baixar arquivo na linha $index');
                        },
                        icon: Icon(Icons.file_download),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
