import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Area Chart Component
/// Generic, reusable area chart for showing trends with filled area
class BaseAreaChart extends StatelessWidget {
  final String title;
  final List<FlSpot> data;
  final double? maxY;
  final double? minY;
  final Color? lineColor;
  final Color? fillStartColor;
  final Color? fillEndColor;
  final List<String>? xLabels;
  final bool showGrid;
  final bool isCurved;
  final bool showDots;
  final double? lineWidth;
  final TextStyle? titleStyle;
  final String? xAxisLabel;
  final String? yAxisLabel;
  final Duration animationDuration;
  final Curve animationCurve;

  const BaseAreaChart({
    super.key,
    required this.title,
    required this.data,
    this.maxY,
    this.minY = 0,
    this.lineColor,
    this.fillStartColor,
    this.fillEndColor,
    this.xLabels,
    this.showGrid = true,
    this.isCurved = true,
    this.showDots = true,
    this.lineWidth = 3,
    this.titleStyle,
    this.xAxisLabel,
    this.yAxisLabel,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedMaxY = maxY ?? _calculateMaxY();
    final calculatedMinY = minY ?? _calculateMinY();
    final color = lineColor ?? Colors.blue;
    final startColor = fillStartColor ?? color.withValues(alpha: 0.4);
    final endColor = fillEndColor ?? color.withValues(alpha: 0.0);

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
                            color: Colors.grey.shade200,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
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
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  xLabels![index],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
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
                          barWidth: lineWidth!,
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
                            show: true,
                            gradient: LinearGradient(
                              colors: [startColor, endColor],
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
