import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Radar Chart Component
/// Generic, reusable radar/spider chart for multi-dimensional data comparison
class BaseRadarChart extends StatelessWidget {
  final String title;
  final List<ChartRadarData> series;
  final List<String> categories;
  final double? maxValue;
  final bool showGrid;
  final bool showLegend;
  final int? gridLevels;
  final TextStyle? titleStyle;
  final TextStyle? categoryStyle;
  final Duration animationDuration;
  final Curve animationCurve;

  const BaseRadarChart({
    super.key,
    required this.title,
    required this.series,
    required this.categories,
    this.maxValue,
    this.showGrid = true,
    this.showLegend = true,
    this.gridLevels = 5,
    this.titleStyle,
    this.categoryStyle,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedMaxValue = maxValue ?? _calculateMaxValue();

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
                final size = math.min(constraints.maxWidth, 300.0);

                return SizedBox(
                  height: size,
                  child: RadarChart(
                    RadarChartData(
                      radarShape: RadarShape.polygon,
                      tickCount: gridLevels,
                      ticksTextStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.transparent,
                      ),
                      radarBorderData: BorderSide(
                        color: showGrid
                            ? Colors.grey.shade300
                            : Colors.transparent,
                        width: 1,
                      ),
                      gridBorderData: BorderSide(
                        color: showGrid
                            ? Colors.grey.shade200
                            : Colors.transparent,
                        width: 1,
                      ),
                      tickBorderData: BorderSide(
                        color: showGrid
                            ? Colors.grey.shade200
                            : Colors.transparent,
                        width: 1,
                      ),
                      getTitle: (index, angle) {
                        if (index >= categories.length) {
                          return const RadarChartTitle(text: ' ');
                        }
                        return RadarChartTitle(
                          text: categories[index],
                          angle: angle,
                          positionPercentageOffset: 0.15,
                        );
                      },
                      dataSets: series.asMap().entries.map((entry) {
                        final index = entry.key;
                        final data = entry.value;
                        final color = data.color ?? _getDefaultColor(index);

                        // Normalize values to 0-1 range based on maxValue
                        final normalizedValues = data.values
                            .map((v) => v / calculatedMaxValue)
                            .toList();

                        return RadarDataSet(
                          fillColor: color.withValues(alpha: 0.2),
                          borderColor: color,
                          borderWidth: 2.5,
                          entryRadius: 3,
                          dataEntries: normalizedValues
                              .map((value) => RadarEntry(value: value))
                              .toList(),
                        );
                      }).toList(),
                      radarTouchData: RadarTouchData(
                        enabled: true,
                        touchCallback: (FlTouchEvent event, response) {
                          // Handle touch if needed
                        },
                      ),
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
        final data = entry.value;
        final color = data.color ?? _getDefaultColor(index);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              data.name,
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

  double _calculateMaxValue() {
    if (series.isEmpty) return 100;
    double max = 0;
    for (var data in series) {
      for (var value in data.values) {
        if (value > max) max = value;
      }
    }
    return max * 1.1;
  }

  Color _getDefaultColor(int index) {
    final colors = [
      Colors.purple,
      Colors.cyan,
    ];
    return colors[index % colors.length];
  }
}

/// Chart Radar Data Model
class ChartRadarData {
  final String name;
  final List<double> values;
  final Color? color;

  ChartRadarData({
    required this.name,
    required this.values,
    this.color,
  });
}
