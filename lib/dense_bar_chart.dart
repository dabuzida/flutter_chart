import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/data.dart';

class DenseBarChart extends StatefulWidget {
  const DenseBarChart({super.key});

  @override
  State<DenseBarChart> createState() => _DenseBarChartState();
}

class _DenseBarChartState extends State<DenseBarChart> {
  final List _dataList = UsageInfo.dataHourly;
  // final List _dataList = UsageInfo.dataDaily;
  // final List _dataList = UsageInfo.dataMonthly;

  String _title = '';
  String _xAxisTitle = '';
  final String _yAxisLeftTitle = '총비용';
  final String _yAxisRightTitle = '횟수';

  @override
  void initState() {
    super.initState();
    // print(11111);
    // for (int i = 0; i < 10000000000; i++) {}
    // print(22222);
    // for (int i = 0; i < 10000000000; i++) {}
    // print(33333);
    _setChartSetting();
  }

  void _setChartSetting() {}

  @override
  Widget build(BuildContext context) {
    print('build');
    return Container(
      color: Colors.grey.shade300,
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 800,
        child: BarChart(
          key: UniqueKey(),
          BarChartData(
            maxY: 10,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                direction: TooltipDirection.top,
                tooltipBgColor: Colors.transparent,
                tooltipMargin: 0,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.toY.toString(),
                    TextStyle(
                      color: Colors.red,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              // TOP
              topTitles: AxisTitles(
                // axisNameWidget: Text(''),
                axisNameSize: 50,
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              // LEFT, Y-AXIS
              leftTitles: AxisTitles(
                // axisNameWidget: _yAxisTitle,
                axisNameSize: 40,
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  // interval: _intervalYAxisMarking,
                  // getTitlesWidget: _makeYAxisMarking,
                ),
              ),
              // BOTTOM, X-AXIS
              bottomTitles: AxisTitles(
                // axisNameWidget: xAxisTitle,
                axisNameSize: 40,
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 58,
                  // getTitlesWidget: (double value, TitleMeta meta) {
                  //   return _makeXAxisMarking(value: value, meta: meta, size: size);
                  // },
                ),
              ),
              // RIGHT
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                  // left: BorderSide(color: _axisColor),
                  // bottom: BorderSide(color: _axisColor),
                  ),
            ),
            alignment: BarChartAlignment.spaceAround,
            // barGroups: _makeBar(size: size),
          ),
        ),
      ),
    );
  }
}
