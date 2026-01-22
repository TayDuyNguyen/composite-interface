import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Scatter Chart Component
/// Generic, reusable scatter chart for showing data point distributions
class BaseScatterChart extends StatelessWidget {
  final String title;
  final List<ChartScatterData> data;
  final double? maxX;
  final double? minX;
  final double? maxY;
  final double? minY;
  final double? dotSize;
  final bool showGrid;
  final bool showBorder;
  final String? xAxisLabel;
  final String? yAxisLabel;
  final TextStyle? titleStyle;
  final Color? gridColor;
  final List<String>? xLabels;
  final List<String>? yLabels;
  final Duration animationDuration;
  final Curve animationCurve;

  const BaseScatterChart({
    super.key,
    required this.title,
    required this.data,
    this.maxX,
    this.minX,
    this.maxY,
    this.minY,
    this.dotSize = 12,
    this.showGrid = true,
    this.showBorder = false,
    this.xAxisLabel,
    this.yAxisLabel,
    this.titleStyle,
    this.gridColor,
    this.xLabels,
    this.yLabels,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedMaxX = maxX ?? _calculateMaxX();
    final calculatedMinX = minX ?? 0;
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
                  child: ScatterChart(
                    ScatterChartData(
                      minX: calculatedMinX,
                      maxX: calculatedMaxX,
                      minY: calculatedMinY,
                      maxY: calculatedMaxY,
                      scatterSpots: data.map((item) {
                        return ScatterSpot(
                          item.x,
                          item.y,
                          dotPainter: FlDotCirclePainter(
                            color: item.color ?? Colors.blue,
                            radius: item.size ?? dotSize!,
                          ),
                        );
                      }).toList(),
                      scatterTouchData: ScatterTouchData(
                        enabled: true,
                        touchTooltipData: ScatterTouchTooltipData(
                          getTooltipItems: (ScatterSpot spot) {
                            final index = data.indexWhere(
                                (d) => d.x == spot.x && d.y == spot.y);
                            final label = index >= 0 ? data[index].label : '';
                            return ScatterTooltipItem(
                              '$label\nX: ${spot.x.toStringAsFixed(1)}\nY: ${spot.y.toStringAsFixed(1)}',
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      gridData: FlGridData(
                        show: showGrid,
                        drawVerticalLine: true,
                        drawHorizontalLine: true,
                        horizontalInterval:
                            (calculatedMaxY - calculatedMinY) / 5,
                        verticalInterval: (calculatedMaxX - calculatedMinX) / 5,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: gridColor ?? Colors.grey.shade200,
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: gridColor ?? Colors.grey.shade200,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      borderData: FlBorderData(
                        show: showBorder,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              if (yLabels != null &&
                                  value.toInt() < yLabels!.length) {
                                return Text(
                                  yLabels![value.toInt()],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                );
                              }
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
                            getTitlesWidget: (value, meta) {
                              if (xLabels != null &&
                                  value.toInt() < xLabels!.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    xLabels![value.toInt()],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              }
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
                    ),
                    duration: animationDuration,
                    curve: animationCurve,
                  ),
                );
              },
            ),
            if (xAxisLabel != null || yAxisLabel != null) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (xAxisLabel != null)
                    Text(
                      xAxisLabel!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _calculateMaxX() {
    if (data.isEmpty) return 10;
    return data.map((e) => e.x).reduce((a, b) => a > b ? a : b) * 1.1;
  }

  double _calculateMaxY() {
    if (data.isEmpty) return 10;
    return data.map((e) => e.y).reduce((a, b) => a > b ? a : b) * 1.1;
  }
}

/// Chart Scatter Data Model
class ChartScatterData {
  final double x;
  final double y;
  final String label;
  final Color? color;
  final double? size;

  ChartScatterData({
    required this.x,
    required this.y,
    required this.label,
    this.color,
    this.size,
  });
}
