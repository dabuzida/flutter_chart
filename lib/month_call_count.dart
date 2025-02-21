import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'functions.dart';

class MonthCallCount extends StatefulWidget {
  const MonthCallCount({super.key});

  @override
  State<MonthCallCount> createState() => _MonthCallCountState();
}

class _MonthCallCountState extends State<MonthCallCount> {
  final List<String> _xAxisTime = [];
  late final double _yAxisMax;

  final String _chartTitle = '최근 30일-일별 통화수';
  final Color _chartTitleColor = Colors.cyanAccent;

  final String _yAxisTitle = '통화수 [건]';
  final Color _yAxisTitleColor = Colors.cyanAccent;
  final Color _yAxisValueColor = Colors.cyanAccent;
  final List<double> _yAxisCount = [];
  final double _yAxisInterval = 10.0;

  String _periodHead = '';
  String _periodTail = '';
  String _xAxisTitle = '시간';
  final Color _xAxisTitleColor = Colors.cyanAccent;
  final Color _xAxisValueColor = Colors.cyanAccent;

  final Color _backgroundColor = Colors.black;
  // final Color _backgroundColor = const Color(0xff2c4260);

  final Color _barTooltipValueColor = Colors.yellowAccent;

  final LinearGradient _barGradient = const LinearGradient(
    colors: [
      // Colors.white,
      Colors.cyanAccent,
      Colors.cyanAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  @override
  void initState() {
    super.initState();
    _initiateData();
  }

  void _initiateData() {
    for (int i = 0; i < CallChart.monthNumber.values.first.values.first.length; i++) {
      String date = _makeDate(date: CallChart.monthNumber.values.first.values.first[i].values.first);
      _xAxisTime.add('${date.substring(5, 10)}\n${date.substring(11, 12)}');
      // _xAxisTime.add(date.substring(5, 12));
      // _xAxisTime.add(CallChart.monthNumber.values.first.values.first[i].values.first);
      _yAxisCount.add(CallChart.monthNumber.values.first.values.first[i].values.last as double);
      if (i == 0) {
        _periodHead = date;
      } else if (i == CallChart.monthNumber.values.first.values.first.length - 1) {
        _periodTail = date;
      }
    }

    _yAxisMax = _yAxisCount.reduce(max) + 10.0;
    _xAxisTitle = '$_xAxisTitle [$_periodHead ~ $_periodTail]';
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
    final String xAxisValue = xAxisTime[value.toInt()];
    // final String xAxisValue = xAxisTime[value.toInt()].substring(5, 10);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        xAxisValue,
        textAlign: TextAlign.center,
      ),
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
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: _backgroundColor,
        borderOnForeground: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: BarChart(
            BarChartData(
              maxY: _yAxisMax,
              alignment: BarChartAlignment.center,
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
                  // tooltipBgColor: Colors.transparent,
                  tooltipMargin: 1,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  axisNameWidget: Row(
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
                          '건',
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
                          '수',
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
                  ),
                  axisNameSize: 35,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
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
                drawVerticalLine: true,
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(
                    color: Colors.red[100]!,
                  ),
                  bottom: BorderSide(
                    color: Colors.red[100]!,
                  ),
                ),
              ),
              groupsSpace: 35,
              barGroups: getData(),
            ),
          ),
        ),
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
          barsSpace: 4,
          barRods: [
            BarChartRodData(
              toY: _yAxisCount[i],
              gradient: _barGradient,
              width: 8,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
          ],
        ),
      );
    }

    return widgets;
  }
}
