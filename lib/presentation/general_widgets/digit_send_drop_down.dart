
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapsdata/core/extensions/string_extensions.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/core/utils/validators.dart';
import 'package:mapsdata/presentation/general_widgets/digit_send_form_field.dart';
import 'package:mapsdata/presentation/general_widgets/ds_bottom_sheet.dart';

class DsSelector<T> extends StatefulWidget {
  const DsSelector({
    required this.menuList,
    required this.onChanged,
    required this.initialDisplayValue,
    required this.label,
    this.hasError = false,
    this.prefixIcon,
    super.key,
    this.labelSize,
    this.childPadding = EdgeInsets.zero,
    this.borderColor = AppColors.primaryColor,
    this.icon,
    this.onTap,
    this.labelWidget,
    this.isLoading = false,
  });
  final List<(String, T)> menuList;
  final void Function(T) onChanged;
  final String label;
  final double? labelSize;
  final bool hasError;
  final EdgeInsetsGeometry childPadding;
  final Color borderColor;
  final Widget? prefixIcon;
  final Widget? icon;
  final Widget? labelWidget;
  final String? initialDisplayValue;
  final Future<T?> Function(List<(String, T)> menuList)? onTap;
  final bool isLoading;

  @override
  State<DsSelector<T>> createState() => _DsSelectorState<T>();
}

class _DsSelectorState<T> extends State<DsSelector<T>> {
  @override
  void didUpdateWidget(covariant DsSelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDisplayValue != oldWidget.initialDisplayValue) {
      _usernamecontroller = TextEditingController(
        text: widget.initialDisplayValue,
      );
      setState(() {});
    }
  }

  late TextEditingController _usernamecontroller;

  @override
  void initState() {
    super.initState();
    _usernamecontroller = TextEditingController(
      text: widget.initialDisplayValue,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _usernamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DSFormfield(
      validateFunction: Validators.notEmpty(),
      onTap: () async {
        if (widget.isLoading) {
          return;
        }
        T? r;
        if (widget.onTap != null) {
          r = await widget.onTap?.call(widget.menuList);
        } else {
          r = await showModalBottomSheet<T?>(
            context: context,
            builder: (_) => _DropDownSheet<T?>(menuList: widget.menuList),
          );
        }
        if (r != null) {
          widget.onChanged(r);
          _usernamecontroller.text = widget.menuList
              .firstWhere((element) => element.$2 == r)
              .$1
              .capitalize;
        }
      },
      readOnly: true,
      controller: _usernamecontroller,
      hintText: widget.label,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator.adaptive(),
            )
          : SvgPicture.asset(
              'assets/icons/dropdown.svg',
              fit: BoxFit.scaleDown,
            ),
    );
  }
}

class _DropDownSheet<T> extends StatelessWidget {
  const _DropDownSheet({required this.menuList, super.key});
  final List<(String, T)> menuList;

  @override
  Widget build(BuildContext context) {
    return DsBottomSheet(
      content: Column(
        children: [
          Text(
            'Select Gender',
            style: context.textTheme.s24w700,
          ),
          for (var i = 0; i < menuList.length; i++)
            ListTile(
              title: Text(menuList[i].$1.capitalize),
              onTap: () {
                Navigator.of(context).pop(menuList[i].$2);
              },
            ),
        ],
      ),
    );
  }
}
