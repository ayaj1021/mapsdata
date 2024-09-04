
import 'package:flutter/material.dart';
import 'package:mapsdata/core/theme/app_colors.dart';

extension WidgetExtension on Widget {
  Widget withContainer({
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxShape shape = BoxShape.rectangle,
    Color? color,
    BoxBorder? border,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      alignment: alignment,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        border: border,
        color: color,
        shape: shape,
        borderRadius: borderRadius,
      ),
      child: this,
    );
  }

  Widget withLoadingList({
    required bool isLoading,
    double height = 50,
  }) {
    return isLoading
        ? ListView.separated(
            key: const ValueKey('loading'),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: height,
                  width: MediaQuery.sizeOf(context).width);
            },
          )
        : this;
  }

  Widget withLoadingWidget({
    required bool isLoading,
    double height = 30,
    double width = 100,
    Color? color,
    EdgeInsetsGeometry? margin,
    Widget? loadingWidget,
  }) {
    return isLoading
        ? loadingWidget ??
            Container(
              margin: margin,
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: color ?? AppColors.greyFill,
                borderRadius: BorderRadius.circular(16),
              ),
            )
        : this;
  }
}
