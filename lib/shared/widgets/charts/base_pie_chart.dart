import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Pie Chart Component
/// Generic, reusable pie chart that accepts any data
class BasePieChart extends StatelessWidget {
  final String title;
  final List<ChartPieData> data;
  final double? radius;
  final double? centerSpaceRadius;
  final bool showLegend;
  final bool showPercentage;
  final bool showValue;
  final TextStyle? titleStyle;
  final double? sectionSpace;
  final BorderSide? borderSide;
  final Duration animationDuration;
  final Curve animationCurve;

  const BasePieChart({
    super.key,
    required this.title,
    required this.data,
    this.radius,
    this.centerSpaceRadius = 0,
    this.showLegend = true,
    this.showPercentage = true,
    this.showValue = false,
    this.titleStyle,
    this.sectionSpace = 0,
    this.borderSide,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    final double totalValue = data.fold(0, (sum, item) => sum + item.value);

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
                final size = constraints.maxWidth < 300 ? 200.0 : 250.0;
                final calculatedRadius = radius ?? (size / 2);

                return SizedBox(
                  height: size,
                  child: Row(
                    children: [
                      Expanded(
                        flex: showLegend ? 3 : 1,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: sectionSpace,
                            centerSpaceRadius: centerSpaceRadius,
                            sections: data.asMap().entries.map((entry) {
                              final percentage =
                                  (entry.value.value / totalValue * 100);
                              return PieChartSectionData(
                                value: entry.value.value,
                                title:
                                    _buildSectionTitle(entry.value, percentage),
                                color: entry.value.color ??
                                    _getDefaultColor(entry.key),
                                radius: calculatedRadius,
                                titleStyle: entry.value.titleStyle ??
                                    const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                badgeWidget: entry.value.badgeWidget,
                                badgePositionPercentageOffset:
                                    entry.value.badgePositionOffset ?? 1.2,
                                borderSide: borderSide ?? BorderSide.none,
                              );
                            }).toList(),
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                // Handle touch interactions if needed
                              },
                            ),
                          ),
                          duration: animationDuration,
                          curve: animationCurve,
                        ),
                      ),
                      if (showLegend) ...[
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: _buildLegend(totalValue),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _buildSectionTitle(ChartPieData data, double percentage) {
    if (showPercentage && showValue) {
      return '${percentage.toStringAsFixed(1)}%\n${data.value.toStringAsFixed(0)}';
    } else if (showPercentage) {
      return '${percentage.toStringAsFixed(1)}%';
    } else if (showValue) {
      return data.value.toStringAsFixed(0);
    }
    return '';
  }

  Widget _buildLegend(double totalValue) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: data.asMap().entries.map((entry) {
          final percentage = (entry.value.value / totalValue * 100);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: entry.value.color ?? _getDefaultColor(entry.key),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.value.label,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${entry.value.value.toStringAsFixed(0)} (${percentage.toStringAsFixed(1)}%)',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getDefaultColor(int index) {
    final colors = [
      Colors.purple,
      Colors.cyan,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.indigo,
    ];
    return colors[index % colors.length];
  }
}

/// Chart Pie Data Model
class ChartPieData {
  final String label;
  final double value;
  final Color? color;
  final TextStyle? titleStyle;
  final Widget? badgeWidget;
  final double? badgePositionOffset;

  ChartPieData({
    required this.label,
    required this.value,
    this.color,
    this.titleStyle,
    this.badgeWidget,
    this.badgePositionOffset,
  });
}
