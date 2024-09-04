import 'package:flutter/material.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/general_widgets/app_loader.dart';

class MapsDataSendButton extends StatefulWidget {
  const MapsDataSendButton({
    required this.onTap,
    required this.title,
    super.key,
    this.isEnabled = true,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.hasBorder = false,
    this.isLoading = false,
    this.width = double.infinity,
  });

  final bool isEnabled;
  final Color backgroundColor;
  final Color textColor;
  final bool hasBorder;
  final String title;
  final void Function() onTap;
  final bool isLoading;
  final double width;

  @override
  State<MapsDataSendButton> createState() => _MapsDataSendButtonState();
}

class _MapsDataSendButtonState extends State<MapsDataSendButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: GestureDetector(
        onTap: widget.isEnabled ? widget.onTap : null,
        child: Container(
          alignment: Alignment.center,
        
          decoration: BoxDecoration(
              // gradient: const LinearGradient(
              //   colors: [
              //     Color(0xff1F10B2),
              //     Color(0xffFFFFFF),
              //   ],
              //   begin: Alignment.centerLeft,
              //   end: Alignment.centerRight,
              // ),
              color: widget.isEnabled ? widget.backgroundColor : Colors.grey,
              borderRadius: BorderRadius.circular(16),
              border: Border.fromBorderSide(
                widget.hasBorder
                    ? const BorderSide(color: AppColors.primary1D1446)
                    : BorderSide.none,
              )),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: widget.isLoading
                ? const Center(child: AppLoader())
                : Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
