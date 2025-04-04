import 'package:flutter/material.dart';
import 'package:flutter_chart/bar_bar_chart2.dart';
import 'package:flutter_chart/bar_bar_chart3.dart';
import 'package:flutter_chart/bar_line/bar_line_chart.dart';
import 'package:flutter_chart/line_chart/line_chart_beta.dart';
import 'package:flutter_chart/line_chart/line_chart_delta.dart';
import 'package:flutter_chart/line_chart/line_chart_epsilon.dart';
import 'package:flutter_chart/line_chart/line_chart_gamma.dart';
import 'package:flutter_chart/media_query_layout.dart';
import 'package:flutter_chart/pie_chart/my_pie_chart.dart';
import 'package:flutter_chart/test2.dart';

import 'bar_bar_chart.dart';
import 'hi_chart.dart';
import 'line_chart/line_chart_alpha.dart';
import 'month_call_amount.dart';
import 'month_call_count.dart';
import 'my_chart.dart';
import 'pie_chart/pie_chart_sample2.dart';
import 'test.dart';
import 'today_call_amount.dart';
import 'today_call_count.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   primaryColor: const Color(0xff262545),
      //   primaryColorDark: const Color(0xff201f39),
      //   brightness: Brightness.dark,
      // ),
      title: 'Chart',
      home: const MyScreen(),
    );
  }
}

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart, package: fl_chart'),
        elevation: 0,
        // foregroundColor: Colors.white,
        // backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      // backgroundColor: Colors.grey.shade300,

      // 1
      // body: MyLineChartt(),
      body: Container(
        height: 800,
        decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        child: ListView(
          children: const <Widget>[
            // MyPieChart(),
            // LineChartAlpha(),
            // LineChartBeta(),
            // LineChartGamma(),
            // LineChartEpsilon(),
            // LineChartDelta(),
            LineChartEpsilon(),
            // PieChartSample2(),
            // const BarBarChart3(),
            // const BarBarChart2(),
            // const BarBarChart(),
            // const Test2(),
          ],
        ),
      ),
      // body: const BarBarChart2(),
      // body: const BarBarChart(),
      // body: Test2(),

// 2
/* 
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const <Widget>[
          // ** PIE CHART **
          // PieChartSample2(), // 알츠윈매니저 - 캠페인상세

          /////////////////////////////////////////////
          // 알츠윈매니저 - 사용정보
          // 1.막대그래프(비용) + 꺾은 선 그래프(횟수)
          // BarLineChart(),
          // SizedBox(height: 18),

          // 3.BAR CHART: 비용, 횟수 모두 막대 그래프
          // BarBarChart(),
          // SizedBox(height: 18),

          // 2.꺾은 선 그래프 연습
          // LineChartt(),
          // SizedBox(height: 18),

          /////////////////////////////////////////////

          Test2(),
          Test(), // 센텐츠매니저 - 홈
          SizedBox(height: 18),
          TodayCallAmount(), // 2
          SizedBox(height: 18),
          MonthCallAmount(), // 4
          SizedBox(height: 18),
          MonthCallCount(), // 3
          SizedBox(height: 18),
          TodayCallCount(), // 1
          HiChart(),
          MyChart(),
        ],
      ), */
    );
  }
}
