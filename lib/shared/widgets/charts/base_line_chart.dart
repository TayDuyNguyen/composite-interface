import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Line Chart Component
/// Generic, reusable line chart that accepts any data
class BaseLineChart extends StatelessWidget {
  final String title;
  final List<FlSpot> data;
  final double? maxY;
  final double? minY;
  final Color? lineColor;
  final List<String>? xLabels;
  final String? xAxisLabel;
  final String? yAxisLabel;
  final bool showGrid;
  final bool isCurved;
  final bool showDots;
  final bool showArea;
  final double? lineWidth;
  final TextStyle? titleStyle;
  final Color? gridColor;
  final Duration animationDuration;
  final Curve animationCurve;

  const BaseLineChart({
    super.key,
    required this.title,
    required this.data,
    this.maxY,
    this.minY = 0,
    this.lineColor,
    this.xLabels,
    this.xAxisLabel,
    this.yAxisLabel,
    this.showGrid = true,
    this.isCurved = true,
    this.showDots = true,
    this.showArea = true,
    this.lineWidth = 3,
    this.titleStyle,
    this.gridColor,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedMaxY = maxY ?? _calculateMaxY();
    final calculatedMinY = minY ?? _calculateMinY();
    final color = lineColor ?? Colors.black;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle ??
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxWidth < 400 ? 200.0 : 250.0;

                return SizedBox(
                  height: height,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: (data.length - 1).toDouble(),
                      minY: calculatedMinY,
                      maxY: calculatedMaxY,
                      gridData: FlGridData(
                        show: showGrid,
                        drawVerticalLine: false,
                        horizontalInterval:
                            (calculatedMaxY - calculatedMinY) / 5,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: gridColor ?? Colors.grey.shade200,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 35,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: xLabels != null,
                            getTitlesWidget: (value, meta) {
                              if (xLabels == null) {
                                return const SizedBox.shrink();
                              }
                              final index = value.toInt();
                              if (index < 0 || index >= xLabels!.length) {
                                return const SizedBox.shrink();
                              }
                              return Text(
                                xLabels![index],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (List<LineBarSpot> touchedSpots) {
                            return touchedSpots.map((LineBarSpot touchedSpot) {
                              final label = xLabels != null &&
                                      touchedSpot.x.toInt() < xLabels!.length
                                  ? xLabels![touchedSpot.x.toInt()]
                                  : 'X: ${touchedSpot.x.toInt()}';
                              return LineTooltipItem(
                                '$label\n${touchedSpot.y.toStringAsFixed(1)}',
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: data,
                          isCurved: isCurved,
                          color: color,
                          barWidth: lineWidth ?? 3,
                          dotData: FlDotData(
                            show: showDots,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Colors.white,
                                strokeWidth: 2,
                                strokeColor: color,
                              );
                            },
                          ),
                          belowBarData: BarAreaData(
                            show: showArea,
                            gradient: LinearGradient(
                              colors: [
                                color.withValues(alpha: 0.3),
                                color.withValues(alpha: 0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                    duration: animationDuration,
                    curve: animationCurve,
                  ),
                );
              },
            ),
            if (xAxisLabel != null || yAxisLabel != null) ...[
              const SizedBox(height: 10),
              if (xAxisLabel != null)
                Center(
                  child: Text(
                    xAxisLabel!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  double _calculateMaxY() {
    if (data.isEmpty) return 100;
    final max = data.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    return max * 1.1;
  }

  double _calculateMinY() {
    if (data.isEmpty) return 0;
    final min = data.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    return min < 0 ? min * 1.1 : 0;
  }
}
