import 'package:flutter/material.dart';
import 'package:flutter_chart/media_query_layout.dart';

import 'dense_bar_chart.dart';
import 'hi_chart.dart';
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
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart, package: fl_chart'),
        elevation: 0,
        // foregroundColor: Colors.white,
        // backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      // backgroundColor: Colors.black54,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const <Widget>[
          // ** PIE CHART **
          // PieChartSample2(), // 알츠윈매니저 - 캠페인상세

          // ** BAR CHART **
          DenseBarChart(), // 알츠윈매니저 - 사용정보
          SizedBox(height: 18),
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
      ),
    );
  }
}
