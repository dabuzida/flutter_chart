import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/data.dart';

class BarBarChart extends StatefulWidget {
  const BarBarChart({super.key});

  @override
  State<BarBarChart> createState() => _BarBarChartState();
}

class _BarBarChartState extends State<BarBarChart> {
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

  final double _barWidth = 3;

  // late double _barsSpace;
  double _barsSpace = 7;
  // double _barsSpace = 15;
  late double _maxYCost;
  late double _maxYCount;
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

  void _setChartSetting() {
    double maxY = 0;
    double maxY2 = 0;
    for (int i = 0; i < _dataList.length; i++) {
      final a = _dataList[i]['cost'];
      final b = _dataList[i]['count'];
      if (a > maxY) {
        maxY = a;
      }
      if (b > maxY2) {
        maxY2 = b;
      }
    }

    _maxYCost = maxY;
    _maxYCount = maxY2;
  }

  void _setBarsSpace(BuildContext context) {
    final double currentWidth = MediaQuery.of(context).size.width;
    if (1000 < currentWidth) {
      _barsSpace = 5;
    } else if (500 < currentWidth && currentWidth <= 1000) {
      _barsSpace = 20;
    } else {
      _barsSpace = 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Container(
      color: Colors.white,
      // color: Colors.grey.shade300,
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 800,
        child: Stack(
          children: <Widget>[
            _barChartCost(), // 밑바탕
            _barChartCount(), // 덮어씀
          ],
        ),
      ),
    );
  }

  BarChart _barChartCost() {
    return BarChart(
      key: UniqueKey(),
      BarChartData(
        maxY: _maxYCost,
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
                '${_dataList[groupIndex]['cost']}',
                // '${rod.toY.toString()}(${_dataList[groupIndex]['count']})',
                // '${rod.toY.toString()}원\n${_dataList[groupIndex]['count']}회',
                TextStyle(
                  color: _colorCost,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: _getCostTopTitles(),
          leftTitles: _getCostLeftTitles(),
          rightTitles: _getCostRightTitles(),
          bottomTitles: _getCostBottomTitles(),
        ),
        gridData: FlGridData(show: false, drawVerticalLine: false),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(color: _colorAxis),
            right: const BorderSide(color: Colors.transparent, width: 0),
            bottom: BorderSide(color: _colorAxis),
          ),
        ),
        barGroups: _getCostBars(),
      ),
    );
  }

  BarChart _barChartCount() {
    return BarChart(
      key: UniqueKey(),
      BarChartData(
        maxY: _maxYCount,
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
          topTitles: _getCountTopTitles(),
          leftTitles: _getCountLeftTitles(),
          rightTitles: _getCountRightTitles(),
          bottomTitles: _getCountBottomTitles(),
        ),
        gridData: FlGridData(show: false, drawVerticalLine: false),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: const BorderSide(color: Colors.transparent, width: 0),
            right: BorderSide(color: _colorAxis),
            bottom: const BorderSide(color: Colors.transparent),
          ),
        ),
        barGroups: _getCountBars(),
      ),
    );
  }

  //cost
  AxisTitles _getCostTopTitles() {
    return AxisTitles(
      axisNameWidget: Text('SAAS 차감내역 차트'),
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

  AxisTitles _getCostLeftTitles() {
    return AxisTitles(
      axisNameWidget: RotatedBox(
        quarterTurns: 45,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('총', style: TextStyle(color: _colorCost)),
            Text('비', style: TextStyle(color: _colorCost)),
            Text('용', style: TextStyle(color: _colorCost)),
          ],
        ),
      ),
      axisNameSize: 0,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 60,
        interval: 1000,
        getTitlesWidget: (value, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          child: Text(
            meta.formattedValue,
            style: TextStyle(color: _colorCost),
          ),
        ),
      ),
    );
  }

  AxisTitles _getCostRightTitles() {
    return AxisTitles(
      axisNameWidget: RotatedBox(
        quarterTurns: 45,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(''),
          ],
        ),
      ),
      axisNameSize: 0,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        // interval: 50,
        getTitlesWidget: (value, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          child: Text(
            '',
          ),
        ),
      ),
    );
  }

  AxisTitles _getCostBottomTitles() {
    return AxisTitles(
      axisNameWidget: Column(
        children: <Widget>[
          Text('날짜'),
        ],
      ),
      axisNameSize: 40,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: (double value, TitleMeta meta) {
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(
              meta.formattedValue,
            ),
          );
        },
      ),
    );
  }

  List<BarChartGroupData> _getCostBars() {
    final List<BarChartGroupData> barList = [];

    for (int i = 0; i < _dataList.length; i++) {
      final aa = _dataList[i]['cost'];
      barList.add(
        BarChartGroupData(
          x: 4,
          barsSpace: _barsSpace,
          barRods: <BarChartRodData>[
            BarChartRodData(toY: aa, color: _colorCost, width: _barWidth, borderRadius: BorderRadius.zero),
            BarChartRodData(toY: 0, width: 0, borderRadius: BorderRadius.zero),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return barList;
  }

// count
  AxisTitles _getCountTopTitles() {
    return AxisTitles(
      axisNameWidget: Text(''),
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

  AxisTitles _getCountLeftTitles() {
    return AxisTitles(
      axisNameWidget: RotatedBox(
        quarterTurns: 45,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(''),
          ],
        ),
      ),
      axisNameSize: 0,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 60,
        interval: 100001,
        getTitlesWidget: (value, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          child: Text(''),
        ),
      ),
    );
  }

  AxisTitles _getCountRightTitles() {
    return AxisTitles(
      axisNameWidget: RotatedBox(
        quarterTurns: 45,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('횟', style: TextStyle(color: _colorCount)),
            Text('수', style: TextStyle(color: _colorCount)),
          ],
        ),
      ),
      axisNameSize: 0,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        interval: 50,
        getTitlesWidget: (value, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          child: Text(
            meta.formattedValue,
            style: TextStyle(color: _colorCount),
          ),
        ),
      ),
    );
  }

  AxisTitles _getCountBottomTitles() {
    return AxisTitles(
      axisNameWidget: Column(
        children: <Widget>[
          Text(''),
        ],
      ),
      axisNameSize: 40,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: (double value, TitleMeta meta) {
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(''),
          );
        },
      ),
    );
  }

  List<BarChartGroupData> _getCountBars() {
    final List<BarChartGroupData> barList = [];

    for (int i = 0; i < _dataList.length; i++) {
      final aa = _dataList[i]['count'];
      barList.add(
        BarChartGroupData(
          x: 4,
          barsSpace: _barsSpace,
          barRods: <BarChartRodData>[
            BarChartRodData(toY: 0, width: 0, borderRadius: BorderRadius.zero),
            BarChartRodData(toY: aa, color: _colorCount, width: _barWidth, borderRadius: BorderRadius.zero),
          ],
          showingTooltipIndicators: [1],
        ),
      );
    }
    return barList;
  }
}
