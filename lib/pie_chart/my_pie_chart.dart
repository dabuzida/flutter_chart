import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class MyPieChart extends StatefulWidget {
  const MyPieChart({super.key});

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  final double radius = 8.0;
  double centerSpaceRadius = 180.0;

  final double frameLength = 200;

  final double sectionsSpace = 0.0;
  final double startDegreeOffset = -90;
  final double valueAll = 60;
  final double valuePart = 22;

  final Color colorAll = const Color(0xFFD5D5D5);
  final Color colorPart = const Color(0xFF0E81C9);
  // final Color colorPart = const Color(0xFF4D4D4D);

  @override
  void initState() {
    super.initState();
    // _fetchCountCustomer();

    centerSpaceRadius = frameLength * 0.4;
  }

  List<PieChartSectionData> _makeSections() {
    List<PieChartSectionData> list = [];

    list.add(
      PieChartSectionData(
        // title: '40%',
        value: valuePart,
        radius: radius,
        color: colorPart,
        titleStyle: const TextStyle(color: Colors.transparent),
      ),
    );
    list.add(
      PieChartSectionData(
        // title: '30% 1명',
        value: valueAll - valuePart,
        radius: radius,
        color: colorAll,
        titleStyle: const TextStyle(color: Colors.transparent),
      ),
    );

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: frameLength,
            decoration: BoxDecoration(border: Border.all(color: Colors.green)),
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  sections: _makeSections(),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: sectionsSpace,
                  centerSpaceRadius: centerSpaceRadius,
                  startDegreeOffset: startDegreeOffset,
                  // pieTouchData: PieTouchData(
                  //   touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  //     setState(() {
                  //       if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                  //         touchedIndex = -1;
                  //         return;
                  //       }
                  //       touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  //     });
                  //   },
                  // ),
                ),
              ),
            ),
          ),
          Container(
            width: frameLength,
            height: frameLength,
            // color: Colors.amber.shade100,
            alignment: Alignment.center,
            child: Container(
              width: 130,
              height: 130,
              // color: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          '$valuePart',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' / ',
                        ),
                        Text(
                          '$valueAll',
                        ),
                      ],
                    ),
                    Text(
                      'ESG',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // _makeLegend(),
  }

  Widget _makeLegend() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Indicator(
          color: Color(0xff0293ee),
          text: 'First',
          isSquare: true,
        ),
        SizedBox(
          height: 4,
        ),
        Indicator(
          color: Color(0xfff8b250),
          text: 'Second',
          isSquare: true,
        ),
        SizedBox(
          height: 4,
        ),
        Indicator(
          color: Color(0xff845bef),
          text: 'Third',
          isSquare: true,
        ),
        SizedBox(
          height: 4,
        ),
        Indicator(
          color: Color(0xff13d38e),
          // color: Color(0xFF00BFA5),
          text: 'Fourth',
          isSquare: true,
        ),
        SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
