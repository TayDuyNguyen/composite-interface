import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Horizontal Bar Chart Component
/// Generic, reusable horizontal bar chart for ranking and comparison
class BaseHorizontalBarChart extends StatelessWidget {
  final String title;
  final List<ChartHorizontalBarData> data;
  final double? maxX;
  final double? minX;
  final Color? defaultBarColor;
  final bool showLegend;
  final bool showGrid;
  final double? barHeight;
  final TextStyle? titleStyle;
  final String? xAxisLabel;
  final Duration animationDuration;
  final Curve animationCurve;

  const BaseHorizontalBarChart({
    super.key,
    required this.title,
    required this.data,
    this.maxX,
    this.minX = 0,
    this.defaultBarColor,
    this.showLegend = false,
    this.showGrid = true,
    this.barHeight = 20,
    this.titleStyle,
    this.xAxisLabel,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedMaxX = maxX ?? _calculateMaxX();

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
                final height =
                    (data.length * (barHeight! + 20)).clamp(200.0, 400.0);

                return SizedBox(
                  height: height,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: calculatedMaxX,
                      minY: minX,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final barData = data[group.x];
                            return BarTooltipItem(
                              '${barData.label}: ${rod.toY.toStringAsFixed(1)}',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 100,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= data.length) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  data[index].label,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  value.toInt().toString(),
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
                      gridData: FlGridData(
                        show: showGrid,
                        drawHorizontalLine: false,
                        verticalInterval: calculatedMaxX / 5,
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Colors.grey.shade200,
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
                                  Colors.black,
                              width: barHeight,
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(4),
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
          ],
        ),
      ),
    );
  }

  double _calculateMaxX() {
    if (data.isEmpty) return 100;
    final max = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return max * 1.1;
  }
}

/// Chart Horizontal Bar Data Model
class ChartHorizontalBarData {
  final String label;
  final double value;
  final Color? color;

  ChartHorizontalBarData({
    required this.label,
    required this.value,
    this.color,
  });
}
