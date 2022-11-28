import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/data.dart';

import 'media_query_layout.dart';

class BarBarChart extends StatefulWidget {
  const BarBarChart({super.key});

  @override
  State<BarBarChart> createState() => _BarBarChartState();
}

class _BarBarChartState extends State<BarBarChart> {
  final ScrollController _scrollController = ScrollController();

  final List _dataList = UsageInfo.dataHourly;
  // final List _dataList = UsageInfo.dataDaily;
  // final List _dataList = UsageInfo.dataMonthly;
  String _title = '';
  String _xAxisTitle = '';
  final String _yAxisLeftTitle = '총비용';
  final String _yAxisRightTitle = '횟수';

  final Color _colorCost = const Color(0xFF4F81BD);
  final Color _colorCount = const Color(0xFFC0504D);
  final Color _colorAxis = Colors.grey.shade400;

  bool _isCostVisible = true;
  bool _isCountVisible = true;

  // cost차트 고유 속성
  late double _maxYCost;
  // count차트 고유 속성
  late double _maxYCount;

  // cost차트, count차트 공통 속성 (Stack으로 겹치기 때문에 수치 통일 해야함)
  double _topNameSize = 40;
  double _topReservedSize = 30;
  double _leftNameSize = 20;
  double _leftReservedSize = 60;
  double _rightNameSize = 20;
  double _rightReservedSize = 40;
  double _bottomNameSize = 20;
  double _bottomReservedSize = 100;

  // late로 선언하여 렌더링 전, 브라우저 폭 감지후 매번 갱신 하는 속성
  late double _barWidth;
  late double _barsSpace;

  void _setBarsSpace() {
    // 브라우저 폭 변경될 때마다 갱신
    print('_setBarsSpace');
    final double currentWidth = MediaQuery.of(context).size.width;
    if (1500 <= currentWidth) {
      _barWidth = 5;
      _barsSpace = 20;
    } else if (1250 <= currentWidth && currentWidth < 1500) {
      _barWidth = 3;
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

  @override
  Widget build(BuildContext context) {
    print('build');
    // final double currentWidth = MediaQuery.of(context).size.width;
    // print('현재 브라우저 폭: $currentWidth');
    _setBarsSpace();
    return MediaQueryLayout(
      boundarySM: 1300.0,
      screenS: () {
        print('s');
        return _chartS();
      },
      screenM: () {
        print('m');
        return _chartML();
      },
      screenL: () {
        print('l');
        return _chartML();
      },
    );
  }

  Widget _chartS() {
    return ListView(
      controller: _scrollController,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(width: double.infinity, height: 5, color: Colors.teal),
              const SizedBox(height: 16),
              Container(
                color: Colors.white,
                height: 770,
                child: _stack(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chartML() {
    return ListView(
      controller: _scrollController,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Container(width: 720, height: 100, color: Colors.teal),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  color: Colors.white,
                  height: 770,
                  child: _stack(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _stack() {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        _leftCostChart(), // 밑바탕
        _rightCountChart(), // 덮어씀
        Container(
          width: 130,
          height: 50,
          // color: Colors.red.shade100,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (_isCountVisible) {
                    _isCostVisible = !_isCostVisible;
                    setState(() {});
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    children: <Widget>[
                      _isCostVisible
                          ? const Icon(
                              Icons.check_box_outlined,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank_outlined,
                            ),
                      Text('비용', style: TextStyle(color: _colorCost)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  if (_isCostVisible) {
                    _isCountVisible = !_isCountVisible;
                    setState(() {});
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    children: <Widget>[
                      _isCountVisible
                          ? const Icon(
                              Icons.check_box_outlined,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank_outlined,
                            ),
                      Text('횟수', style: TextStyle(color: _colorCount)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BarChart _leftCostChart() {
    return BarChart(
      key: UniqueKey(),
      BarChartData(
        maxY: _maxYCost,
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
          bottomTitles: _getBottomTitles(),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: BorderSide(color: _colorAxis),
            right: const BorderSide(color: Colors.transparent, width: 0),
            bottom: BorderSide(color: _colorAxis),
          ),
        ),
        barGroups: _isCostVisible ? _getCostBars() : _getBars(),
      ),
    );
  }

  BarChart _rightCountChart() {
    return BarChart(
      key: UniqueKey(),
      BarChartData(
        maxY: _maxYCount,
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
          bottomTitles: _getBottomTitlesFrame(),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border(
            left: const BorderSide(color: Colors.transparent, width: 0),
            right: BorderSide(color: _colorAxis),
            bottom: const BorderSide(color: Colors.transparent, width: 0),
          ),
        ),
        barGroups: _isCountVisible ? _getCountBars() : null,
        // barGroups: _isCountVisible ? _getCountBars() : _getBars(),
      ),
    );
  }

  List<BarChartGroupData> _getBars() {
    final List<BarChartGroupData> barList = [];

    for (int i = 0; i < _dataList.length; i++) {
      barList.add(
        BarChartGroupData(
          x: i,
          barsSpace: _barsSpace,
          barRods: <BarChartRodData>[
            BarChartRodData(toY: 0, width: _barWidth, borderRadius: BorderRadius.zero),
            BarChartRodData(toY: 0, width: 0, borderRadius: BorderRadius.zero),
          ],
          showingTooltipIndicators: [],
        ),
      );
    }
    return barList;
  }

  // 11111
  List<BarChartGroupData> _getCostBars() {
    final List<BarChartGroupData> barList = [];

    for (int i = 0; i < _dataList.length; i++) {
      final aa = _dataList[i]['cost'];
      barList.add(
        BarChartGroupData(
          x: i,
          barsSpace: _barsSpace,
          barRods: <BarChartRodData>[
            BarChartRodData(toY: aa, width: _barWidth, borderRadius: BorderRadius.zero, color: _colorCost),
            BarChartRodData(toY: 0, width: 0, borderRadius: BorderRadius.zero),
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

  AxisTitles _getCostLeftTitles() {
    return AxisTitles(
      axisNameWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text('['),
          RotatedBox(quarterTurns: 1, child: Text('원')),
          Text(']'),
          RotatedBox(quarterTurns: 1, child: Text('용')),
          RotatedBox(quarterTurns: 1, child: Text('비')),
        ],
      ),
      axisNameSize: _leftNameSize,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _leftReservedSize,
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
            const Text(''),
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
      axisNameWidget: Column(
        children: const <Widget>[
          Text('날짜'),
        ],
      ),
      axisNameSize: _bottomNameSize,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _bottomReservedSize,
        getTitlesWidget: (double value, TitleMeta meta) {
          // return Container(width: 50, height: 50, color: Colors.red);
          bool isSameDay = false;
          // print(value);
          // print(meta.formattedValue);
          // x축 눈금 개수만큼 실행되어 x축 눈금 생성
          // 2022-11-24 09:33:02.000
          final int currentDataUnixTime = _dataList[value.toInt()]['date'];
          final DateTime currentDataDateTime = DateTime.fromMillisecondsSinceEpoch(currentDataUnixTime);
          final String currentDataDate = currentDataDateTime.toString();
          final String currentDataYMD = currentDataDate.substring(0, 10);
          // check same day
          if (value.toInt() != 0) {
            // YMD: year month day
            final int previousDataUnixTime = _dataList[value.toInt() - 1]['date'];
            final DateTime previousDataDateTime = DateTime.fromMillisecondsSinceEpoch(previousDataUnixTime);
            final String previousDataDate = previousDataDateTime.toString();
            final String previousDataYMD = previousDataDate.substring(0, 10);

            // if (identical(previousDataDiscriminator , currentDataDiscriminator)) {
            // if (previousDataDiscriminator.compareTo(currentDataDiscriminator) == 0) {
            if (previousDataYMD == currentDataYMD) {
              isSameDay = true;
            }
          }

          final String year = currentDataDate.substring(2, 4);
          // final String year = currentDataDate.substring(0, 4);
          final String month = currentDataDate.substring(5, 7);
          final String day = currentDataDate.substring(8, 10);
          final String hourHead = currentDataDate.substring(11, 13);
          String hourTail = (int.parse(hourHead) + 1).toString();
          if (hourTail.length == 1) {
            hourTail = '0$hourTail';
          }

          String date = '';
          if (isSameDay) {
            date = '                   $hourHead ~ $hourTail         ';
          } else {
            // '`$year.$month.$day $hourHead ~ $hourTail';
            // '$month.$day $hourHead ~ $hourTail';
            date = '`$year.$month.$day $hourHead ~ $hourTail         ';
          }

          return SideTitleWidget(
            // angle: 6,
            angle: 12,
            axisSide: meta.axisSide,
            child: Text(date, style: const TextStyle(fontSize: 10)),
          );
        },
      ),
    );
  }

  // 22222
  List<BarChartGroupData> _getCountBars() {
    final List<BarChartGroupData> barList = [];

    // for (int i = 0; i < _dataList.length; i++) {
    for (int i = _dataList.length - 1; i > -1; i--) {
      final aa = _dataList[i]['count'];
      barList.add(
        BarChartGroupData(
          x: i,
          barsSpace: _barsSpace,
          barRods: <BarChartRodData>[
            BarChartRodData(toY: 0, width: 0, borderRadius: BorderRadius.zero),
            BarChartRodData(toY: aa, width: _barWidth, borderRadius: BorderRadius.zero, color: _colorCount),
          ],
          showingTooltipIndicators: [1],
        ),
      );
    }
    return barList;
  }

  AxisTitles _getCountTopTitles() {
    return AxisTitles(
      axisNameWidget: const Text(''),
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

  AxisTitles _getCountLeftTitles() {
    return AxisTitles(
      axisNameWidget: RotatedBox(
        quarterTurns: 45,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(''),
          ],
        ),
      ),
      axisNameSize: _leftNameSize,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _leftReservedSize,
        interval: 100001,
        getTitlesWidget: (value, meta) => SideTitleWidget(
          axisSide: meta.axisSide,
          child: const Text(''),
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
      axisNameSize: _rightNameSize,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _rightReservedSize,
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

  AxisTitles _getBottomTitlesFrame() {
    return AxisTitles(
      axisNameWidget: SizedBox(),
      axisNameSize: _bottomNameSize,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: _bottomReservedSize,
        getTitlesWidget: (double value, TitleMeta meta) {
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: SizedBox(),
          );
        },
      ),
    );
  }
}
