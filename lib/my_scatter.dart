import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/scatter_data.dart';

class MyScatter extends StatefulWidget {
  const MyScatter({super.key});

  @override
  State<StatefulWidget> createState() => _MyScatterState();
}

class IndexedScatterSpot extends ScatterSpot {
  IndexedScatterSpot(
    super.x,
    super.y,
    this.index,
    this.threshold, {
    // bool? show,
    // FlDotPainter? dotPainter,
    super.show,
    super.dotPainter,
  });

  final int index;
  final double? threshold;
}

class _MyScatterState extends State {
  int touchedIndex = -1;

  // (x, y, size)
  final List<(double, double, double)> dataa = [
    (0.5, 0.4, 4.0),
    (0.6, 0.1, 12.0),
    (0.9, 0.5, 8.0),
  ];

  final List<int> _selectedSpots = <int>[];
  late final List<IndexedScatterSpot> _scatterSpotList;

  @override
  void initState() {
    super.initState();
    _setData();
  }

  void _setData() {
    // final List<Map<String, double?>> dataaa = data;
    final List<Map<String, double?>> dataaa = data2;

    final List<IndexedScatterSpot> list = <IndexedScatterSpot>[];
    for (int i = 0; i < dataaa.length; i++) {
      final Map<String, double?> element = dataaa[i];
      list.add(
        IndexedScatterSpot(
          element['fpr']!,
          element['tpr']!,
          i,
          element['threshold'],
          dotPainter: FlDotCirclePainter(
            color: Colors.teal,
            radius: 5,
          ),
        ),
      );
    }

    _scatterSpotList = list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1),
        // color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.all(10),
      // padding: const EdgeInsets.only(top: 80),
      width: 500,
      height: 600,
      child: AspectRatio(
        aspectRatio: 1.2,
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: _scatterSpotList,
            minX: 0.0,
            maxX: 1.01,
            minY: 0.0,
            maxY: 1.01,
            gridData: FlGridData(
              // show: true,
              // drawVerticalLine: true,
              // drawHorizontalLine: true,
              horizontalInterval: 0.1,
              verticalInterval: 0.2,
              getDrawingHorizontalLine: (double value) {
                return FlLine(
                  color: Colors.grey.shade200,
                  strokeWidth: 2,
                );
              },
              getDrawingVerticalLine: (double value) {
                return FlLine(
                  color: Colors.grey.shade200,
                  strokeWidth: 2,
                );
              },
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                left: BorderSide(color: Colors.grey.shade200, width: 2),
                top: const BorderSide(color: Colors.transparent),
                right: const BorderSide(color: Colors.transparent),
                bottom: BorderSide(color: Colors.grey.shade200, width: 2),
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(),
              topTitles: const AxisTitles(),
              bottomTitles: AxisTitles(
                axisNameWidget: const Text('FPR'),
                axisNameSize: 25,
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 0.1,
                  maxIncluded: false,
                  // minIncluded: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text(
                      value.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    );
                  },
                  // reservedSize: 30,
                ),
              ),
              leftTitles: AxisTitles(
                axisNameWidget: const RotatedBox(
                  quarterTurns: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('T'),
                      Text('P'),
                      Text('R'),
                    ],
                  ),
                ),
                axisNameSize: 25,
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 0.2,
                  maxIncluded: false,
                  // minIncluded: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text(
                      value.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    );
                  },
                  // reservedSize: 30,
                ),
              ),
            ),
            // showingTooltipIndicators: _selectedSpots,
            // scatterLabelSettings: ScatterLabelSettings(
            //   showLabel: true,
            //   // getLabelFunction: (int spotIndex, ScatterSpot spot) => spot.size.width.toString(),
            //   // getLabelFunction: (int spotIndex, ScatterSpot spot) =>_scatterSpotList[spotIndex].,
            //   getLabelFunction: (int spotIndex, ScatterSpot spot) => spotIndex.toString(),
            //   // getLabelTextStyleFunction: ,
            //   textDirection: TextDirection.rtl,
            // ),
            scatterTouchData: ScatterTouchData(
              enabled: true,
              handleBuiltInTouches: true,
              // mouseCursorResolver: (FlTouchEvent touchEvent, ScatterTouchResponse? response) {
              //   return response == null || response.touchedSpot == null ? MouseCursor.defer : SystemMouseCursors.click;
              // },
              touchTooltipData: ScatterTouchTooltipData(
                getTooltipColor: (ScatterSpot touchedBarSpot) => const Color(0xFFF5F5F5),
                tooltipBorder: const BorderSide(color: Color(0xFF333333)),
                tooltipPadding: const EdgeInsets.all(8),
                tooltipRoundedRadius: 8,
                // fitInsideVertically: true,
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                maxContentWidth: 300,
                getTooltipItems: (ScatterSpot scatterSpot) {
                  if (scatterSpot is IndexedScatterSpot) {
                    String text = '';
                    text += '• FPR: ${scatterSpot.x}';
                    text += '\n';
                    text += '• TPR: ${scatterSpot.y}';
                    text += '\n';
                    text += '• Threshold: ${scatterSpot.threshold ?? 0}';

                    return ScatterTooltipItem(
                      text,
                      textAlign: TextAlign.left,
                    );
                  }

                  return null;
                },
              ),
              // touchCallback: (FlTouchEvent event, ScatterTouchResponse? touchResponse) {
              //   if (touchResponse == null || touchResponse.touchedSpot == null) {
              //     return;
              //   }

              //   if (event is FlTapUpEvent) {
              //     final int sectionIndex = touchResponse.touchedSpot!.spotIndex;
              //     setState(() {
              //       if (_selectedSpots.contains(sectionIndex)) {
              //         _selectedSpots.remove(sectionIndex);
              //       } else {
              //         _selectedSpots.add(sectionIndex);
              //       }
              //     });
              //   }
              // },
            ),
          ),
        ),
      ),
    );
  }
}
