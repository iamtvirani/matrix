// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Cross Axis Fill'),
//         ),
//         body: const StartScreen(),
//       ),
//     );
//   }
// }
//
// // class CrossAxisGrid extends StatefulWidget {
// //   const CrossAxisGrid({super.key});
// //
// //   @override
// //   _CrossAxisGridState createState() => _CrossAxisGridState();
// // }
// //
// // class _CrossAxisGridState extends State<CrossAxisGrid> {
// //   late List<List<bool>> grid;
// //
// //   int matrixSize = 8;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     updateGrid();
// //   }
// //
// //   void updateGrid() {
// //     setState(() {
// //       grid = List.generate(matrixSize, (_) => List.generate(matrixSize, (_) => false));
// //     });
// //   }
// //
// //   void fillCells(int row, int col) {
// //     setState(() {
// //       for (int i = 0; i < grid.length; i++) {
// //         grid[row][i] = true; // fill cells in the same row
// //         grid[i][col] = true; // fill cells in the same column
// //         if (row - i >= 0 && row - i < grid.length && col - i >= 0 && col - i < grid.length) {
// //           grid[row - i][col - i] = true; // fill cells in the top-left to bottom-right diagonal
// //         }
// //         if (row + i >= 0 && row + i < grid.length && col - i >= 0 && col - i < grid.length) {
// //           grid[row + i][col - i] = true; // fill cells in the bottom-left to top-right diagonal
// //         }if (row - i >= 0 && row - i < grid.length && col - i >= 0 && col - i < grid.length) {
// //           grid[row - i][col + i] = true; // fill cells in the bottom-left to top-right diagonal
// //         }
// //         if (row + i >= 0 && row + i < grid.length && col + i >= 0 && col + i < grid.length) {
// //           grid[row + i][col + i] = true; // fill cells in the bottom-left to top-right diagonal
// //         }
// //       }
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: <Widget>[
// //           TextField(
// //             decoration: InputDecoration(labelText: 'Enter matrix size'),
// //             keyboardType: TextInputType.number,
// //             onChanged: (value) {
// //               setState(() {
// //                 matrixSize = int.tryParse(value) ?? 5;
// //               });
// //             },
// //           ),
// //           ElevatedButton(
// //             onPressed: () => updateGrid(),
// //             child: Text('Display'),
// //           ),
// //           SizedBox(height: 20),
// //           if (grid != null)
// //             GridView.builder(
// //               shrinkWrap: true,
// //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: matrixSize,
// //               ),
// //               itemCount: matrixSize * matrixSize,
// //               itemBuilder: (context, index) {
// //                 int row = index ~/ matrixSize;
// //                 int col = index % matrixSize;
// //                 return GestureDetector(
// //                   onTap: grid[row][col] ? null : () => fillCells(row, col),
// //                   child: Container(
// //                     decoration: BoxDecoration(
// //                       border: Border.all(),
// //                       color: grid[row][col] ? Colors.grey : Colors.white,
// //                     ),
// //                     child: Center(
// //                       child: Text(
// //                         '(${row + 1}, ${col + 1})',
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// // }
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spiral Matrix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpiralMatrix(),
    );
  }
}

class SpiralMatrix extends StatelessWidget {
  final int rows = 7;
  final int cols = 7;

  List<List<int>> generateSpiralMatrix(int rows, int cols) {
    List<List<int>> matrix = List.generate(rows, (index) => List<int>.filled(cols, 0));

    int top = 0;
    int bottom = rows - 1;
    int left = 0;
    int right = cols - 1;

    int counter = 1;

    while (top <= bottom && left <= right) {
      // Traverse from left to right
      for (int i = left; i <= right; i++) {
        matrix[top][i] = counter++;
      }
      top++;

      // Traverse from top to bottom
      for (int i = top; i <= bottom; i++) {
        matrix[i][right] = counter++;
      }
      right--;

      // Traverse from right to left
      if (top <= bottom) {
        for (int i = right; i >= left; i--) {
          matrix[bottom][i] = counter++;
        }
        bottom--;
      }

      // Traverse from bottom to top
      if (left <= right) {
        for (int i = bottom; i >= top; i--) {
          matrix[i][left] = counter++;
        }
        left++;
      }
    }

    return matrix;
  }

  @override
  Widget build(BuildContext context) {
    List<List<int>> spiralMatrix = generateSpiralMatrix(rows, cols);

    return Scaffold(
      appBar: AppBar(
        title: Text('Spiral Matrix'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 0.0,
              columns: List.generate(
                cols,
                    (index) => DataColumn(label: Text('')),
              ),
              rows: List.generate(
                rows,
                    (rowIndex) => DataRow(
                  cells: List.generate(
                    cols,
                        (colIndex) => DataCell(
                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Text(
                          spiralMatrix[rowIndex][colIndex].toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}