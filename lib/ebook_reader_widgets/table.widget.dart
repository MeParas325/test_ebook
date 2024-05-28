import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  final List<String> tableHead;
  final List<List<String>> tableRow;
  final double headFontSize;
  final double rowFontSize;
  const TableWidget({
    Key? key,
    required this.tableHead,
    required this.tableRow,
    this.headFontSize = 16,
    this.rowFontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(10.0),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const {
          0: FlexColumnWidth(2.0), // Adjust column widths as needed
          1: FlexColumnWidth(2.0),
          2: FlexColumnWidth(2.0),
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(color: Colors.blue),
            children: tableHead.map((header) {
              return TableCell(
                
                child: Center(
                  child: Text(
                    header,
                    style: TextStyle(
                      fontSize: headFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          ...tableRow.map((row) {
            return TableRow(
              children: row.map((cell) {
                return TableCell(
                  child: Center(
                    child: Text(
                      cell,
                      style: TextStyle(
                        fontSize: rowFontSize,
                      ),
                    ),
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
