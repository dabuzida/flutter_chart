import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/data.dart';

class BarBarChart3 extends StatefulWidget {
  const BarBarChart3({super.key});

  @override
  State<BarBarChart3> createState() => _BarBarChart3State();
}

class _BarBarChart3State extends State<BarBarChart3> {
  final List _dataList = UsageInfo.dataHourly;
  // final List _dataList = UsageInfo.dataDaily;
  // final List _dataList = UsageInfo.dataMonthly;

  final Color _colorCost = const Color(0xFF4F81BD);
  final Color _colorAxis = Colors.grey.shade400;

  late double _maxYCost;

  final int _leftAxisMaxValueDivisionCount = 10; // 최대값 등분개수, grid 등분개수
  final int _leftAxisGradationCount = 5; // 눈금 개수. _leftAxisMaxValueDivisionCount / 2 이여야 한다

  @override
  void initState() {
    super.initState();

    _setChartSetting();
  }

  // cost차트, count차트 공통 속성 (Stack으로 겹치기 때문에 수치 통일 해야함)
  final double _topNameSize = 40;
  final double _topReservedSize = 30;
  final double _leftNameSize = 20;
  final double _leftReservedSize = 60;
  final double _rightNameSize = 20;
  final double _rightReservedSize = 40;
  final double _bottomNameSize = 20;
  final double _bottomReservedSize = 100;

  // late로 선언하여 렌더링 전, 브라우저 폭 감지후 매번 갱신 하는 속성
  late double _barWidth;
  late double _barsSpace;

  void _setBarsSpace() {
    // 브라우저 폭 변경될 때마다 갱신
    final double currentWidth = MediaQuery.of(context).size.width;
    if (1500 <= currentWidth) {
      _barWidth = 5;
      _barsSpace = 20;
    } else if (1250 <= currentWidth && currentWidth < 1500) {
      // _barWidth = 3;
      _barWidth = 15;
      _barsSpace = 12;
    } else if (700 <= currentWidth && currentWidth < 1250) {
      _barWidth = 4;
      _barsSpace = 17;
    } else {
      _barWidth = 1;
      _barsSpace = 8;
    }
  }

  void _setChartSetting() {
    // 서버에서 데이터 받아올때마다 갱신
    double maxY = 0;

    for (int i = 0; i < _dataList.length; i++) {
      final a = _dataList[i]['cost'];
      if (a > maxY) {
        maxY = a;
      }
    }
    // 11111
    // _maxYCost = maxY;
    // _maxYCost = (maxY * 1.1).ceilToDouble();

    final bool hasNotRemainder = maxY % _leftAxisMaxValueDivisionCount == 0;
    // final double ww = maxY % _leftAxisDivisionCount;
    _maxYCost = (maxY / _leftAxisMaxValueDivisionCount).ceil() * _leftAxisMaxValueDivisionCount * 1.0;
    if (hasNotRemainder) {
      // x / 100 .floor
      _maxYCost += maxY / _leftAxisMaxValueDivisionCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    _setBarsSpace();
    return Container(
      color: Colors.white,
      height: 770,
      child: _leftCostChart(),
    );
  }

  BarChart _leftCostChart() {
    return BarChart(
      key: UniqueKey(),
      BarChartData(
        maxY: _maxYCost,
        barTouchData: BarTouchData(
          enabled: true,
          allowTouchBarBackDraw: true,
          handleBuiltInTouches: false,
          touchTooltipData: BarTouchTooltipData(
            direction: TooltipDirection.top,
            // tooltipBgColor: Colors.transparent,
            getTooltipColor: (BarChartGroupData group) => Colors.transparent,
            tooltipMargin: 0,
            getTooltipItem: (BarChartGroupData group, int groupIndex, BarChartRodData rod, int rodIndex) {
              return BarTooltipItem(
                // rod.toY.toString(),
                '${_dataList[groupIndex]['cost']}',
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
          leftTitles: _getLeftTitle(),
          rightTitles: _getCostRightTitles(),
          bottomTitles: _getBottomTitles(),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _maxYCost / _leftAxisMaxValueDivisionCount,
        ),
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

  List<BarChartGroupData> _getCostBars() {
    final List<BarChartGroupData> barList = [];

    for (int i = 0; i < _dataList.length; i++) {
      barList.add(
        BarChartGroupData(
          x: i,
          barsSpace: _barsSpace,
          barRods: <BarChartRodData>[
            BarChartRodData(
              toY: _dataList[i]['cost'],
              width: 20,
              // borderRadius: BorderRadius.zero,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              color: _colorCost,
            ),
            // BarChartRodData(toY: 0, width: 0, borderRadius: BorderRadius.zero),
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return barList;
  }

  AxisTitles _getCostTopTitles() {
    return AxisTitles(
      axisNameWidget: const Text('SAAS 차감내역 차트'),
      axisNameSize: _topNameSize,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _topReservedSize,
        getTitlesWidget: (value, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          child: const Text(''),
        ),
      ),
    );
  }

  AxisTitles _getLeftTitle() {
    return AxisTitles(
      // axisNameWidget: const Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Text('['),
      //     RotatedBox(quarterTurns: 1, child: Text('원')),
      //     Text(']'),
      //     RotatedBox(quarterTurns: 1, child: Text('용')),
      //     RotatedBox(quarterTurns: 1, child: Text('비')),
      //   ],
      // ),
      axisNameSize: _leftNameSize,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _leftReservedSize,
        minIncluded: false,
        interval: _maxYCost / _leftAxisGradationCount,
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
      axisNameWidget: const RotatedBox(
        quarterTurns: 45,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(''),
          ],
        ),
      ),
      axisNameSize: _rightNameSize,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _rightReservedSize,
        // interval: 50,
        getTitlesWidget: (value, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          child: const Text(
            '',
          ),
        ),
      ),
    );
  }

  AxisTitles _getBottomTitles() {
    return AxisTitles(
      // axisNameWidget: const Column(
      //   children: <Widget>[
      //     Text('날짜'),
      //   ],
      // ),
      axisNameSize: _bottomNameSize,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _bottomReservedSize,
        getTitlesWidget: (double value, TitleMeta meta) {
          final int currentDataUnixTime = _dataList[value.toInt()]['date'];
          final DateTime currentDataDateTime = DateTime.fromMillisecondsSinceEpoch(currentDataUnixTime);
          final String currentDataDate = currentDataDateTime.toString();

          final String year = currentDataDate.substring(2, 4);
          final String month = currentDataDate.substring(5, 7);
          final String day = currentDataDate.substring(8, 10);

          String date = '$year.$month.$day';

          return Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
            child: SideTitleWidget(
              // angle: 6,
              // angle: 12,
              axisSide: meta.axisSide,
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                child: Text(
                  date,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
