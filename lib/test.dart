import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<String> _xAxisTime = [];
  List<double> _yAxisAmount = [];

  double _yAxisMax = 5;

  Color _backgroundColor = const Color.fromARGB(59, 182, 168, 168);
  Color _barValueColor = const Color(0xFF6BCF7E);

  @override
  void initState() {
    super.initState();

    _xAxisTime.add('a');
    _xAxisTime.add('b');
    _yAxisAmount.add(3.0);
    _yAxisAmount.add(4.0);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    // print(width);
    // print(1);
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.66,
          child: BarChart(
            key: UniqueKey(),
            BarChartData(
              maxY: _yAxisMax,
              barTouchData: BarTouchData(
                enabled: false,
              ),
              barGroups: getData(),
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(
                  axisNameWidget: const Text(
                    'XXXXXXXXXXXXXXXXXXXX',
                  ),
                  axisNameSize: 60,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 58,

                    // getTitlesWidget: _makeXAxisMarking(size: 's'),
                  ),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: Text(
                    'X-AXIS title',
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                  ),
                  axisNameSize: 60,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 58,
                    // getTitlesWidget: _makeXAxisMarking(size: 's'),
                  ),
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            _xAxisTime.add('asd');
            _yAxisAmount.add(4);
            await Future.delayed(const Duration(milliseconds: 500));
            setState(() {});
          },
          child: const Text(
            'btn',
          ),
        ),
      ],
    );
  }

  Widget _makeXAxisMarking(double value, TitleMeta meta, {required String size}) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('d'),
    );
  }

  List<BarChartGroupData> getData() {
    List<BarChartGroupData> widgets = [];
    for (int i = 0; i < _xAxisTime.length; i++) {
      widgets.add(
        BarChartGroupData(
          showingTooltipIndicators: <int>[0],
          x: i,
          barRods: [
            BarChartRodData(
              toY: _yAxisAmount[i],
              width: 4,
            ),
          ],
        ),
      );
    }

    return widgets;
  }
}
