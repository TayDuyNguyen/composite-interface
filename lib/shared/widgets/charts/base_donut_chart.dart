import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// Base Donut Chart Component
/// Generic, reusable donut chart (pie chart with center space)
class BaseDonutChart extends StatelessWidget {
  final String title;
  final List<ChartDonutData> data;
  final double? radius;
  final double? centerSpaceRadius;
  final bool showLegend;
  final bool showPercentage;
  final Widget? centerWidget;
  final TextStyle? titleStyle;
  final double? sectionSpace;
  final bool animate;
  final Duration animationDuration;
  final Curve animationCurve;

  const BaseDonutChart({
    super.key,
    required this.title,
    required this.data,
    this.radius,
    this.centerSpaceRadius = 60,
    this.showLegend = true,
    this.showPercentage = true,
    this.centerWidget,
    this.titleStyle,
    this.sectionSpace = 2,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeInOut,
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
                final calculatedRadius = radius ?? (size / 2.5);

                return SizedBox(
                  height: size,
                  child: Row(
                    children: [
                      Expanded(
                        flex: showLegend ? 3 : 1,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PieChart(
                              PieChartData(
                                sectionsSpace: sectionSpace,
                                centerSpaceRadius: centerSpaceRadius,
                                sections: data.asMap().entries.map((entry) {
                                  final percentage =
                                      (entry.value.value / totalValue * 100);
                                  return PieChartSectionData(
                                    value: entry.value.value,
                                    title: showPercentage
                                        ? '${percentage.toStringAsFixed(1)}%'
                                        : '',
                                    color: entry.value.color ??
                                        _getDefaultColor(entry.key),
                                    radius: calculatedRadius,
                                    titleStyle: entry.value.titleStyle ??
                                        const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  );
                                }).toList(),
                                pieTouchData: PieTouchData(
                                  enabled: true,
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    // Handle touch if needed
                                  },
                                ),
                              ),
                              duration: animationDuration,
                              curve: animationCurve,
                            ),
                            if (centerWidget != null)
                              centerWidget!
                            else
                              _buildDefaultCenterWidget(totalValue),
                          ],
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

  Widget _buildDefaultCenterWidget(double totalValue) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Total',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          totalValue.toStringAsFixed(0),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
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
                    borderRadius: BorderRadius.circular(4),
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
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.red,
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

/// Chart Donut Data Model
class ChartDonutData {
  final String label;
  final double value;
  final Color? color;
  final TextStyle? titleStyle;

  ChartDonutData({
    required this.label,
    required this.value,
    this.color,
    this.titleStyle,
  });
}
