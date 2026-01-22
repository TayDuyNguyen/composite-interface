import 'package:flutter/material.dart';
import 'package:myapp/core/extensions/color_extensions.dart';

/// Widget extensions for common operations
extension WidgetExtensions on Widget {
  /// Add padding to widget
  Widget padding(EdgeInsets padding) => Padding(padding: padding, child: this);

  /// Add symmetric padding to widget
  Widget paddingSymmetric({double? horizontal, double? vertical}) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    child: this,
  );

  /// Add all sides padding to widget
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  /// Add only specific sides padding to widget
  Widget paddingOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left ?? 0,
      top: top ?? 0,
      right: right ?? 0,
      bottom: bottom ?? 0,
    ),
    child: this,
  );

  /// Center widget
  Widget center() => Center(child: this);

  /// Align widget
  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);

  /// Add margin to widget
  Widget margin(EdgeInsets margin) => Container(margin: margin, child: this);

  /// Add symmetric margin to widget
  Widget marginSymmetric({double? horizontal, double? vertical}) => Container(
    margin: EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    ),
    child: this,
  );

  /// Add all sides margin to widget
  Widget marginAll(double margin) =>
      Container(margin: EdgeInsets.all(margin), child: this);

  /// Add only specific sides margin to widget
  Widget marginOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) => Container(
    margin: EdgeInsets.only(
      left: left ?? 0,
      top: top ?? 0,
      right: right ?? 0,
      bottom: bottom ?? 0,
    ),
    child: this,
  );

  /// Add expanded widget
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Add flexible widget
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// Add sized box with width
  Widget width(double width) => SizedBox(width: width, child: this);

  /// Add sized box with height
  Widget height(double height) => SizedBox(height: height, child: this);

  /// Add sized box with width and height
  Widget size(double width, double height) =>
      SizedBox(width: width, height: height, child: this);

  /// Add sized box with square dimensions
  Widget square(double dimension) =>
      SizedBox(width: dimension, height: dimension, child: this);

  /// Add opacity to widget
  Widget opacity(double opacity) => Opacity(opacity: opacity, child: this);

  /// Add visibility to widget
  Widget visible({required bool visible}) =>
      Visibility(visible: visible, child: this);

  /// Add clip rounded rectangle to widget
  Widget clipRRect(BorderRadius borderRadius) =>
      ClipRRect(borderRadius: borderRadius, child: this);

  /// Add clip oval to widget
  Widget clipOval() => ClipOval(child: this);

  /// Add decoration to widget
  Widget decorated({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
  }) => DecoratedBox(
    decoration: BoxDecoration(
      color: color,
      image: image,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      gradient: gradient,
    ),
    child: this,
  );

  /// Add background color to widget
  Widget backgroundColor(Color color) => ColoredBox(color: color, child: this);

  /// Add border to widget
  Widget border({
    Color? color,
    double width = 1.0,
    BorderStyle style = BorderStyle.solid,
  }) => DecoratedBox(
    decoration: BoxDecoration(
      border: Border.all(
        color: color ?? Colors.black,
        width: width,
        style: style,
      ),
    ),
    child: this,
  );

  /// Add rounded border to widget
  Widget roundedBorder({
    Color? color,
    double width = 1.0,
    double radius = 8.0,
  }) => DecoratedBox(
    decoration: BoxDecoration(
      border: Border.all(color: color ?? Colors.black, width: width),
      borderRadius: BorderRadius.circular(radius),
    ),
    child: this,
  );

  /// Add shadow to widget
  Widget shadow({
    Color color = Colors.black,
    double blurRadius = 4.0,
    double spreadRadius = 0.0,
    Offset offset = const Offset(0, 2),
  }) => DecoratedBox(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: color.withAlphaValue(0.1),
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
          offset: offset,
        ),
      ],
    ),
    child: this,
  );

  /// Add gesture detector to widget
  Widget onTap(VoidCallback onTap) =>
      GestureDetector(onTap: onTap, child: this);

  /// Add long press gesture to widget
  Widget onLongPress(VoidCallback onLongPress) =>
      GestureDetector(onLongPress: onLongPress, child: this);

  /// Add double tap gesture to widget
  Widget onDoubleTap(VoidCallback onDoubleTap) =>
      GestureDetector(onDoubleTap: onDoubleTap, child: this);

  /// Add ink well to widget
  Widget inkWell({
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    VoidCallback? onDoubleTap,
    Color? splashColor,
    Color? highlightColor,
    BorderRadius? borderRadius,
  }) => InkWell(
    onTap: onTap,
    onLongPress: onLongPress,
    onDoubleTap: onDoubleTap,
    splashColor: splashColor,
    highlightColor: highlightColor,
    borderRadius: borderRadius,
    child: this,
  );

  /// Add tooltip to widget
  Widget tooltip(String message) => Tooltip(message: message, child: this);

  /// Add hero widget
  Widget hero(Object tag) => Hero(tag: tag, child: this);

  /// Add safe area to widget
  Widget safeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) =>
      SafeArea(top: top, bottom: bottom, left: left, right: right, child: this);

  /// Add positioned widget
  Widget positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) => Positioned(
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    width: width,
    height: height,
    child: this,
  );

  /// Add transform widget
  Widget transform(Matrix4 transform) =>
      Transform(transform: transform, child: this);

  /// Add rotation to widget
  Widget rotate(double angle) => Transform.rotate(angle: angle, child: this);

  /// Add scale to widget
  Widget scale(double scale) => Transform.scale(scale: scale, child: this);

  /// Add translate to widget
  Widget translate(Offset offset) =>
      Transform.translate(offset: offset, child: this);
}
