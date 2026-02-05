import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartEpsilon extends StatefulWidget {
  const LineChartEpsilon({super.key});

  @override
  State<LineChartEpsilon> createState() => _LineChartEpsilonState();
}

class _LineChartEpsilonState extends State<LineChartEpsilon> {
  final double _minY = 0;
  final double _maxY = 1.31;

  final double _minX = 0;
  final double _maxX = 1.01;

  final Map<FlSpot, num?> _thresholdBySpot = <FlSpot, num?>{}; // key: (fpr, tpr), value: threshold
  final Map<FlSpot, num?> _thresholdBySpotRendering = <FlSpot, num?>{}; // key: (fpr, tpr), value: threshold
  final Map<FlSpot, num?> _thresholdBySpot2 = <FlSpot, num?>{}; // key: (fpr, tpr), value: threshold

  final List<LineChartBarData> _lineBarsData = <LineChartBarData>[];
  final List<LineChartBarData> _lineBarsDataRendering = <LineChartBarData>[];

  final List<int> _showingTooltipOnSpots = <int>[];

  List<FlSpot> get _allSpots => const [
        FlSpot(0.0, 0),
        FlSpot(0.1, 0.5),
        FlSpot(0.2, 0.1),
        FlSpot(0.3, 0.5),
        FlSpot(0.4, 0.4),
        FlSpot(0.5, 0.4),
      ];

  @override
  void initState() {
    super.initState();
    // _allSpots;
    // _showingTooltipOnSpots;

    const double diffff = 0.000000000000001;
    // const double diffff = 0.00000000000000001;
    // const double diffff = 0.000000000000000001;
    // const double diffff = 0.0000000000000000001;
    // const double diffff = 0.00000000000000000001;
    // const double diffff = 0.000000000000000000001;
    // const double diffff = 0.0000000000000000000001;
    // const double diffff = 0.00000000000000000000001;

    _thresholdBySpotRendering.addAll(<FlSpot, num?>{
      const FlSpot(0.1, 0.4): 0.1,
      const FlSpot(0.2, 0.7): 0.9,
      const FlSpot(0.3, 0.9): 0.5,
      const FlSpot(0.5, 0.3): 0.7,
      // const FlSpot(0.5 + 0.000000000000001, 0.1): 0.8,
      const FlSpot(0.5 + diffff, 0.1): 0.8,
      const FlSpot(0.5 + diffff * 2, 0.1): 0.8,
      const FlSpot(0.5 + diffff * 3, 0.1): 0.8,
      const FlSpot(0.5 + diffff * 4, 0.1): 0.8,
      const FlSpot(0.5 + diffff * 5, 0.1): 0.8,
      const FlSpot(0.5 + diffff * 6, 0.1): 0.8,
      const FlSpot(0.5 + diffff * 7, 0.1): 0.8,
      const FlSpot(0.5 + diffff * 8, 0.1): 0.8,
      const FlSpot(0.5 + diffff * 9, 0.1): 0.8,
    });

    for (final Map<String, num?> element in data) {
      _thresholdBySpot2.addAll(
        <FlSpot, num?>{
          FlSpot(
            element['fpr']?.toDouble() ?? 0,
            element['tpr']?.toDouble() ?? 0,
          ): element['threshold']?.toDouble() ?? 0,
        },
      );
    }

    _thresholdBySpot.addAll({..._thresholdBySpot2}); //

    const double diff = 0.000000000000001;
    // const double diff = 0.0000000000000001;
    // double.minPositive;
    double prevX = 0;
    // for (final MapEntry<FlSpot, num?> element in _thresholdBySpot2.entries.toList()) {
    //   if (element.key.x == prevX) {
    //     _thresholdBySpotRendering.addAll({FlSpot(element.key.x + diff, element.key.y): element.value});
    //   } else {
    //     _thresholdBySpotRendering.addAll({FlSpot(element.key.x, element.key.y): element.value});
    //   }

    //   prevX = element.key.x;
    // }
    // _thresholdBySpot.addAll({..._thresholdBySpot2});

    _lineBarsData.addAll(
      <LineChartBarData>[
        LineChartBarData(
          // showingIndicators: [1, 2],
          // x축은 minX, maxX, interval, maxIncluded, minIncluded 와 연관
          //
          show: true,
          spots: _thresholdBySpot.keys.toList(),
          isCurved: false,
          barWidth: 2,
          color: Colors.indigo.shade300,
          dotData: const FlDotData(show: true),
        ),
      ],
    );

    _lineBarsDataRendering.addAll(
      <LineChartBarData>[
        LineChartBarData(
          show: true,
          spots: _thresholdBySpotRendering.keys.toList(),
          isCurved: false,
          barWidth: 2,
          color: Colors.indigo.shade300,
          dotData: const FlDotData(show: true),
        ),
      ],
    );

    final List<int> xx = List<int>.generate(_allSpots.length, (int index) => index, growable: false);
    _showingTooltipOnSpots.addAll(xx);
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: _showingTooltipOnSpots,
        spots: _allSpots,
        isCurved: false,
        barWidth: 1,
        color: Colors.red,
        dotData: const FlDotData(show: true),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2.5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: LineChart(
          LineChartData(
            // showingTooltipIndicators: _buildUITooltip(),
            // showingTooltipIndicators: <ShowingTooltipIndicators>[
            //   const ShowingTooltipIndicators(
            //     <LineBarSpot>[],
            //   ),
            // ],
            // showingTooltipIndicators: _showingTooltipOnSpots.map(
            //   (int index) {
            //     return ShowingTooltipIndicators(
            //       <LineBarSpot>[
            //         LineBarSpot(
            //           tooltipsOnBar,
            //           lineBarsData.indexOf(tooltipsOnBar),
            //           tooltipsOnBar.spots[index],
            //         ),
            //       ],
            //     );
            //   },
            // ).toList(),
            lineTouchData: LineTouchData(
              enabled: true,
              handleBuiltInTouches: true,
              // touchSpotThreshold: 0.5,
              // mouseCursorResolver: (FlTouchEvent event, LineTouchResponse? response) {
              //   if (response == null || response.lineBarSpots == null) {
              //     return SystemMouseCursors.basic;
              //   }
              //   return SystemMouseCursors.click; // 마우스 올렸을 때 커서 변경
              // },

              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (LineBarSpot touchedSpot) => const Color(0xFFF5F5F5),
                tooltipRoundedRadius: 8,

                // fitInsideVertically: true,
                // fitInsideHorizontally: true,
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
            lineBarsData: _lineBarsDataRendering,
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
    );
  }

  List<ShowingTooltipIndicators> _buildUITooltip() {
    return _showingTooltipOnSpots.map(
      (int index) {
        return ShowingTooltipIndicators(
          <LineBarSpot>[
            LineBarSpot(
              LineChartBarData(
                show: true,
                color: Colors.red,
                barWidth: 3,
                dotData: FlDotData(),
                spots: [FlSpot(0.1, 0.3)],
              ),
              2,
              FlSpot(1, 3),
            ),
            // LineBarSpot(
            //   tooltipsOnBar,
            //   lineBarsData.indexOf(tooltipsOnBar),
            //   tooltipsOnBar.spots[index],
            // ),
          ],
        );
      },
    ).toList();
  }
}

final List<Map<String, num?>> data = <Map<String, num?>>[
  {"fpr": 0, "tpr": 0, "threshold": null},
  {"fpr": 0, "tpr": 0.023255813953488372, "threshold": 0},
  {"fpr": 0, "tpr": 0.046511627906976744, "threshold": 0},
  {"fpr": 0, "tpr": 0.06976744186046512, "threshold": 0.0800089381502147},
  {"fpr": 0, "tpr": 0.09302325581395349, "threshold": 2.6935748797957615},
  {"fpr": 0, "tpr": 0.11627906976744186, "threshold": 3.299744478067339},
  {"fpr": 0, "tpr": 0.13953488372093023, "threshold": 4.844501270504566},
  {"fpr": 0, "tpr": 0.16279069767441862, "threshold": 5.412383856965889},
  {"fpr": 0, "tpr": 0.18604651162790697, "threshold": 5.440754937070281},
  {"fpr": 0, "tpr": 0.20930232558139536, "threshold": 5.618404601519018},
  {"fpr": 0, "tpr": 0.23255813953488372, "threshold": 6.560084009644825},
  {"fpr": 0, "tpr": 0.2558139534883721, "threshold": 7.5424444506198824},
  {"fpr": 0, "tpr": 0.27906976744186046, "threshold": 10.1265396716514},
  {"fpr": 0, "tpr": 0.3023255813953488, "threshold": 12.519709725591838},
  {"fpr": 0, "tpr": 0.32558139534883723, "threshold": 14.023663008603478},
  {"fpr": 0, "tpr": 0.3488372093023256, "threshold": 16.054282740534475},
  {"fpr": 0, "tpr": 0.37209302325581395, "threshold": 16.294622200269004},
  {"fpr": 0, "tpr": 0.3953488372093023, "threshold": 16.316771105406588},
  {"fpr": 0, "tpr": 0.4186046511627907, "threshold": 16.53319658033149},
  {"fpr": 0, "tpr": 0.4418604651162791, "threshold": 17.666430035781644},
  {"fpr": 0, "tpr": 0.46511627906976744, "threshold": 18.13656255588755},
  {"fpr": 0, "tpr": 0.4883720930232558, "threshold": 18.620722453623074},
  {"fpr": 0, "tpr": 0.5116279069767442, "threshold": 18.869864119891403},
  {"fpr": 0, "tpr": 0.5348837209302325, "threshold": 21.281935871218067},
  {"fpr": 0, "tpr": 0.5581395348837209, "threshold": 21.84424714592963},
  {"fpr": 0, "tpr": 0.5813953488372093, "threshold": 23.04841837565418},
  {"fpr": 0, "tpr": 0.6046511627906976, "threshold": 25.288897603611062},
  {"fpr": 0, "tpr": 0.627906976744186, "threshold": 26.960852577194288},
  {"fpr": 0, "tpr": 0.6511627906976745, "threshold": 27.978629361686018},
  {"fpr": 0.03333333333333333, "tpr": 0.6511627906976745, "threshold": 28.69816524093929},
  {"fpr": 0.06666666666666667, "tpr": 0.6511627906976745, "threshold": 29.061083579277067},
  {"fpr": 0.06666666666666667, "tpr": 0.6744186046511628, "threshold": 29.087381253518714},
  {"fpr": 0.1, "tpr": 0.6744186046511628, "threshold": 29.470129709194197},
  {"fpr": 0.1, "tpr": 0.6976744186046512, "threshold": 31.475283561010528},
  {"fpr": 0.1, "tpr": 0.7209302325581395, "threshold": 33.00527302959651},
  {"fpr": 0.13333333333333333, "tpr": 0.7209302325581395, "threshold": 34.77027260413578},
  {"fpr": 0.13333333333333333, "tpr": 0.7441860465116279, "threshold": 35.77954751241266},
  {"fpr": 0.13333333333333333, "tpr": 0.7674418604651163, "threshold": 35.84969263331577},
  {"fpr": 0.13333333333333333, "tpr": 0.7906976744186046, "threshold": 38.56623000760331},
  {"fpr": 0.13333333333333333, "tpr": 0.813953488372093, "threshold": 39.375969913099915},
  {"fpr": 0.13333333333333333, "tpr": 0.8372093023255814, "threshold": 40.49384477656178},
  {"fpr": 0.16666666666666666, "tpr": 0.8372093023255814, "threshold": 40.61859597710633},
  {"fpr": 0.16666666666666666, "tpr": 0.8604651162790697, "threshold": 40.62793121191967},
  {"fpr": 0.16666666666666666, "tpr": 0.8837209302325582, "threshold": 42.118837228736375},
  {"fpr": 0.2, "tpr": 0.8837209302325582, "threshold": 42.51361798892306},
  {"fpr": 0.2, "tpr": 0.9069767441860465, "threshold": 45.97648603500328},
  {"fpr": 0.2, "tpr": 0.9302325581395349, "threshold": 50.674569964043826},
  {"fpr": 0.23333333333333334, "tpr": 0.9302325581395349, "threshold": 52.559296285569914},
  {"fpr": 0.26666666666666666, "tpr": 0.9302325581395349, "threshold": 55.363457973292896},
  {"fpr": 0.26666666666666666, "tpr": 0.9534883720930233, "threshold": 56.41803899228824},
  {"fpr": 0.26666666666666666, "tpr": 0.9767441860465116, "threshold": 56.606219169086565},
  {"fpr": 0.3, "tpr": 0.9767441860465116, "threshold": 57.26073967125499},
  {"fpr": 0.3, "tpr": 1, "threshold": 57.3190347104755},
  {"fpr": 0.3333333333333333, "tpr": 1, "threshold": 57.63174756609365},
  {"fpr": 0.36666666666666664, "tpr": 1, "threshold": 58.1054046024805},
  {"fpr": 0.4, "tpr": 1, "threshold": 60.90532070167086},
  {"fpr": 0.43333333333333335, "tpr": 1, "threshold": 62.65740591348475},
  {"fpr": 0.4666666666666667, "tpr": 1, "threshold": 63.263650839682114},
  {"fpr": 0.5, "tpr": 1, "threshold": 70.32039050203838},
  {"fpr": 0.5333333333333333, "tpr": 1, "threshold": 70.69965993321493},
  {"fpr": 0.5666666666666667, "tpr": 1, "threshold": 73.02266855328494},
  {"fpr": 0.6, "tpr": 1, "threshold": 76.39453543023208},
  {"fpr": 0.6333333333333333, "tpr": 1, "threshold": 77.38156024989061},
  {"fpr": 0.6666666666666666, "tpr": 1, "threshold": 78.79015960216691},
  {"fpr": 0.7, "tpr": 1, "threshold": 81.59970563947388},
  {"fpr": 0.7333333333333333, "tpr": 1, "threshold": 84.30743996660692},
  {"fpr": 0.7666666666666667, "tpr": 1, "threshold": 85.47413510802458},
  {"fpr": 0.8, "tpr": 1, "threshold": 87.99599862050205},
  {"fpr": 0.8333333333333334, "tpr": 1, "threshold": 88.46083548692837},
  {"fpr": 0.8666666666666667, "tpr": 1, "threshold": 93.20942461206464},
  {"fpr": 0.9, "tpr": 1, "threshold": 100},
  {"fpr": 0.9333333333333333, "tpr": 1, "threshold": 100},
  {"fpr": 0.9666666666666667, "tpr": 1, "threshold": 100},
  {"fpr": 1, "tpr": 1, "threshold": 100}
];
