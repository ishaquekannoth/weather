import 'package:flutter/material.dart';
import 'package:weather/core/widgets/shared/ui_helpers.dart';


class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    this.height,
    this.width,
    this.margin,
    required this.text,
    this.textStyle,
    this.textAlign,
    this.padding,
    this.alignment,
    this.onTap,
    this.maxLines,
  });
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String text;
  final TextAlign? textAlign;
  final AlignmentGeometry? alignment;
  final TextStyle? textStyle;
  final int? maxLines;
  final WidgetDataExporter<String> onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: height,
      padding: padding,
      width: width,
      margin: margin,
      child: GestureDetector(
        onTap: onTap != null ? () => onTap!(text) : null,
        child: Text(
          text,
          maxLines: maxLines ?? 1,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign ?? TextAlign.center,
          style: textStyle,
        ),
      ),
    );
  }
}
