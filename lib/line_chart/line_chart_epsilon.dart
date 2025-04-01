import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartEpsilon extends StatefulWidget {
  const LineChartEpsilon({super.key});

  @override
  State<LineChartEpsilon> createState() => _LineChartEpsilonState();
}

class _LineChartEpsilonState extends State<LineChartEpsilon> {
  final Color _colorBackground = Colors.grey.shade100;
  final Color _colorAlpha = Colors.redAccent;
  final Color _colorBeta = Colors.lightBlueAccent;
  // final Color _colorAlpha = Color(0xFFD32F2F);
  // final Color _colorBeta = Color(0xFF0D47A1);
  // final Color _colorAlpha = Color(0xFFE53935);
  // final Color _colorBeta = Color(0xFF1976D2);

  final double _minY = 0;
  final double _maxY = 5;

  final double _minX = 0;
  final double _maxX = 8;
  final double _interval = 2;

  final bool _minIncluded = false;
  final bool _maxIncluded = true;

  final List<LineChartBarData> _lineBarsData = <LineChartBarData>[
    LineChartBarData(
      // showingIndicators: [1, 2],
      // x축은 minX, maxX, interval, maxIncluded, minIncluded 와 연관
      //
      spots: const <FlSpot>[
        // FlSpot(0, 5),
        FlSpot(1, 4),
        FlSpot(2, 3),
        FlSpot(3, 2),
        FlSpot(4, 1),
        // FlSpot(5, 1),
      ],
      isCurved: false,
      barWidth: 1,
      color: Colors.redAccent,

      dotData: const FlDotData(show: true),
    ),
    LineChartBarData(
      // showingIndicators: [1, 2],
      // x축은 minX, maxX, interval, maxIncluded, minIncluded 와 연관
      //
      show: true,
      spots: const <FlSpot>[
        FlSpot(1, 4),
        FlSpot(3, 3),
        FlSpot(5, 2),
        FlSpot(7, 1),
      ],
      isCurved: false,
      barWidth: 1,
      color: Colors.lightBlueAccent,
      dotData: const FlDotData(show: true),
    ),
  ];

  final List<int> _showingTooltipOnSpots = <int>[];

  List<FlSpot> get _allSpots => const [
        FlSpot(0, 0),
        FlSpot(1, 0.5),
        FlSpot(2, 1),
        FlSpot(3, 1.5),
        FlSpot(4, 4),
        FlSpot(5, 4),
      ];

  @override
  void initState() {
    super.initState();
    // _allSpots;
    // _showingTooltipOnSpots;

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
        dotData: const FlDotData(show: true),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2.5,
      child: Container(
        color: _colorBackground,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: LineChart(
          LineChartData(
            minX: _minX,
            maxX: _maxX,
            minY: _minY,
            maxY: _maxY,
            // showingTooltipIndicators: _buildUITooltip(),
            // showingTooltipIndicators: <ShowingTooltipIndicators>[
            //   const ShowingTooltipIndicators(
            //     <LineBarSpot>[],
            //   ),
            // ],
            // showingTooltipIndicators: _showingTooltipOnSpots.map(
            //   // 11111
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
            // 22222
            lineBarsData: _lineBarsData,
            lineTouchData: LineTouchData(
              enabled: true,
              handleBuiltInTouches: false,
              // 33333
              // touchTooltipData: LineTouchTooltipData(
              //   getTooltipColor: (LineBarSpot touchedSpot) => Colors.transparent,
              //   tooltipRoundedRadius: 8,
              //   getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              //
              //     return lineBarsSpot.map(
              //       (LineBarSpot lineBarSpot) {
              //         return LineTooltipItem(
              //           'asdf',
              //           // lineBarSpot.y.toString(),
              //           const TextStyle(
              //             // color: Colors.white,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         );
              //       },
              //     ).toList();
              //   },
              // ),
              getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                return spotIndexes.map(
                  (int index) {
                    return const TouchedSpotIndicatorData(
                      FlLine(color: Colors.transparent),
                      FlDotData(show: false),
                    );
                  },
                ).toList();
              },
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                axisNameWidget: Text(
                  'Epsilon',
                  textAlign: TextAlign.left,
                ),
                axisNameSize: 24,
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 0,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: _interval,
                  maxIncluded: _maxIncluded,
                  minIncluded: _minIncluded,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    // 44444
                    final int xx = value.toInt();
                    print('>> $value');
                    // print('>> $value, ${value - 1}');

                    return Text(
                      // value.toString(),
                      '2025.01',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    );
                  },
                  reservedSize: 30,
                ),
              ),
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: Colors.transparent),
                top: BorderSide(color: Colors.transparent),
                right: BorderSide(color: Colors.transparent),
                bottom: BorderSide(color: Color(0xff4e4965)),
              ),
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
                spots: [FlSpot(1, 3)],
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
