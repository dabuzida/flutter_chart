import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
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
                    borderData: FlBorderData(
                      show: false,
                      // show: true,
                    ),
                    sectionsSpace: 10,
                    // centerSpaceRadius: 40,
                    centerSpaceRadius: 40,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    // return List.generate(4, (i) {
    //   final isTouched = i == touchedIndex;
    //   final fontSize = isTouched ? 25.0 : 16.0;
    //   final radius = 200.0;
    //   // final radius = isTouched ? 60.0 : 50.0;
    //   switch (i) {
    //     case 0:
    //       return PieChartSectionData(
    //         color: const Color(0xff0293ee),
    //         value: 40,
    //         title: '40%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: const Color(0xffffffff),
    //         ),
    //       );
    //     case 1:
    //       return PieChartSectionData(
    //         color: const Color(0xfff8b250),
    //         value: 30,
    //         title: '30% 1명',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: const Color(0xffffffff),
    //         ),
    //       );
    //     case 2:
    //       return PieChartSectionData(
    //         color: const Color(0xff845bef),
    //         value: 15,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: const Color(0xffffffff),
    //         ),
    //       );
    //     case 3:
    //       return PieChartSectionData(
    //         color: const Color(0xff13d38e),
    //         value: 15,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: const Color(0xffffffff),
    //         ),
    //       );
    //     default:
    //       throw Error();
    //   }
    // });

    //////////////////////////
    ///
    const fontSize = 16.0;
    const radius = 200.0;
    List<PieChartSectionData> list = [];
    list.add(PieChartSectionData(
      color: const Color(0xff0293ee),
      value: 200,
      title: '40%',
      radius: radius,
      titleStyle: const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
      ),
    ));

    list.add(PieChartSectionData(
      color: const Color(0xfff8b250),
      value: 30,
      title: '30% 1명',
      radius: radius,
      titleStyle: const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
      ),
    ));
    list.add(PieChartSectionData(
      color: const Color(0xff845bef),
      value: 15,
      title: '15%',
      radius: radius,
      titleStyle: const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
      ),
    ));
    list.add(PieChartSectionData(
      color: const Color(0xff13d38e),
      value: 15,
      title: '122222222222225%',
      radius: radius,
      titleStyle: const TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
      ),
    ));
    return list;
  }
}
