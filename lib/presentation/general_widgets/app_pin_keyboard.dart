
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_otp_field.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';

class PayOffPinKeyboard extends StatefulWidget {
  final void Function(String) onChanged;
  final int length;

  const PayOffPinKeyboard({
    super.key,
    required this.onChanged,
    this.length = 4,
  });

  @override
  State<PayOffPinKeyboard> createState() => _PayOffPinKeyboardState();
}

class _PayOffPinKeyboardState extends State<PayOffPinKeyboard> {
  TextEditingController _controller = TextEditingController();
  String pin = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DigitSendOtpField(
            boxHeight: 54,
            boxWidth: 54,
            controller: _controller,
            length: widget.length,
          ),
        ),
     VerticalSpacing(40),

        ///use the for loop to create the three rows for the keyboard
        for (var i = 0; i < 3; i++)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              ///generate a [_NumberButton] for each number in the row with the corresponding number as a child
              children: List.generate(
                3,
                (index) {
                  final number = (1 + 3 * i + index);
                  return _NumberButton(
                    number: number,
                    onPressed: () => _setInput(number.toString()),
                  );
                },
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const _NumberButton(number: 0, empty: true),
              _NumberButton(number: 0, onPressed: () => _setInput("0")),
              _NumberButton(
                  number: 0, onPressed: () => _delete(pin), isBackSpace: true),
            ],
          ),
        ),
      ],
    );
  }

  void _setInput(String number) {
    if (pin.length < widget.length) {
      pin += number;
      _controller.text = pin;
      setState(() {});
      widget.onChanged(pin);
    }
  }

  void _delete(String number) {
    if (pin.isNotEmpty) {
      pin = pin.substring(0, number.length - 1);
      _controller.text = pin;
      setState(() {});
      widget.onChanged(pin);
    }
  }
}

class _NumberButton extends StatelessWidget {
  final int number;
  final VoidCallback? onPressed;
  final bool isBackSpace, empty;
  const _NumberButton({
    required this.number,
    this.onPressed,
    this.isBackSpace = false,
    this.empty = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 54.w,
        height: 54.h,
        decoration: BoxDecoration(
            color: empty ? null : AppColors.greyFill,
            borderRadius: BorderRadius.circular(16)),
        child: empty
            ? const SizedBox()
            : isBackSpace
                ? Center(child: SvgPicture.asset('assets/icons/clear.svg'))
                : Center(
                    child: Text(
                      number.toString(),
                      style: context.textTheme.s16w400,
                    ),
                  ),
      ),
    );
  }
}
