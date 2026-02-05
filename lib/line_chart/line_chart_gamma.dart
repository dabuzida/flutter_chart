import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartGamma extends StatefulWidget {
  const LineChartGamma({super.key});

  @override
  State<LineChartGamma> createState() => _LineChartGammaState();
}

class _LineChartGammaState extends State<LineChartGamma> {
  List<int> showingTooltipOnSpots = [1, 3, 5, 4, 0, 6];

  List<FlSpot> get allSpots => const [
        FlSpot(0, 1),
        FlSpot(1, 2),
        FlSpot(2, 1.5),
        FlSpot(3.3, 3),
        FlSpot(4, 3.5),
        FlSpot(5, 5),
        FlSpot(6, 8),
      ];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '00:00';
        break;
      case 1:
        text = '04:00';
        break;
      case 2:
        text = '08:00';
        break;
      case 3:
        text = '12:00';
        break;
      case 4:
        text = '16:00';
        break;
      case 5:
        text = '20:00';
        break;
      case 6:
        text = '23:59';
        break;
      default:
        return Container();
    }

    return Container(
      // width: 50,
      // height: 50,
      color: Colors.transparent,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<LineChartBarData> lineBarsData = <LineChartBarData>[
      LineChartBarData(
        // show: false,
        showingIndicators: showingTooltipOnSpots, // 데이터 중에서 툴팁 표현할 좌표
        spots: allSpots, // 모든 데이터의 좌표
        isCurved: false,
        barWidth: 2,
        // TODO: 꺾은선 주변 그림자
        // shadow: const Shadow(
        //   blurRadius: 8,
        // ),
        // TODO: 꺾은선의 아래 부분 색상 넣기
        // belowBarData: BarAreaData(
        //   show: true,
        //   gradient: LinearGradient(
        //     colors: [
        //       Colors.green.shade100,
        //       Colors.green.shade300,
        //       Colors.green.shade500,
        //     ],
        //   ),
        // ),
        dotData: const FlDotData(
          show: true,
          // checkToShowDot: ,
          // getDotPainter: ,
        ), // 꺾은선 자체 dot

        // TODO: 꺾은선 색 그라데이션
        // gradient: LinearGradient(
        //   colors: [
        //     Colors.blue.shade100,
        //     Colors.blue.shade300,
        //     Colors.blue.shade500,
        //   ],
        //   stops: const [0.1, 0.4, 0.9],
        // ),
      ),
    ];

    final LineChartBarData tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 10,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(
              extraLinesData: ExtraLinesData(
                  // extraLinesOnTop: true,
                  // horizontalLines: false,
                  ),
              showingTooltipIndicators: showingTooltipOnSpots.map(
                (int index) {
                  return ShowingTooltipIndicators(
                    <LineBarSpot>[
                      LineBarSpot(
                        tooltipsOnBar,
                        lineBarsData.indexOf(tooltipsOnBar),
                        tooltipsOnBar.spots[index],
                      ),
                    ],
                  );
                },
              ).toList(),
              lineTouchData: LineTouchData(
                enabled: false,
                handleBuiltInTouches: false,
                touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                  if (!event.isInterestedForInteractions || response == null || response.lineBarSpots == null) {
                    print(222);
                    return;
                  }

                  response?.lineBarSpots;
                  print(111);

                  // if (response == null || response. == null) {
                  //   return;
                  // }
                  // if (event is FlTapUpEvent) {
                  //   final spotIndex = response.lineBarSpots!.first.spotIndex;
                  //   setState(() {
                  //     if (showingTooltipOnSpots.contains(spotIndex)) {
                  //       showingTooltipOnSpots.remove(spotIndex);
                  //     } else {
                  //       showingTooltipOnSpots.add(spotIndex);
                  //     }
                  //   });
                  // }
                },
                // mouseCursorResolver: (FlTouchEvent event, LineTouchResponse? response) {
                // TODO: 꺾은선 그래프에 마우스 호버시 모양 바뀜
                //   if (response == null || response.lineBarSpots == null) {
                //     return SystemMouseCursors.basic;
                //   }
                //   return SystemMouseCursors.click;
                // },
                getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                  // TODO: 꺾은선 그래프 위의 dot UI

                  return spotIndexes.map(
                    (int index) {
                      return TouchedSpotIndicatorData(
                        const FlLine(
                          // color: Colors.pink, // 수직선 색
                          color: Colors.transparent,
                        ),
                        FlDotData(
                          show: false,
                          getDotPainter: (FlSpot spot, double percent, LineChartBarData barData, int index) => FlDotCirclePainter(
                              // radius: 8,
                              // color: Colors.teal, // 그래프 상의 dot 색상
                              // color: Colors.transparent,
                              // color: lerpGradient(
                              //   barData.gradient!.colors,
                              //   barData.gradient!.stops!,
                              //   percent / 100,
                              // ),
                              // strokeWidth: 2,
                              // strokeColor: Colors.grey,
                              ),
                        ),
                      );
                    },
                  ).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  // getTooltipColor: (LineBarSpot touchedSpot) => Colors.purple, // 툴팁 네모상자 바탕색
                  getTooltipColor: (LineBarSpot touchedSpot) => Colors.transparent,
                  // tooltipRoundedRadius: 8,
                  // tooltipHorizontalOffset: ,
                  tooltipMargin: 1,
                  // tooltipHorizontalAlignment: FLHorizontalAlignment.left,
                  // tooltipPadding: EdgeInsets.all(0),
                  // showOnTopOfTheChartBoxArea: ,
                  // fitInsideVertically: true,
                  // fitInsideHorizontally: true,

                  getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                    return lineBarsSpot.map(
                      (LineBarSpot lineBarSpot) {
                        return LineTooltipItem(
                          lineBarSpot.y.toString(),
                          const TextStyle(
                            // color: Colors.white, // 툴팁 네모상자 내부 글자색
                            // color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ).toList();
                  },
                ),
              ),
              lineBarsData: lineBarsData,
              minY: 0,
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  axisNameWidget: Text('count'),
                  axisNameSize: 24,
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return bottomTitleWidgets(
                        value,
                        meta,
                        constraints.maxWidth,
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
                rightTitles: const AxisTitles(
                  axisNameWidget: Text('count'),
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
                topTitles: const AxisTitles(
                  axisNameWidget: Text(
                    'Wall clock',
                    textAlign: TextAlign.left,
                  ),
                  axisNameSize: 24,
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 0,
                  ),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.pink,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
