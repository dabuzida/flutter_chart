import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: <Widget>[
            xx(), // 밑바탕
            xx(), // 덮어
          ],
        ),
      ],
    );
  }

  Widget xx() {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Container(
        child: BarChart(
          key: UniqueKey(),
          BarChartData(
            maxY: 20,
            barTouchData: BarTouchData(enabled: false),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                axisNameWidget: Text('asdf'),
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: _makeXAxisMarking, //
                ),
              ),
            ),
            barGroups: getData(), //
          ),
        ),
      ),
    );
  }

  Widget _makeXAxisMarking(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text((value + 1).toString()),
    );
  }

  List<BarChartGroupData>? getData() {
    // return null;
    List<BarChartGroupData> widgets = [];
    for (int i = 0; i < 5; i++) {
      widgets.add(
        BarChartGroupData(
          x: i + 11,
          showingTooltipIndicators: <int>[0],
          barRods: <BarChartRodData>[BarChartRodData(toY: i.toDouble() + 1.0, width: 4)],
        ),
      );
    }

    return widgets;
  }
}
