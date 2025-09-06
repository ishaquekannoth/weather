import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/themes/colors.dart';
import 'package:weather/core/widgets/shared/text_widget.dart';
import 'package:weather/core/widgets/shared/ui_helpers.dart';

class GenericButton<T extends Object> extends StatelessWidget {
  final T buttonData;
  final bool? disabled;
  final String? buttonTitle;
  final Color? buttonColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final Size? buttonDimensions;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final bool suffixIcon;
  final bool? isLoading;
  final WidgetDataExporter<T> onTap;
  const GenericButton({
    super.key,
    this.suffixIcon = false,
    this.onTap,
    this.buttonTitle = "Button",
    this.isLoading = false,
    this.buttonColor,
    this.textStyle,
    this.buttonDimensions,
    this.borderRadius,
    this.margin,
    required this.buttonData,
    this.disabled = false,
    this.borderColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ScreenUtil().screenWidth,
      margin: margin ?? EdgeInsets.only(top: 16.h),
      height: buttonDimensions == null ? 40.h : buttonDimensions!.height,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap != null && disabled == false
            ? () => onTap?.call(buttonData)
            : null,
        child: Container(
          width: buttonDimensions == null ? 300.w : buttonDimensions!.width,
          height: buttonDimensions == null ? 60.h : buttonDimensions!.height,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            color: disabled! ? AppColors.grey : buttonColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: disabled!
                    ? AppColors.grey
                    : borderColor ?? AppColors.primaryColor,
              ),
              borderRadius: borderRadius ?? BorderRadius.circular(8),
            ),
          ),
          child: isLoading!
              ? CircularProgressIndicator(
                  backgroundColor: AppColors.white,
                  color: AppColors.primaryColor,
                )
              : TextWidget(text: buttonTitle!, textStyle: textStyle),
        ),
      ),
    );
  }
}
