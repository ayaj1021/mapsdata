
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/core/utils/typedefs.dart';
import 'package:mapsdata/presentation/general_widgets/app_loader.dart';

class AppOverLay extends StatefulWidget {
  const AppOverLay({
    required this.child,
    required this.controller,
    super.key,
    this.messagePadding,
  });
  final Widget child;
  final OverLayController controller;
  final EdgeInsetsGeometry? messagePadding;

  @override
  State<AppOverLay> createState() => AppOverLayState();

  static AppOverLayState of(BuildContext context) {
    final result = context.findAncestorStateOfType<AppOverLayState>();
    if (result != null) return result;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
        '''AppOverLay.of() called with a context that does not contain a AppOverLay.''',
      ),
      ErrorDescription(
        '''No AppOverLay ancestor could be found starting from the context that was passed to AppOverLay.of(). '''
        '''This usually happens when the context provided is from the same StatefulWidget as that '''
        '''whose build function actually creates the AppOverLay widget being sought.''',
      ),
      context.describeElement('The context used was'),
    ]);
  }
}

class AppOverLayState extends State<AppOverLay> {
  OverLayController get controller => widget.controller;
  double scale = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        widget.child,
        ValueListenableBuilder<
            ({OverLayType type, MessageText? msg, Color? color})>(
          valueListenable: widget.controller._valueNotifier,
          builder: (context, listen, child) {
            if (listen.type == OverLayType.loader) {
              return Positioned.fill(
                child: Material(
                  color: Colors.black.withOpacity(.5),
                  child: AppLoader(
                    color: listen.color ?? Colors.white,
                  ),
                ),
              );
            } else if (listen.type == OverLayType.message) {
              return SafeArea(
                child: Container(
                  padding: widget.messagePadding ?? const EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: -40, end: 0),
                    curve: Curves.easeInOut,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: _messageWidget(
                          messageIcon:
                              listen.msg?.messageType == MessageType.error
                                  ? 'assets/icons/error.svg'
                                  : 'assets/icons/success.svg',
                          messageText: listen.msg,
                          messageColor:
                              listen.msg?.messageType == MessageType.error
                                  ? AppColors.primaryColor
                                  : AppColors.primary005304,
                          onClose: () {
                            controller.removeOverLay();
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            } else if (listen.type == OverLayType.toast) {
              return SafeArea(
                child: Container(
                  padding: widget.messagePadding ?? const EdgeInsets.all(20),
                  alignment: Alignment.bottomCenter,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: -20, end: 0),
                    curve: Curves.easeInOut,
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: _toastWidget(
                          messageText: listen.msg!,
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _messageWidget({
    required MessageText? messageText,
    required String messageIcon,
    required Color messageColor,
    required VoidCallback onClose,
  }) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: messageText?.messageType == MessageType.error
              ? AppColors.red
              : AppColors.greenC1F3D3,
        ),
      ),
      color: messageText?.messageType == MessageType.error
          ? const Color(0XFFFFF2F2)
          : AppColors.greenEBFFED,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: 63,
          maxWidth: MediaQuery.of(context).size.width,
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              messageIcon,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (messageText?.title != null)
                    Text(
                      messageText!.title,
                      style: Theme.of(context).textTheme.s12w700.copyWith(
                            color: messageColor,
                          ),
                      textDirection: TextDirection.ltr,
                    ),
                  Text(
                    messageText?.message ?? '',
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.s12w400.copyWith(
                          color: messageColor,
                        ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toastWidget({
    required MessageText messageText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.greyFill,
      ),
      width: 200.w,
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Image.asset(
            'assets/icons/logo.png',
            fit: BoxFit.scaleDown,
            height: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            messageText.message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.s12w400.copyWith(
                  color: AppColors.primary1D1446,
                ),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}

class OverLayController {
  final ValueNotifier<({OverLayType type, MessageText? msg, Color? color})>
      _valueNotifier =
      ValueNotifier((type: OverLayType.none, msg: null, color: null));

  void showLoader({Color? color}) {
    _valueNotifier.value = (type: OverLayType.loader, msg: null, color: color);
  }

  void showError({required String message, String? title}) {
    _valueNotifier.value = (
      type: OverLayType.message,
      msg: (
        message: message,
        title: title ?? 'Error',
        messageType: MessageType.error
      ),
      color: AppColors.red,
    );
    Future.delayed(const Duration(seconds: 3), removeOverLay);
  }

  void showSuccess({required String message, String? title}) {
    _valueNotifier.value = (
      type: OverLayType.message,
      msg: (
        message: message,
        title: title ?? 'Success',
        messageType: MessageType.success
      ),
      color: AppColors.green,
    );
    Future.delayed(const Duration(seconds: 3), removeOverLay);
  }

  void showToast({
    required String message,
  }) {
    _valueNotifier.value = (
      type: OverLayType.toast,
      msg: (
        message: message,
        title: '',
        messageType: MessageType.success,
      ),
      color: AppColors.red,
    );
    Future.delayed(const Duration(milliseconds: 1500), removeOverLay);
  }

  void removeOverLay() {
    _valueNotifier.value = (type: OverLayType.none, msg: null, color: null);
  }

  void dispose() => _valueNotifier.dispose();
}
