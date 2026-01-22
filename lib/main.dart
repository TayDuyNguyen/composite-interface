import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:myapp/app/navigation/app_router.dart';
import 'package:myapp/shared/widgets/charts/base_area_chart.dart';

/// Main entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const TestWidget());
}

/// Main app widget
class MyApp extends StatelessWidget {
  /// App widget constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: AppRouter.router);
  }
}

// Test widget
class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  static const List<FlSpot> _chartData = [
    FlSpot(0, 3.1),
    FlSpot(1, 4.2),
    FlSpot(2, 3.8),
    FlSpot(3, 5.0),
    FlSpot(4, 5.2),
    FlSpot(5, 6.1),
    FlSpot(6, 5.8),
    FlSpot(7, 7.2),
    FlSpot(8, 7.5),
    FlSpot(9, 8.8),
    FlSpot(10, 8.2),
    FlSpot(11, 9.5),
  ];

  static const List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: BaseAreaChart(
              title: 'Monthly Revenue Growth',
              data: _chartData,
              xLabels: _months,
              lineColor: Colors.teal,
              fillStartColor: Colors.teal,
              xAxisLabel: 'Months (2025)',
              yAxisLabel: 'Revenue (\$k)',
            ),
          ),
        ),
      ),
    );
  }
}
