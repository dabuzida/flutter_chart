import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'data.dart';
import 'functions.dart';

class TodayCallCount extends StatefulWidget {
  const TodayCallCount({super.key});

  @override
  State<TodayCallCount> createState() => _TodayCallCountState();
}

class _TodayCallCountState extends State<TodayCallCount> {
  final List<String> _xAxisTime = [];
  late final double _yAxisMax;

  String _date = '';

  final String _chartTitle = '오늘-시간별 통화수';
  final Color _chartTitleColor = const Color(0xffffffff);

  final String _yAxisTitle = '통화수 [건]';
  final Color _yAxisTitleColor = const Color(0xffffffff);
  final Color _yAxisValueColor = const Color(0xffffffff);
  final List<double> _yAxisCount = [];
  final double _yAxisInterval = 10.0;

  String _xAxisTitle = '시간'; //  [2022.10.13]
  final Color _xAxisTitleColor = const Color(0xffffffff);
  final Color _xAxisValueColor = const Color(0xffffffff);

  final Color _backgroundColor = Colors.blue[200]!;
  // final Color _backgroundColor = const Color(0xff2c4260);

  // final Color _barTooltipValueColor = const Color.fromARGB(255, 199, 219, 20);
  final Color _barTooltipValueColor = Colors.brown[700]!;

  final LinearGradient _barGradient = const LinearGradient(
    colors: [
      // Colors.white,
      Color(0xFF00C73C),
      Color(0xFF00C73C),

      // Colors.lightBlueAccent,
      // Colors.greenAccent,
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
    for (int i = 0; i < CallChart.todayNumber.values.first.values.first.length; i++) {
      _xAxisTime.add(CallChart.todayNumber.values.first.values.first[i].values.first);
      _yAxisCount.add(CallChart.todayNumber.values.first.values.first[i].values.last as double);
    }

    _yAxisMax = _yAxisCount.reduce(max) + 10.0;
    _date = _makeDate(date: CallChart.todayNumber.values.first.values.first[0].values.first);
    _xAxisTitle = '$_xAxisTitle [$_date]';
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
    final String xAxisValueHead = xAxisTime[value.toInt()].substring(11, 16);
    String xAxisValueTail = (int.parse(xAxisTime[value.toInt()].substring(11, 13)) + 1).toString();
    if (xAxisValueTail.length == 1) {
      xAxisValueTail = '0$xAxisValueTail';
    }
    xAxisValueTail = '$xAxisValueTail:00';

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
                // checkToShowHorizontalLine: (value) => value % 10 == 0,
                // getDrawingHorizontalLine: (value) => FlLine(
                //   color: Colors.red,
                //   // color: const Color(0xffe7e8ec),
                //   strokeWidth: 1,
                // ),

                drawVerticalLine: true,
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(
                    color: Colors.amber,
                  ),
                  bottom: BorderSide(
                    color: Colors.amber,
                  ),
                ),
              ),
              groupsSpace: 40,
              barGroups: getData(),
            ),
          ),
        ),
      ),
    );
  }

  // LinearGradient get _barsGradient => const LinearGradient(
  //       colors: [
  //         Colors.lightBlueAccent,
  //         Colors.greenAccent,
  //       ],
  //       begin: Alignment.bottomCenter,
  //       end: Alignment.topCenter,
  //     );

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
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: _yAxisCount[0] as double,
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
    ];
  }
}
