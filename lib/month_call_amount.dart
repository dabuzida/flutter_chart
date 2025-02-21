import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/extension_string.dart';

import 'data.dart';
import 'functions.dart';

class MonthCallAmount extends StatefulWidget {
  const MonthCallAmount({super.key});

  @override
  State<MonthCallAmount> createState() => _MonthCallAmountState();
}

class _MonthCallAmountState extends State<MonthCallAmount> {
  final List<String> _xAxisTime = [];
  late final double _yAxisMax;

  final String _chartTitle = '최근 30일-일별 통화량';

  final List<double> _yAxisAmount = [];
  double _yAxisInterval = 15.0;
  // double _yAxisInterval = 1.0;

  String _periodHead = '';
  String _periodTail = '';
  String _xAxisTitle = '시간';

  final Color _titleColor = const Color(0xFFBF6575);
  final Color _backgroundColor = const Color(0xFFD1D1D1);
  final Color _axisValueColor = const Color(0xFF825F65);
  final Color _barColor = const Color(0xFF1D5FCF);
  final Color _barValueColor = const Color(0xFF6BCF7E);
  final Color _axisColor = const Color(0xFF000000);

  @override
  void initState() {
    super.initState();
    _initiateData();
  }

  double _getStandardDeviaton() {
    final List list = [];
    double sum = 0;

    for (int i = 0; i < CallChart.monthAmount.values.first.values.first.length; i++) {
      double value = _makeCallUsage(usageSeconds: CallChart.monthAmount.values.first.values.first[i].values.last);
      list.add(value);
      sum += value;
      // sum += CallChart.monthAmount.values.first.values.first[i].values.last;
    }
    final double mean = sum / list.length;
    double sumForDeviation = 0;

    for (int i = 0; i < list.length; i++) {
      sumForDeviation += pow(list[i] - mean, 2);
    }

    final double standardDeviation = sqrt(sumForDeviation / list.length);

    // return 0.5;
    return standardDeviation;
  }

  void _initiateData() {
    for (int i = 0; i < CallChart.monthAmount.values.first.values.first.length; i++) {
      String date = _makeDate(date: CallChart.monthAmount.values.first.values.first[i].values.first);
      _xAxisTime.add('${date.substring(5, 7)}\n${date.substring(8, 10)}\n${date.substring(11, 12)}');

      // _xAxisTime.add('${date.substring(5, 10)}\n${date.substring(11, 12)}');
      // _xAxisTime.add(date.substring(5, 12));
      // _xAxisTime.add(CallChart.monthAmount.values.first.values.first[i].values.first);

      final yAxisValue = _makeCallUsage(usageSeconds: CallChart.monthAmount.values.first.values.first[i].values.last);
      _yAxisAmount.add(yAxisValue);
      if (i == 0) {
        _periodHead = date;
      } else if (i == CallChart.monthAmount.values.first.values.first.length - 1) {
        _periodTail = date;
      }
    }

    _yAxisMax = _yAxisAmount.reduce(max) + _getStandardDeviaton();
    // _yAxisInterval = (_yAxisMax / 2).ceilToDouble();
    _yAxisInterval = (_yAxisMax / 2).floorToDouble();
    _xAxisTitle = '$_xAxisTitle [$_periodHead ~ $_periodTail]';
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
    final String dateTail = dayOfTheWeek.localizeDayToKor2;
    // final String dateTail = MyTimeConversion().localizeDayToKor(engDay: dayOfTheWeek);

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
        style: TextStyle(
          color: _axisValueColor,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _makeYAxisValue(double value, TitleMeta meta) {
    // return Container();
    if (value == meta.max) {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: TextStyle(
          color: _axisValueColor,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(1);
    return Column(
      children: [
        AspectRatio(
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
                            color: _barValueColor,
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
                      // axisNameWidget: Text(''),
                      // axisNameSize: 0,
                      axisNameWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '[',
                            style: TextStyle(
                              fontSize: 20,
                              color: _titleColor,
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
                                color: _titleColor,
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
                                color: _titleColor,
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
                              color: _titleColor,
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
                                color: _titleColor,
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
                                color: _titleColor,
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
                                color: _titleColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      axisNameSize: 35,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: _makeYAxisValue,
                        interval: _yAxisInterval,
                      ),
                    ),
                    topTitles: AxisTitles(
                      axisNameWidget: Text(
                        _chartTitle,
                        style: TextStyle(
                          color: _titleColor,
                          fontSize: 20,
                        ),
                      ),
                      axisNameSize: 50,
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      axisNameSize: 10,
                      axisNameWidget: const Text(''),
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: Text(
                        _xAxisTitle,
                        style: TextStyle(
                          color: _titleColor,
                        ),
                      ),
                      axisNameSize: 60,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 58,
                        getTitlesWidget: _makeXAxisValue,
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
                      left: BorderSide(color: _axisColor),
                      bottom: BorderSide(color: _axisColor),
                    ),
                  ),
                  // groupsSpace: 30,
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: getData(),
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _xAxisTime.add('asd');
            _yAxisAmount.add(230.340);
            setState(() {});
          },
          child: Text(
            'ddddddddddddddddd',
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> getData() {
    List<BarChartGroupData> widgets = [];
    for (int i = 0; i < _xAxisTime.length; i++) {
      widgets.add(
        BarChartGroupData(
          showingTooltipIndicators: [0],
          x: i,
          barRods: [
            BarChartRodData(
              toY: _yAxisAmount[i],
              color: _barColor,
              width: 4,
              borderRadius: BorderRadius.zero,
            ),
          ],
        ),
      );
    }

    return widgets;
  }
}
