import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Grouped Bar Chart Component
/// Generic, reusable grouped bar chart for comparing multiple data series side by side
class BaseGroupedBarChart extends StatelessWidget {
  final String title;
  final List<ChartGroupedBarData> data;
  final double? maxY;
  final double? minY;
  final bool showLegend;
  final bool showGrid;
  final double? barWidth;
  final TextStyle? titleStyle;
  final String? yAxisLabel;
  final List<String> groupNames;
  final List<Color>? groupColors;
  final bool rotateLabels;
  final double labelRotationAngle;
  final Duration animationDuration;
  final Curve animationCurve;

  const BaseGroupedBarChart({
    super.key,
    required this.title,
    required this.data,
    required this.groupNames,
    this.maxY,
    this.minY = 0,
    this.showLegend = true,
    this.showGrid = true,
    this.barWidth = 12,
    this.titleStyle,
    this.yAxisLabel,
    this.groupColors,
    this.rotateLabels = false,
    this.labelRotationAngle = -45,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedMaxY = maxY ?? _calculateMaxY();
    final calculatedMinY = minY ?? 0;
    final colors = groupColors ?? _getDefaultColors();

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
                final height = constraints.maxWidth < 400 ? 200.0 : 220.0;

                return SizedBox(
                  height: height,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: calculatedMaxY,
                      minY: calculatedMinY,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final barData = data[group.x];
                            final groupName = rodIndex < groupNames.length
                                ? groupNames[rodIndex]
                                : 'Group ${rodIndex + 1}';
                            final value = barData.values[rodIndex];
                            return BarTooltipItem(
                              '${barData.label}\n$groupName: ${value.toStringAsFixed(0)}',
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
                                  fontWeight: FontWeight.bold,
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
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.shade200,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      barGroups: data.asMap().entries.map((entry) {
                        final rods = <BarChartRodData>[];
                        for (int i = 0; i < entry.value.values.length; i++) {
                          rods.add(
                            BarChartRodData(
                              toY: entry.value.values[i],
                              color: i < colors.length
                                  ? colors[i]
                                  : _getDefaultColors()[i % 3],
                              width: barWidth,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                            ),
                          );
                        }

                        return BarChartGroupData(
                          x: entry.key,
                          barRods: rods,
                          barsSpace: 4,
                        );
                      }).toList(),
                    ),
                    duration: animationDuration,
                    curve: animationCurve,
                  ),
                );
              },
            ),
            if (showLegend) ...[
              const SizedBox(height: 16),
              _buildLegend(colors),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(List<Color> colors) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: groupNames.asMap().entries.map((entry) {
        final index = entry.key;
        final name = entry.value;
        final color = index < colors.length
            ? colors[index]
            : _getDefaultColors()[index % 3];

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              name,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  double _calculateMaxY() {
    if (data.isEmpty) return 100;
    double max = 0;
    for (var bar in data) {
      for (var value in bar.values) {
        if (value > max) max = value;
      }
    }
    return max * 1.1;
  }

  List<Color> _getDefaultColors() {
    return [
      Colors.green,
      const Color(0xFF10b981),
      Colors.yellow,
    ];
  }
}

/// Chart Grouped Bar Data Model
class ChartGroupedBarData {
  final String label;
  final List<double> values;

  ChartGroupedBarData({
    required this.label,
    required this.values,
  });
}
