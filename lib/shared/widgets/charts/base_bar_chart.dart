import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Bar Chart Component
/// Generic, reusable bar chart that accepts any data
class BaseBarChart extends StatelessWidget {
  final String title;
  final List<ChartBarData> data;
  final double? maxY;
  final double? minY;
  final Color? defaultBarColor;
  final bool showLegend;
  final bool showGrid;
  final double? barWidth;
  final TextStyle? titleStyle;
  final String? yAxisLabel;
  final Color? gridColor;
  final bool rotateLabels;
  final double labelRotationAngle;
  final Duration animationDuration;
  final Curve animationCurve;

  const BaseBarChart({
    super.key,
    required this.title,
    required this.data,
    this.maxY,
    this.minY = 0,
    this.defaultBarColor,
    this.showLegend = false,
    this.showGrid = true,
    this.barWidth = 20,
    this.titleStyle,
    this.yAxisLabel,
    this.gridColor,
    this.rotateLabels = false,
    this.labelRotationAngle = -45,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedMaxY = maxY ?? _calculateMaxY();
    final calculatedMinY = minY ?? 0;

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
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: calculatedMaxY,
                      minY: calculatedMinY,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final barData = data[group.x];
                            return BarTooltipItem(
                              '${barData.label}\n${rod.toY.toStringAsFixed(1)}',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
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
                            showTitles: true,
                            reservedSize: rotateLabels ? 60 : 30,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= data.length) {
                                return const SizedBox.shrink();
                              }

                              final label = Text(
                                data[index].label,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              );

                              if (rotateLabels) {
                                return SizedBox(
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Transform.rotate(
                                      angle: labelRotationAngle * 3.14159 / 180,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 24.0),
                                        child: label,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: label,
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
                      barGroups: data.asMap().entries.map((entry) {
                        return BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.value,
                              color: entry.value.color ??
                                  defaultBarColor ??
                                  Colors.blue,
                              width: barWidth,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    duration: animationDuration,
                    curve: animationCurve,
                  ),
                );
              },
            ),
            if (yAxisLabel != null) ...[
              const SizedBox(height: 10),
              Center(
                child: Text(
                  yAxisLabel!,
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
    final max = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return max * 1.1;
  }
}

/// Chart Bar Data Model
class ChartBarData {
  final String label;
  final double value;
  final Color? color;

  ChartBarData({
    required this.label,
    required this.value,
    this.color,
  });
}
