
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/theme/app_colors.dart';

/// [DsBottomSheet] is a bottomsheet widget built
/// with flutter widgets.
/// ### Params:
/// * [title] - An optional title of the view.
/// * [subtitle] - Optional subtitle of the view
/// * [width] - Optional preferred width of the view
/// * [height] - Optional preferred height of the view
/// * [content] - required body for the sheet where all your custom views
/// goes in.
///
class DsBottomSheet extends StatelessWidget {
  const DsBottomSheet({
    required this.content,
    super.key,
    this.title,
    this.height,
    this.width,
    this.subtitle,
    this.onExitTap,
    this.cancelPadding,
    this.titleWidget,
    this.padding,
    this.canExit = true,
    this.hasHeaders = true,
  });
  final String? title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget content;
  final double? height;
  final double? width;
  final GestureTapCallback? onExitTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? cancelPadding;
  final bool canExit;
  final bool hasHeaders;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ColorFilter.mode(
        Colors.black.withOpacity(0.2),
        BlendMode.srcOver,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * .95,
          minHeight: 100,
          minWidth: width ?? MediaQuery.of(context).size.width,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        padding: padding ?? const EdgeInsets.all(20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Center(
                      child: Container(
                        width: 100,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.primarysWatch.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    if (canExit) ...[
                      const Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          height: 40,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child:
                                SvgPicture.asset('assets/icons/close_icon.svg'),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (!canExit) 20.verticalSpace,
                Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: content,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
