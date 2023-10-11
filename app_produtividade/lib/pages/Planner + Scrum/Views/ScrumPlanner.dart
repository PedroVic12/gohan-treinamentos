import 'package:flutter/material.dart';

class ScrumPlanner extends StatelessWidget {
  final List<String> headers;
  final List<String> sideLabels;
  final int crossAxisCount;

  ScrumPlanner({
    required this.headers,
    required this.sideLabels,
    this.crossAxisCount = 4,
  })  : assert(headers.length == crossAxisCount),
        assert(sideLabels.length == crossAxisCount);

  @override
  Widget build(BuildContext context) {
    double headerHeight = 150.0; // Altura do header
    double spaceHeight = 250.0; // Altura do SizedBox
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
// Ajustar a largura do sideLabels com base no tamanho da tela
    double sideLabelWidth = screenWidth < 600 ? 80.0 : 150.0;

    double availableHeight = screenHeight - (headerHeight + spaceHeight);

    double itemHeight =
        availableHeight / crossAxisCount; // Dividindo igualmente

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Column(
            children: sideLabels
                .map((text) => _buildSideItem(text, itemHeight, sideLabelWidth))
                .toList(),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  children:
                      headers.map((text) => _buildHeaderItem(text)).toList(),
                ),
                SizedBox(height: 8),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (itemHeight * crossAxisCount), // Ajusta a proporção
                  ),
                  itemBuilder: (context, index) {
                    return _buildGridItem(index);
                  },
                  itemCount: crossAxisCount * crossAxisCount,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildHeaderItem(String text) {
  return Expanded(
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(text),
      ),
    ),
  );
}

Widget _buildSideItem(String text, double height, double sideLabelWidth) {
  return Column(
    children: [
      Container(
        height: height,
        width: sideLabelWidth, // Usando a largura ajustada
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: sideLabelWidth < 100 ? 13.0 : 16.0,
                fontWeight: FontWeight.bold // Ajustando a fonte
                ),
          ),
        ),
      ),
      SizedBox(
        height: 25,
      ),
    ],
  );
}

Widget _buildGridItem(int index) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
    child: Center(
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(4),
              child: Text('Item de trabalho do Scrum $index'))),
    ),
  );
}
