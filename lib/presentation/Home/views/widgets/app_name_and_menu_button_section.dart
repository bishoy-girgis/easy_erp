import 'package:flutter/material.dart';

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
        const TextBuilder(
          "Easy Erp App",
          isHeader: true,
        ),
        IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.blueGrey,
          ),
          onPressed: onMenuPressed,
        ),
      ],
    );
  }
}
