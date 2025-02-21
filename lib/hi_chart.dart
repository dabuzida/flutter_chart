import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart/data.dart';

class HiChart extends StatefulWidget {
  const HiChart({super.key});

  @override
  State<HiChart> createState() => _HiChartState();
}

class _HiChartState extends State<HiChart> {
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);

  final List<String> _xAxisTime = [];
  final List<int> _yAxisNumber = [];
  late final double _yAxisMax;
  final double _yAxisInterval = 10.0;

  @override
  void initState() {
    super.initState();
    _initiateData();
  }

  void _initiateData() {
    for (int i = 0; i < CallChart.monthNumber.values.first.values.first.length; i++) {
      _xAxisTime.add(CallChart.monthNumber.values.first.values.first[i].values.first);
      _yAxisNumber.add(CallChart.monthNumber.values.first.values.first[i].values.last);
    }

    _yAxisMax = _yAxisNumber.reduce(max) + 10.0;
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.blue, fontSize: 10);
    // const style = TextStyle(color: Color(0xffffffff), fontSize: 10);
    // const style = TextStyle(color: Color(0xffffffff), fontSize: 20);
    // const style = TextStyle(color: Color(0xff939393), fontSize: 0);

    List<String> x = _xAxisTime;
    String text = x[value.toInt()].substring(5, 10);
    // String text = x[value.toInt()].substring(0, 10);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 0,
      // angle: -0.3,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      color: Colors.purple,
      fontSize: 20,
      // fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
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
        // color: Colors.white,
        // color: Color(0xff7589a2),
        // color: Colors.grey[500],
        // color: const Color(0xff2c4260),

        // surfaceTintColor: Colors.yellow,
        // shadowColor: Colors.white,
        borderOnForeground: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BarChart(
            BarChartData(
              maxY: _yAxisMax,
              // minY: ,
              alignment: BarChartAlignment.center,
              barTouchData: BarTouchData(
                enabled: true,
                // allowTouchBarBackDraw: true,
                // handleBuiltInTouches: true,
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
                      const TextStyle(
                        color: Colors.black,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                  // tooltipBgColor: const Color.fromARGB(0, 81, 116, 82),
                  // tooltipBorder: BorderSide(width: 1),
                  // maxContentWidth: 50,
                  tooltipMargin: 3,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  axisNameWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // textDirection: TextDirection.ltr,
                    children: const [
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(90 / 360),
                        child: Text(
                          '(건)',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // RotationTransition(
                      //   turns: AlwaysStoppedAnimation(90 / 360),
                      //   child: Text('통화수'),
                      // ),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(90 / 360),
                        child: Text(
                          '수',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(90 / 360),
                        child: Text(
                          '화',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(90 / 360),
                        child: Text(
                          '통',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  axisNameSize: 40,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: leftTitles,
                    interval: _yAxisInterval,
                  ),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: const Text(
                    '시간대 [2022.9.14 ~ 2022.10.13]',
                    style: TextStyle(color: Colors.teal),
                  ),
                  // drawBehindEverything: false,
                  axisNameSize: 60,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: bottomTitles,
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
                  axisNameWidget: const Text(
                    '최근 30일 통화수',
                    style: TextStyle(
                      color: Colors.blueGrey,
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
                show: false,
              ),
              groupsSpace: 30,
              barGroups: getData(),
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.lightBlueAccent,
          Colors.greenAccent,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

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
              toY: _yAxisNumber[i] as double,
              borderSide: const BorderSide(
                width: 0,
                // style: BorderStyle.,
                // strokeAlign: StrokeAlign.center,
              ),
              // color: Colors.amber,
              // color: Colors.white,
              gradient: _barsGradient,
              width: 8,
              // color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
              // borderRadius: BorderRadius.all(Radius.elliptical(4, 11)),
              // borderRadius: BorderRadius.horizontal(
              //   left: Radius.circular(
              //     3,
              //   ),
              //   right: Radius.circular(
              //     11,
              //   ),
              // ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(
                  4,
                ),
                // right: Radius.circular(
                //   11,
                // ),
              ),
              // borderRadius: BorderRadius.all(Radius.circular(22)),
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
            toY: _yAxisNumber[0] as double,
            borderRadius: BorderRadius.zero,
          ),
        ],
      ),
    ];
  }
}
