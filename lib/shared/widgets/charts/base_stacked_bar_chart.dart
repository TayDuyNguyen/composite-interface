import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Stacked Bar Chart Component
/// Generic, reusable stacked bar chart for comparing multiple data series
class BaseStackedBarChart extends StatelessWidget {
  final String title;
  final List<ChartStackedBarData> data;
  final double? maxY;
  final double? minY;
  final bool showLegend;
  final bool showGrid;
  final double? barWidth;
  final TextStyle? titleStyle;
  final String? yAxisLabel;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool rotateLabels;
  final double labelRotationAngle;

  const BaseStackedBarChart({
    super.key,
    required this.title,
    required this.data,
    this.maxY,
    this.minY = 0,
    this.showLegend = true,
    this.showGrid = true,
    this.barWidth = 22,
    this.titleStyle,
    this.yAxisLabel,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeOut,
    this.rotateLabels = false,
    this.labelRotationAngle = -45,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedMaxY = maxY ?? _calculateMaxY();
    final seriesNames = _getSeriesNames();

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
            if (showLegend) ...[
              _buildLegend(seriesNames),
              const SizedBox(height: 16),
            ],
            LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxWidth < 400 ? 200.0 : 250.0;

                return SizedBox(
                  height: height,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: calculatedMaxY,
                      minY: minY,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final barData = data[group.x];
                            final seriesName = seriesNames[rodIndex];
                            final value = barData.values[rodIndex];
                            return BarTooltipItem(
                              '${barData.label}\n$seriesName: ${value.toStringAsFixed(1)}',
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
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              );

                              if (rotateLabels) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Transform.rotate(
                                    angle: labelRotationAngle * 3.14159 / 180,
                                    alignment: Alignment.centerRight,
                                    child: Align(
                                      alignment: const Alignment(-0.3, -1.0),
                                      child: label,
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: label,
                                );
                              }
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
                        horizontalInterval: calculatedMaxY / 5,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.shade200,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      barGroups: data.asMap().entries.map((entry) {
                        double stackedHeight = 0;
                        final rods = <BarChartRodStackItem>[];

                        for (int i = 0; i < entry.value.values.length; i++) {
                          final value = entry.value.values[i];
                          final color =
                              entry.value.colors?[i] ?? _getDefaultColor(i);

                          rods.add(
                            BarChartRodStackItem(
                              stackedHeight,
                              stackedHeight + value,
                              color,
                            ),
                          );
                          stackedHeight += value;
                        }

                        return BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: stackedHeight,
                              color: Colors.transparent,
                              width: barWidth,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                              rodStackItems: rods,
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

  Widget _buildLegend(List<String> seriesNames) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: seriesNames.asMap().entries.map((entry) {
        final index = entry.key;
        final name = entry.value;
        final color = _getDefaultColor(index);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  List<String> _getSeriesNames() {
    if (data.isEmpty) return [];
    return data.first.seriesNames ??
        List.generate(data.first.values.length, (i) => 'Series ${i + 1}');
  }

  double _calculateMaxY() {
    if (data.isEmpty) return 100;
    double max = 0;
    for (var bar in data) {
      final sum = bar.values.fold(0.0, (a, b) => a + b);
      if (sum > max) max = sum;
    }
    return max * 1.1;
  }

  Color _getDefaultColor(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.cyan,
      Colors.orange,
      Colors.pink,
    ];
    return colors[index % colors.length];
  }
}

/// Chart Stacked Bar Data Model
class ChartStackedBarData {
  final String label;
  final List<double> values;
  final List<Color>? colors;
  final List<String>? seriesNames;

  ChartStackedBarData({
    required this.label,
    required this.values,
    this.colors,
    this.seriesNames,
  });
}
