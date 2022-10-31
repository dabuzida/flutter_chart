import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'functions.dart';

class TodayCallAmount extends StatefulWidget {
  const TodayCallAmount({super.key});

  @override
  State<TodayCallAmount> createState() => _TodayCallAmountState();
}

class _TodayCallAmountState extends State<TodayCallAmount> {
  final List<String> _xAxisTime = [];
  late double _yAxisMax;

  String _date = '';

  final String _chartTitle = '오늘-시간별 통화량';
  final Color _chartTitleColor = Colors.black;

  late Widget _yAxisTitle;
  final Color _yAxisTitleColor = Colors.black;
  final Color _yAxisValueColor = Colors.black;
  final List<double> _yAxisAmount = [];
  final double _yAxisInterval = 0.5;

  String _xAxisTitle = '시간';
  final int _barCountPerPage = 12;
  bool _isHeadPage = true; // 24개중 앞 12개 <-> 뒤 12개 tail
  final Color _xAxisTitleColor = Colors.black;
  final Color _xAxisValueColor = Colors.black;

  final Color _backgroundColor = const Color.fromARGB(225, 215, 216, 223);
  // final Color _backgroundColor = Colors.white70;
  final double _barWidth = 4;
  final double _barInterval = 25;
  final Color _barTooltipValueColor = Color.fromARGB(255, 63, 63, 72);
  // final Color _barTooltipValueColor = Colors.brown[700]!;

  final Color _barColor = Color.fromARGB(255, 82, 112, 98);
  // final Color _barColor = const Color(0xFF0047FF);

  Widget _makeYAxisTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '[',
          style: TextStyle(
            fontSize: 20,
            color: _yAxisTitleColor,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        RotationTransition(
          turns: const AlwaysStoppedAnimation(90 / 360),
          child: Text(
            '간',
            style: TextStyle(
              fontSize: 20,
              color: _yAxisTitleColor,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        RotationTransition(
          turns: const AlwaysStoppedAnimation(90 / 360),
          child: Text(
            '시',
            style: TextStyle(
              fontSize: 20,
              color: _yAxisTitleColor,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          ']',
          style: TextStyle(
            fontSize: 20,
            color: _yAxisTitleColor,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        RotationTransition(
          turns: const AlwaysStoppedAnimation(90 / 360),
          child: Text(
            '량',
            style: TextStyle(
              fontSize: 20,
              color: _yAxisTitleColor,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        RotationTransition(
          turns: const AlwaysStoppedAnimation(90 / 360),
          child: Text(
            '화',
            style: TextStyle(
              fontSize: 20,
              color: _yAxisTitleColor,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        RotationTransition(
          turns: const AlwaysStoppedAnimation(90 / 360),
          child: Text(
            '통',
            style: TextStyle(
              fontSize: 20,
              color: _yAxisTitleColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _yAxisTitle = _makeYAxisTitle();
    _date = _makeDate(date: CallChart.todayAmount.values.first.values.first[0].values.first);
    _xAxisTitle = '$_xAxisTitle [$_date]';
    _yAxisMax = _makeYAxisMaxValue();
    _initiateData();
  }

  void _initiateData() {
    _xAxisTime.clear();
    _yAxisAmount.clear();
    if (_isHeadPage) {
      for (int i = 0; i < _barCountPerPage; i++) {
        _xAxisTime.add(CallChart.todayAmount.values.first.values.first[i].values.first);

        final yAxisValue = _makeCallUsage(usageSeconds: CallChart.todayAmount.values.first.values.first[i].values.last);
        _yAxisAmount.add(yAxisValue);
      }
    } else {
      for (int i = 12; i < CallChart.todayAmount.values.first.values.first.length; i++) {
        _xAxisTime.add(CallChart.todayAmount.values.first.values.first[i].values.first);

        final yAxisValue = _makeCallUsage(usageSeconds: CallChart.todayAmount.values.first.values.first[i].values.last);
        _yAxisAmount.add(yAxisValue);
      }
    }
  }

  double _makeYAxisMaxValue() {
    final List<double> yAxisAmount = [];
    final Iterable<dynamic> data = CallChart.todayAmount.values.first.values;
    final int dataCount = CallChart.todayAmount.values.first.values.first.length;
    double sum = 0;
    // for (int i = 0; i < CallChart.todayAmount.values.first.values.first[i].values.first.length; i++) {
    for (int i = 0; i < dataCount; i++) {
      final double yAxisValue = _makeCallUsage(usageSeconds: CallChart.todayAmount.values.first.values.first[i].values.last);

      sum += yAxisValue;
      yAxisAmount.add(yAxisValue);
    }
    final double mean = sum / dataCount;

    double sumForDeviation = 0;
    for (int i = 0; i < dataCount; i++) {
      sumForDeviation += pow(_makeCallUsage(usageSeconds: CallChart.todayAmount.values.first.values.first[i].values.last) - mean, 2);
    }

    final standartDeviation = sqrt(sumForDeviation / dataCount);

    return yAxisAmount.reduce(max) + standartDeviation;
    // return yAxisAmount.reduce(max) + 0.5;
  }

  double _makeCallUsage({required int usageSeconds}) {
    double val = (usageSeconds + 0.0) / 3600;
    double result = double.parse(val.toStringAsFixed(1));

    return result;
  }

  String _makeDate({required String date}) {
    // unix time 구하기
    final int year = int.parse(date.substring(0, 4));
    final int month = int.parse(date.substring(5, 7));
    final int day = int.parse(date.substring(8, 10));
    final int unixTime = DateTime(year, month, day).millisecondsSinceEpoch;

    final String dateHead = MyTimeConversion().millisecondsToDate(format: 'yyyy.MM.dd ', unixTime: unixTime);
    final String dayOfTheWeek = MyTimeConversion().millisecondsToDate(format: 'E', unixTime: unixTime);
    final String dateTail = MyTimeConversion().localizeDayToKor(engDay: dayOfTheWeek);
    return dateHead + dateTail;
  }

  Widget _makeXAxisValue(double value, TitleMeta meta) {
    final List<String> xAxisTime = _xAxisTime;
    final String xAxisValueHead = xAxisTime[value.toInt()].substring(11, 13);
    // final String xAxisValueHead = '${xAxisTime[value.toInt()].substring(11, 13)}H';
    String xAxisValueTail = (int.parse(xAxisTime[value.toInt()].substring(11, 13)) + 1).toString();
    if (xAxisValueTail.length == 1) {
      xAxisValueTail = '0$xAxisValueTail';
    }
    xAxisValueTail = '$xAxisValueTail';
    // xAxisValueTail = '${xAxisValueTail}H';
    // xAxisValueTail = '$xAxisValueTail:00';

    Column x = Column(
      children: <Widget>[
        Text(
          xAxisValueHead,
          style: TextStyle(
            color: _xAxisValueColor,
            fontSize: 11,
          ),
        ),
        Text(
          '~',
          style: TextStyle(
            color: _xAxisValueColor,
            fontSize: 11,
          ),
        ),
        Text(
          xAxisValueTail,
          style: TextStyle(
            color: _xAxisValueColor,
            fontSize: 11,
          ),
        ),
      ],
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      // angle: -0.3,
      child: x,
    );
  }

  Widget _makeYAxisValue(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: TextStyle(
          color: _yAxisValueColor,
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            color: _backgroundColor,
            borderOnForeground: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: BarChart(
                BarChartData(
                  maxY: _yAxisMax,
                  // alignment: BarChartAlignment.spaceEvenly,
                  // alignment: BarChartAlignment.spaceBetween,
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      // rotateAngle: 10,
                      direction: TooltipDirection.top,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.toY.toString(),
                          TextStyle(
                            color: _barTooltipValueColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                      tooltipBgColor: Colors.transparent,
                      tooltipMargin: 0,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      axisNameWidget: _yAxisTitle,
                      axisNameSize: 40,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 45,
                        getTitlesWidget: _makeYAxisValue,
                        interval: _yAxisInterval,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: Text(
                        _xAxisTitle,
                        style: TextStyle(
                          color: _xAxisTitleColor,
                        ),
                      ),
                      axisNameSize: 60,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        getTitlesWidget: _makeXAxisValue,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      axisNameSize: 20,
                      axisNameWidget: const Text(''),
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    topTitles: AxisTitles(
                      axisNameWidget: Text(
                        _chartTitle,
                        style: TextStyle(
                          color: _chartTitleColor,
                          fontSize: 20,
                        ),
                      ),
                      axisNameSize: 50,
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
                    border: const Border(
                      left: BorderSide(
                        color: Color.fromARGB(255, 141, 171, 159),
                      ),
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 141, 171, 159),
                      ),
                    ),
                  ),
                  // groupsSpace: _barInterval,

                  barGroups: getData(),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: !_isHeadPage,
                  child: GestureDetector(
                    onTap: () {
                      _isHeadPage = !_isHeadPage;
                      _initiateData();
                      setState(() {});
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey[350],
                        ),
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _isHeadPage,
                  child: GestureDetector(
                    onTap: () {
                      _isHeadPage = !_isHeadPage;
                      _initiateData();
                      setState(() {});
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.grey[350],
                        ),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> getData() {
    List x = _xAxisTime;
    List<BarChartGroupData> widgets = [];
    for (int i = 0; i < _xAxisTime.length; i++) {
      widgets.add(
        BarChartGroupData(
          showingTooltipIndicators: [0],
          x: i,
          // barsSpace: 4,
          barRods: [
            BarChartRodData(
              toY: _yAxisAmount[i],
              color: _barColor,
              width: _barWidth,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
          ],
        ),
      );
    }

    return widgets;
  }
}
