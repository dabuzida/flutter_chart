import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/bar_line/bbar.dart';
import 'package:flutter_chart/bar_line/lline.dart';
import 'package:flutter_chart/data.dart';

class BarLineChart extends StatefulWidget {
  const BarLineChart({super.key});

  @override
  State<BarLineChart> createState() => _BarLineChartState();
}

class _BarLineChartState extends State<BarLineChart> {
  final List _dataList = UsageInfo.dataHourly;
  // final List _dataList = UsageInfo.dataDaily;
  // final List _dataList = UsageInfo.dataMonthly;
  late String _currentScreenSize;
  String _title = '';
  String _xAxisTitle = '';
  final String _yAxisLeftTitle = '총비용';
  final String _yAxisRightTitle = '횟수';

  final Color _colorCost = Color(0xFF4F81BD);
  final Color _colorCount = Color(0xFFC0504D);
  final Color _colorAxis = Colors.grey.shade400;

  final double _barsSpace = 10;

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
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 800,
        child: Stack(
          children: <Widget>[
            Bbar(),
            const Lline(),

            // _barCost(),
            // _lineCount(),
          ],
        ),
      ),
    );
  }

  BarChart _barCost() {
    return BarChart(
      key: UniqueKey(),
      BarChartData(
        // groupsSpace: 5,
        // alignment: BarChartAlignment.center,
        // alignment: BarChartAlignment.spaceAround,
        maxY: 1000000,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            direction: TooltipDirection.top,
            // direction: TooltipDirection.top,
            tooltipBgColor: Colors.transparent,
            tooltipMargin: 0,
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                '${_dataList[groupIndex]['count']}',
                // '${rod.toY.toString()}(${_dataList[groupIndex]['count']})',
                // '${rod.toY.toString()}원\n${_dataList[groupIndex]['count']}회',
                TextStyle(
                  color: _colorCount,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: _getTopTitles(),
          leftTitles: _getLeftTitles(),
          rightTitles: _getRightTitles(),
          bottomTitles: _getBottomTitles(),
        ),
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(color: _colorAxis, width: 3),
            bottom: BorderSide(color: _colorAxis, width: 3),
            // right: BorderSide(color: _colorCount, width: 3),
          ),
        ),
        barGroups: _getBars(),
      ),
    );
  }

  BarChart _lineCount() {
    return BarChart(
      key: UniqueKey(),
      BarChartData(
        // groupsSpace: 5,
        // alignment: BarChartAlignment.center,
        // alignment: BarChartAlignment.spaceAround,
        maxY: 1000000,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            direction: TooltipDirection.top,
            // direction: TooltipDirection.top,
            tooltipBgColor: Colors.transparent,
            tooltipMargin: 0,
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                '${_dataList[groupIndex]['count']}',
                // '${rod.toY.toString()}(${_dataList[groupIndex]['count']})',
                // '${rod.toY.toString()}원\n${_dataList[groupIndex]['count']}회',
                TextStyle(
                  color: _colorCount,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: _getTopTitles(),
          leftTitles: _getLeftTitles(),
          rightTitles: _getRightTitles(),
          bottomTitles: _getBottomTitles(),
        ),
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(color: _colorAxis, width: 3),
            bottom: BorderSide(color: _colorAxis, width: 3),
            // right: BorderSide(color: _colorCount, width: 3),
          ),
        ),
        barGroups: _getBars(),
      ),
    );
  }

  AxisTitles _getTopTitles() {
    return AxisTitles(
      axisNameWidget: Text('막대그래프 + 꺾은 선 그래프'),
      axisNameSize: 40,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (value, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          child: Text(''),
        ),
      ),
    );
  }

  AxisTitles _getLeftTitles() {
    return AxisTitles(
      // axisNameWidget: RotatedBox(
      //   quarterTurns: 45,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Text('총'),
      //       Text('비'),
      //       Text('용'),
      //     ],
      //   ),
      // ),
      // axisNameSize: 0,

      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 60,
        interval: 100001,
        // getTitlesWidget: _makeYAxisMarking,
      ),
    );
  }

  AxisTitles _getRightTitles() {
    return AxisTitles(
      // axisNameWidget: RotatedBox(
      //   quarterTurns: 45,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Text('횟'),
      //       Text('수'),
      //     ],
      //   ),
      // ),
      axisNameSize: 40,
      sideTitles: SideTitles(
        showTitles: false,
        // reservedSize: 40,
      ),
    );
  }

  AxisTitles _getBottomTitles() {
    return AxisTitles(
      // axisNameWidget: Column(
      //   children: <Widget>[
      //     Text('날짜'),

      //   ],
      // ),
      axisNameSize: 40,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 58,
        // getTitlesWidget: (double value, TitleMeta meta) {
        //   return _makeXAxisMarking(value: value, meta: meta, size: size);
        // },
      ),
    );
  }

  List<BarChartGroupData> _getBars() {
    final List<BarChartGroupData> barList = [];

    for (int i = 0; i < 15; i++) {
      barList.add(
        BarChartGroupData(
          x: 4,
          barsSpace: _barsSpace,
          barRods: <BarChartRodData>[
            BarChartRodData(toY: 400000, color: _colorCost, width: 4),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return barList;
  }
}
