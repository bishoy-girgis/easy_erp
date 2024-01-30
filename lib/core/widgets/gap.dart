import 'package:easy_erp/core/helper/utils.dart';
import 'package:flutter/material.dart';

class GapH extends StatelessWidget {
  const GapH({super.key, required this.h});
  final double h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Utils(context: context).screenSize.height * (h / 100),
    );
  }
}

class GapW extends StatelessWidget {
  const GapW({super.key, required this.w});
  final double w;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Utils(context: context).screenSize.width * (w / 100),
    );
  }
}
