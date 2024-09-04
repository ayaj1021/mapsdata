import 'package:flutter/material.dart';
import 'package:mapsdata/presentation/general_widgets/app_overlay.dart';

extension AppOverLayExt on BuildContext {
  void showLoading({Color color = Colors.white}) =>
      AppOverLay.of(this).controller.showLoader(color: color);
  void hideOverLay() => AppOverLay.of(this).controller.removeOverLay();

  void showError({
    required String message,
    String? title,
  }) {
    return AppOverLay.of(this)
        .controller
        .showError(message: message, title: title);
  }

  void showSuccess({
    required String message,
    String? title,
  }) {
    return AppOverLay.of(this)
        .controller
        .showSuccess(message: message, title: title);
  }

  void showToast({
    required String message,
  }) {
    AppOverLay.of(this).controller.showToast(
          message: message,
        );
  }
}
