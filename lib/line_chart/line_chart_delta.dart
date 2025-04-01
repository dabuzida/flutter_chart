import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartDelta extends StatefulWidget {
  const LineChartDelta({super.key});

  @override
  State<LineChartDelta> createState() => _LineChartDeltaState();
}

class _LineChartDeltaState extends State<LineChartDelta> {
  List<int> showingTooltipOnSpots = [0, 1, 2, 3, 4, 5];

  List<FlSpot> get allSpots => const [
        FlSpot(0, 1),
        FlSpot(1, 2),
        FlSpot(2, 1.5),
        FlSpot(3, 3),
        FlSpot(4, 3.5),
        FlSpot(5, 5),
        FlSpot(6, 8),
      ];

  @override
  void initState() {
    super.initState();
    allSpots.first.x;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '00:00';
        break;
      case 1:
        text = '04:00';
        break;
      case 2:
        text = '08:00';
        break;
      case 3:
        text = '12:00';
        break;
      case 4:
        text = '16:00';
        break;
      case 5:
        text = '20:00';
        break;
      case 6:
        text = '23:59';
        break;
      default:
        return Container();
    }

    return Container(
      // width: 50,
      // height: 50,
      color: Colors.transparent,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<LineChartBarData> lineBarsData = <LineChartBarData>[
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots, // 데이터 중에서 툴팁 표현할 좌표
        spots: allSpots, // 모든 데이터의 좌표
        isCurved: false,
        barWidth: 2,
        // TODO: 꺾은선 주변 그림자
        // shadow: const Shadow(
        //   blurRadius: 8,
        // ),
        // TODO: 꺾은선의 아래 부분 색상 넣기
        // belowBarData: BarAreaData(
        //   show: true,
        //   gradient: LinearGradient(
        //     colors: [
        //       Colors.green.shade100,
        //       Colors.green.shade300,
        //       Colors.green.shade500,
        //     ],
        //   ),
        // ),
        // dotData: const FlDotData(show: false), // 꺾은선 자체 dot
        // TODO: 꺾은선 색 그라데이션
        // gradient: LinearGradient(
        //   colors: [
        //     Colors.blue.shade100,
        //     Colors.blue.shade300,
        //     Colors.blue.shade500,
        //   ],
        //   stops: const [0.1, 0.4, 0.9],
        // ),
      ),
    ];

    final LineChartBarData tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 10,
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return LineChart(
              LineChartData(
                // showingTooltipIndicators: 1,
                maxX: 10,
                maxY: 1,
                minX: 0,
                minY: 0,
                // backgroundColor: Colors.red,
                // baselineX: 5,
                // baselineY: 1,
                // betweenBarsData: 1,
                // borderData: 1,
                // clipData: 1,
                // extraLinesData: 1,
                // gridData: 1,
                // titlesData: 1,
                lineBarsData: <LineChartBarData>[
                  LineChartBarData(),
                ],
                // lineTouchData: 1,
                // rangeAnnotations: 1,
              ),
            );
          },
        ),
      ),
    );
  }
}
