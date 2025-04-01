import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartBeta extends StatelessWidget {
  const LineChartBeta({super.key});

  final double _minX = 0.0;
  final double _maxX = 7.0;
  final double _interval = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // color: Colors.white,
          width: 300,
          height: 400,
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: Colors.grey,
            border: Border.all(color: Colors.teal),
          ),
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                enabled: false,
                touchTooltipData: LineTouchTooltipData(
                  // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        '(${spot.x.toInt()}, ${spot.y})', // 툴팁 텍스트
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
                handleBuiltInTouches: true,
              ),
              gridData: gridData,
              titlesData: titlesData, // bottomTitles
              borderData: borderData,
              showingTooltipIndicators: [
                ShowingTooltipIndicators(
                  <LineBarSpot>[
                    LineBarSpot(LineChartBarData(), 1, FlSpot(1, 5)),
                  ],
                ),
              ],
              lineBarsData: <LineChartBarData>[
                lineChartBarData2_2, // 꼭지점 존재하는 그래프
              ],
              minX: _minX,
              maxX: _maxX,
              maxY: 6,
              minY: 0,
            ),
          ),
        ),
      ],
    );
  }

  LineTouchData get lineTouchData1 => const LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
            // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
            ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: _interval,
            maxIncluded: false,
            minIncluded: true,
            // getTitlesWidget: bottomTitleWidgets,
            getTitlesWidget: (double value, TitleMeta meta) {
              print('>> $value');
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 10,
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                  child: Text(
                    // 'DEC',
                    value.toString(),
                    style: const TextStyle(
                      color: Color(0xff72719b),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            interval: 1,
            reservedSize: 40,
          ),
        ),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('SEPT', style: style);
        break;
      case 1:
        text = const Text('OCT', style: style);
        break;
      case 2:
        text = const Text('DEC', style: style);
        break;
      case 3:
        text = const Text('DEC', style: style);
        break;
      case 4:
        text = const Text('DEC', style: style);
        break;
      case 5:
        text = const Text('DEC', style: style);
        break;
      case 6:
        text = const Text('DEC', style: style);
        break;
      case 7:
        text = const Text('DEC', style: style);
        break;

      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 1),
          left: BorderSide(color: Color(0xff4e4965), width: 1),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.red,
        barWidth: 2,
        // showingIndicators: [],
        isStrokeCapRound: false,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),

        // aboveBarData: BarAreaData(
        //   show: true,
        //   spotsLine: BarAreaSpotsLine(show: true),
        // ),
        spots: const <FlSpot>[
          // FlSpot(0.5, 3.8),
          // FlSpot(1, 3.8),
          // FlSpot(1.5, 1.9),
          // FlSpot(2, 5),
          // FlSpot(2.5, 3.3),
          // FlSpot(3, 4.5),
          //
          FlSpot(1, 3.8),
          FlSpot(2, 3.8),
          FlSpot(3, 1.9),
          FlSpot(4, 5),
          FlSpot(5, 3.3),
          FlSpot(6, 4.5),
        ],
      );
}
