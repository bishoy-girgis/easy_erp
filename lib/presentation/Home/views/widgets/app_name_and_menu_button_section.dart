import 'package:flutter/material.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/widgets/text_builder.dart';

class AppNameAndMenuButtonSection extends StatelessWidget {
  const AppNameAndMenuButtonSection({
    super.key,
    required this.onMenuPressed,
  });
  final VoidCallback onMenuPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextBuilder(
          "Easy Erp App",
          isHeader: true,
        ),
        IconButton(
          icon: Icon(
            Icons.menu,
            color: AppColors.primaryColorBlue,
          ),
          onPressed: onMenuPressed,
        ),
      ],
    );
  }
}
