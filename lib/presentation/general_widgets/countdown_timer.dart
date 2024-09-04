
import 'package:flutter/material.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';

class _CountDownTimer extends AnimatedWidget {
  const _CountDownTimer({required this.animation, super.key})
      : super(listenable: animation);
  final Animation<int> animation;

  @override
  Text build(BuildContext context) {
    final clockTimer = Duration(seconds: animation.value);

    final minutes =
        clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Text(
      '$minutes:$seconds',
      style: context.textTheme.s12w400.copyWith(
        color: AppColors.primaryA29FB3,
      ),
    );
  }
}

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({
    required this.startTimer,
    super.key,
    this.onTimerEnd,
  });
  final bool startTimer;
  final void Function()? onTimerEnd;

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1),
    )
      ..addListener(
        () {
          if (animationController.isCompleted) {
            _stopTimer();
            widget.onTimerEnd?.call();
          }
        },
      )
      ..forward();
  }

  void _startTimer() {
    animationController.forward();
  }

  void _stopTimer() {
    animationController.stop();
  }

  @override
  void didUpdateWidget(covariant CountDownTimer oldWidget) {
    if (widget.startTimer && !oldWidget.startTimer) {
      _startTimer();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CountDownTimer(
      animation: StepTween(
        begin: 60,
        end: 0,
      ).animate(animationController),
    );
  }
}
