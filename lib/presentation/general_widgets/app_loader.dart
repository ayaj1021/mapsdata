import 'package:flutter/material.dart';
import 'package:flutter_load_kit/flutter_load_kit.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key, this.color = Colors.white});
  final Color color;

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  @override
  Widget build(BuildContext context) {
    return const LoadKitLineChase(
      itemCount: 3,
    );
  }
}
