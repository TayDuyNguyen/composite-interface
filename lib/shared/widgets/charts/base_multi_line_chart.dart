import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Multi Line Chart Component
/// Generic, reusable chart for displaying multiple lines
class BaseMultiLineChart extends StatelessWidget {
  final String title;
  final List<ChartLineSeriesData> series;
  final double? maxY;
  final double? minY;
  final double? maxX;
  final double? minX;
  final List<String>? xLabels;
  final bool showLegend;
  final bool showGrid;
  final bool isCurved;
  final bool showDots;
  final bool showArea;
  final TextStyle? titleStyle;
  final String? xAxisLabel;
  final String? yAxisLabel;
  final Duration animationDuration;
  final Curve animationCurve;

  const BaseMultiLineChart({
    super.key,
    required this.title,
    required this.series,
    this.maxY,
    this.minY,
    this.maxX,
    this.minX,
    this.xLabels,
    this.showLegend = true,
    this.showGrid = true,
    this.isCurved = true,
    this.showDots = true,
    this.showArea = false,
    this.titleStyle,
    this.xAxisLabel,
    this.yAxisLabel,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedMaxY = maxY ?? _calculateMaxY();
    final calculatedMinY = minY ?? _calculateMinY();
    final calculatedMaxX = maxX ?? _calculateMaxX();
    final calculatedMinX = minX ?? 0;

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
              _buildLegend(),
              const SizedBox(height: 16),
            ],
            LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxWidth < 400 ? 200.0 : 250.0;

                return SizedBox(
                  height: height,
                  child: LineChart(
                    LineChartData(
                      minX: calculatedMinX,
                      maxX: calculatedMaxX,
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
                              final seriesName =
                                  series[touchedSpot.barIndex].name;
                              return LineTooltipItem(
                                '$seriesName\n${touchedSpot.y.toStringAsFixed(1)}',
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
                      lineBarsData: series.asMap().entries.map((entry) {
                        final index = entry.key;
                        final serie = entry.value;
                        final color = serie.color ?? _getDefaultColor(index);

                        return LineChartBarData(
                          spots: serie.data,
                          isCurved: serie.isCurved ?? isCurved,
                          color: color,
                          barWidth: serie.lineWidth ?? 3,
                          dotData: FlDotData(
                            show: serie.showDots ?? showDots,
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
                            show: serie.showArea ?? showArea,
                            gradient: LinearGradient(
                              colors: [
                                color.withValues(alpha: 0.3),
                                color.withValues(alpha: 0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          dashArray: serie.dashArray,
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

  Widget _buildLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: series.asMap().entries.map((entry) {
        final index = entry.key;
        final serie = entry.value;
        final color = serie.color ?? _getDefaultColor(index);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 3,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              serie.name,
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

  double _calculateMaxY() {
    if (series.isEmpty) return 100;
    double max = double.negativeInfinity;
    for (var serie in series) {
      for (var spot in serie.data) {
        if (spot.y > max) max = spot.y;
      }
    }
    return max * 1.1;
  }

  double _calculateMinY() {
    if (series.isEmpty) return 0;
    double min = double.infinity;
    for (var serie in series) {
      for (var spot in serie.data) {
        if (spot.y < min) min = spot.y;
      }
    }
    return min < 0 ? min * 1.1 : 0;
  }

  double _calculateMaxX() {
    if (series.isEmpty) return 10;
    double max = double.negativeInfinity;
    for (var serie in series) {
      for (var spot in serie.data) {
        if (spot.x > max) max = spot.x;
      }
    }
    return max;
  }

  Color _getDefaultColor(int index) {
    final colors = [
      Colors.purple,
      Colors.cyan,
      Colors.orange,
      Colors.pink,
    ];
    return colors[index % colors.length];
  }
}

/// Chart Line Series Data Model
class ChartLineSeriesData {
  final String name;
  final List<FlSpot> data;
  final Color? color;
  final double? lineWidth;
  final bool? isCurved;
  final bool? showDots;
  final bool? showArea;
  final List<int>? dashArray;

  ChartLineSeriesData({
    required this.name,
    required this.data,
    this.color,
    this.lineWidth,
    this.isCurved,
    this.showDots,
    this.showArea,
    this.dashArray,
  });
}
