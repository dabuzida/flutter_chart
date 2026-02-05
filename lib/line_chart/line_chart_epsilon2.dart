import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartEpsilon2 extends StatefulWidget {
  const LineChartEpsilon2({super.key});

  @override
  State<LineChartEpsilon2> createState() => _LineChartEpsilon2State();
}

class _LineChartEpsilon2State extends State<LineChartEpsilon2> {
  final double _minY = 0;
  final double _maxY = 1.01;
  int? touchedIndex;

  int? selectedIndex;

  final double _minX = 0;
  final double _maxX = 1.01;

  final Map<FlSpot, num?> _thresholdBySpot = <FlSpot, num?>{}; // key: (fpr, tpr), value: threshold
  final List<LineChartBarData> _lineBarsData = <LineChartBarData>[];

  @override
  void initState() {
    super.initState();
    _thresholdBySpot.addAll(<FlSpot, num?>{
      const FlSpot(0.1, 0.4): 0.1,
      const FlSpot(0.2, 0.7): 0.9,
      const FlSpot(0.3, 0.9): 0.5,
      const FlSpot(0.5, 0.3): 0.7,
    });

    _lineBarsData.addAll(
      <LineChartBarData>[
        LineChartBarData(
          show: true,
          spots: _thresholdBySpot.keys.toList(),
          isCurved: false,
          barWidth: 2,
          color: Colors.indigo.shade300,
          dotData: const FlDotData(show: true),
        ),
      ],
    );
  }

  Widget _buildUITooltip() {
    return Tooltip(
      // `````
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Color.fromRGBO(0, 0, 0, 0.08),
      ),
      richMessage: WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('tpr: 민감도 - 치매인 사람 치매 판정'),
              Text('tpr: 민감도 - 치매인 사람 치매 판정'),
              Text('tpr: 민감도 - 치매인 사람 치매 판정'),
              Text('tpr: 민감도 - 치매인 사람 치매 판정'),
              Text('tpr: 민감도 - 치매인 사람 치매 판정'),
              Text('tpr: 민감도 - 치매인 사람 치매 판정'),
              Text('tpr: 민감도 - 치매인 사람 치매 판정'),
              Text('tpr: 민감도 - 치매인 사람 치매 판정'),
            ],
          ),
        ),
      ),
      child: const Icon(Icons.info_outline),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUITooltip(),
        AspectRatio(
          aspectRatio: 2.5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (LineBarSpot touchedSpot) => const Color(0xFFF5F5F5),
                    tooltipRoundedRadius: 8,
                    // fitInsideVertically: true,
                    // fitInsideHorizontally: true,
                    maxContentWidth: 220,
                    tooltipPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // 폭 강제 증가
                    getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                      _thresholdBySpot;
                      _thresholdBySpot[lineBarsSpot[0].spotIndex];
                      lineBarsSpot[0].spotIndex;

                      return lineBarsSpot.map(
                        (LineBarSpot lineBarSpot) {
                          // 1
                          String text = '';
                          text += 'fpr: ${lineBarSpot.x}';
                          text += '\n';
                          text += 'tpr: ${lineBarSpot.y}';
                          text += '\n';
                          text += 'threshold: ${_thresholdBySpot.values.toList()[lineBarSpot.spotIndex]}';

                          // 2
                          // _thresholdBySpot[lineBarsSpot[0].spotIndex];

                          // final int indexHovered = lineBarsSpot[0].spotIndex;
                          // final List<FlSpot> spotList = _thresholdBySpot.keys.toList();
                          // final List<num?> thresholdList = _thresholdBySpot.values.toList();

                          // //
                          // String text = '';
                          // text += 'fpr: ${spotList[indexHovered].x}';
                          // text += '\n';
                          // text += 'tpr: ${spotList[indexHovered].y}';
                          // text += '\n';
                          // text += 'threshold: ${thresholdList[indexHovered]}';

                          return LineTooltipItem(
                            text,
                            const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                              // color: Colors.orange,
                            ),
                            textAlign: TextAlign.left,
                            children: [],
                          );
                        },
                      ).toList();
                    },
                  ),
                  getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map(
                      (int index) {
                        return const TouchedSpotIndicatorData(
                          FlLine(color: Colors.indigo, strokeWidth: 0.5),
                          FlDotData(show: false),
                        );
                      },
                    ).toList();
                  },
                ),
                minX: _minX,
                maxX: _maxX,
                minY: _minY,
                maxY: _maxY,
                lineBarsData: _lineBarsData,
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 0.1,
                      maxIncluded: false,
                      minIncluded: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        // 22222
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
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 0.2,
                      maxIncluded: false,
                      minIncluded: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        // 33333
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
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    left: BorderSide(color: Colors.grey.shade200, width: 2),
                    top: const BorderSide(color: Colors.transparent),
                    right: const BorderSide(color: Colors.transparent),
                    bottom: BorderSide(color: Colors.grey.shade200, width: 2),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
